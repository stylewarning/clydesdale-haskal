;;; File: module-parser         Author: John

;;; This is for using the parser to parse strings.

(define (parse-module-body-from-string mod-name body filename has-lines?)
 (dynamic-let ((*current-file* filename))
  (call-with-input-string body
    (lambda (port)
      (let ((tokens (if has-lines?
			(lex-port port '#f)
			(lex-port/nolines port))))
	(init-token-stream tokens)
	(let ((res (parse-modules/named mod-name '())))
	  (if (not (eq-token? 'eof))
	      (signal-leftover-tokens)
	      res)))))))

(define (signal-leftover-tokens)
  (fatal-error 'leftover-tokens
	       "Leftover tokens after parsing."))


;;; This file deals with the basic structure of a module.  It also adds
;;; the `module Main(main) where' required by abbreviated modules.

(define (parse-tokens tokens)
  (init-token-stream tokens)
  (let ((mod (token-case
	      (|module| (parse-module))
	      (else (parse-modules/named
		     '|Main|
		     (list (make entity-var (name '|main|))))))))
    (cons mod (parse-module-list))))

(define (parse-module)
  (token-case
   (modid (let* ((mod-name (token->symbol))
		 (exports (parse-exports)))
	    (require-token
	      |where|
	      (signal-missing-token "`where'" "module definition"))
	    (parse-modules/named mod-name exports)))
   (else (signal-missing-token "<modid>" "module definition"))))

(define (parse-module-list)
  (token-case
   (|module|
    (let ((mod (parse-module)))
      (cons mod (parse-module-list))))
   (eof '())
   (else (signal-missing-module))))

(define (signal-missing-module)
  (parser-error 'missing-module
		"Missing `module', or leftover junk after module definition."))

(define (parse-exports)
  (parse-commaized-list (function parse-entity-export) "export list"))

(define (parse-commaized-list fn context-msg)
  (token-case
   (\( (parse-commaized-list-aux fn context-msg))
   (else '())))

(define *parse-trailing-comma-ok* '#t)

(define (parse-commaized-list-aux fn context-msg)
  (let ((object  (funcall fn)))
    (token-case
     (\) (list object))
     (\, (token-case
	  (\) (if *parse-trailing-comma-ok*
		  (list object)
		  (signal-extra-comma context-msg)))
	  (else
	      (cons object (parse-commaized-list-aux fn context-msg)))))
     (else (signal-missing-token "`)' or ','" context-msg)))))

(define (signal-extra-comma context-msg)
  (parser-error 'extra-comma
		"Extra comma at end of ~a." context-msg))

(define (parse-modules/named mod-name exports)
  (trace-parser module
    (let ((mod-ast (make module
		     (name mod-name)
		     (type 'standard)
		     (exports exports)
		     (default *standard-module-default*))))
      (setf (ast-node-line-number mod-ast) (capture-current-line))
      (start-layout (lambda (in-layout?)
		      (parse-module-decls mod-ast in-layout? 'import '#f))))))

;;; The mod-ast fields are kept in non-reversed order by appending
;;; each decl to the end of the appropriate list.  This loses for
;;; value decls, so these are in reversed order!!

(define (parse-module-decls mod-ast in-layout? state last-was-decl?)
  (token-case
   (|import| (let ((import (parse-import)))
	       (if (eq? state 'import)
		   (push-decl-list import (module-imports mod-ast))
		   (signal-misplaced-import)))
	     (terminate-topdecl mod-ast in-layout? state))
   (|infix| (terminate-topdecl mod-ast in-layout?
			       (parse-fixity 'n mod-ast state)))
   (|infixl| (terminate-topdecl mod-ast in-layout?
				(parse-fixity 'l mod-ast state)))
   (|infixr| (terminate-topdecl mod-ast in-layout?
				(parse-fixity 'r mod-ast state)))
   (|data| (let ((data-decl (parse-type-decl '#f)))
	     (push-decl-list data-decl (module-algdatas mod-ast)))
	   (terminate-topdecl mod-ast in-layout? 'topdecl))
   (|type| (let ((synonym-decl (parse-synonym-decl)))
	     (push-decl-list synonym-decl (module-synonyms mod-ast)))
	   (terminate-topdecl mod-ast in-layout? 'topdecl))
   (|class| (let ((class-decl (parse-class-decl)))
	      (push-decl-list class-decl (module-classes mod-ast)))
	    (terminate-topdecl mod-ast in-layout? 'topdecl))
   (|instance| (let ((instance-decl (parse-instance-decl '#f '#f)))
		 (push-decl-list instance-decl (module-instances mod-ast)))
	       (terminate-topdecl mod-ast in-layout? 'topdecl))
   (|deriving| (let ((deriving-decl (parse-deriving-decl)))
		 (push-decl-list deriving-decl (module-derivings mod-ast)))
	       (terminate-topdecl mod-ast in-layout? 'topdecl))
   (|default| (let ((types 
		     (token-case
		      (\( (token-case (\) '())
				      (else (parse-type-list))))
		      (else
		       (signal-missing-token "`('" "default declaration")))))
		(if (eq? (module-default mod-ast) *standard-module-default*)
		    (setf (module-default mod-ast)
			  (make default-decl (types types)))
		    (signal-multiple-defaults)))
    (terminate-topdecl mod-ast in-layout? 'topdecl))
   ((begin-annotation no-advance)
    (let ((annotations (parse-annotations 'topdecl)))
      (setf (module-annotations mod-ast)
	    (append (module-annotations mod-ast) annotations)))
    (terminate-topdecl mod-ast in-layout? state))
   (pat-start (let ((decl (parse-decl)))
		(if last-was-decl?
		    (setf (module-decls mod-ast)
			  (decl-push decl (module-decls mod-ast)))
		    (push decl (module-decls mod-ast))))
	      (terminate-topdecl/in-decl mod-ast in-layout? 'topdecl))
   (else
    (maybe-end-module mod-ast in-layout? state))))

(define (signal-misplaced-import)
  (parser-error 'misplaced-import
		"The import declaration is misplaced."))

(define (signal-multiple-defaults)
  (parser-error 'multiple-defaults
		"There are multiple default declarations."))

(define (terminate-topdecl mod-ast in-layout? state)
  (token-case
   (\; (parse-module-decls mod-ast in-layout? state '#f))
   (else (maybe-end-module mod-ast in-layout? state))))

(define (terminate-topdecl/in-decl mod-ast in-layout? state)
  (token-case
   (\; (parse-module-decls mod-ast in-layout? state '#t))
   (else (maybe-end-module mod-ast in-layout? state))))

(define (maybe-end-module mod-ast in-layout? state)
  (declare (ignore state))
  (cond ((or (eq-token? '|module|) (eq-token? 'eof) (eq-token? '\})
	     (eq-token? '$\}))
	 (close-layout in-layout?)
	 (wrapup-module mod-ast)
	 mod-ast)
	(else
	 (signal-invalid-syntax "a topdecl"))))

(define (wrapup-module mod-ast)
  (setf (module-decls mod-ast)
	(nreverse (module-decls mod-ast)))
  (when (and (null? (module-imports mod-ast))
	     (null? (module-decls mod-ast))
	     (null? (module-algdatas mod-ast))
	     (null? (module-synonyms mod-ast))
	     (null? (module-instances mod-ast))
	     (null? (module-classes mod-ast))
	     (null? (module-derivings mod-ast)))
    (signal-empty-module)))

(define (signal-empty-module)
  (parser-error 'empty-module "Module definition is empty."))

(define (parse-import)
 (save-parser-context
  (token-case
   (modid (let ((mod (token->symbol))
		(mode 'all)
		(specs '()))
	    (token-case
	     (\( (setf mode 'by-name)
		 (token-case
		  (\) (setf specs '()))
		  (else (setf specs (parse-import-list)))))
	     (|hiding| (require-token
			 \(
			 (signal-missing-token "`('" "hiding clause"))
		       (setf specs (parse-import-list)))
	     (else '()))
	    (let ((renamings (token-case (|renaming|
					   (require-token
					     \(
					     (signal-missing-token
					       "`('" "renaming clause"))
					   (parse-renamings))
					 (else '()))))
	      (make import-decl (module-name mod) (mode mode) (specs specs)
		                (renamings renamings)))))
   (else
    (signal-missing-token "<modid>" "import declaration")))))

(define (parse-import-list)
  (parse-commaized-list-aux (function parse-entity-import) "import list"))

(define (parse-renamings)
  (parse-commaized-list-aux (function parse-renaming)
			    "import renaming clause"))

(define (parse-renaming)
  (save-parser-context
   (token-case
    (var (let ((name1 (var->symbol)))
	   (require-token
	    |to|
	    (signal-missing-token "`to'" "import renaming clause"))
	   (token-case
	    (var (let ((name2 (var->symbol)))
		   (make renaming (from name1) (to name2)
			 (referenced? '#f))))
	    (else (signal-invalid-syntax "import renaming clause")))))
    (con (let ((name1 (con->symbol)))
	   (require-token
	    |to| 
	    (signal-missing-token "`to'" "import renaming clause"))
	   (token-case
	    (con (let ((name2 (con->symbol)))
		   (make renaming (from name1) (to name2)
			 (referenced? '#f))))
	    (else (signal-invalid-syntax "import renaming clause")))))
    (else (signal-invalid-syntax "import renaming clause")))))


(define (parse-fixity associativity mod-ast state)
  (let ((fixity-decl
	 (save-parser-context
	  (let* ((prec (token-case
			(k (let ((p (token->integer)))
			     (cond ((<= p 9)
				    p)
				   (else
				    (signal-bad-fixity)
				    9))))
			(else 9)))
		 (ops (parse-op-list))
		 (fixity (make fixity (associativity associativity)
		       (precedence prec))))
	    (make fixity-decl (fixity fixity) (names ops))))))
    (push-decl-list fixity-decl (module-fixities mod-ast))
    (cond ((or (eq? state 'import)
	       (eq? state 'fixity))
	   'fixity)
	  (else
	   (signal-misplaced-fixity)
	   state))))


(define (signal-bad-fixity)
  (parser-error 'bad-fixity
		"Expecting fixity value of 0 - 9."))

(define (signal-misplaced-fixity)
  (parser-error 'misplaced-fixity "The fixity declaration is misplaced."))

(define (parse-op-list)
  (let ((name (token-case
	       (op (op->symbol))
	       (else (signal-missing-token "<op>" "fixity declaration")))))
    (token-case
     (\, (cons name (parse-op-list)))
     (else (list name)))))

(define (parse-entity-export)
  (parse-entity 'export))

(define (parse-entity-import)
  (parse-entity 'import))

(define (parse-entity context)
 (trace-parser entity
  (save-parser-context
   (token-case
    (var (var->entity))
    (tycon
     (let ((name (token->symbol)))
       (token-case
	(\( (token-case
	     (\.\. (require-token
		     '\)
		     (signal-missing-token "`)'" "class or datatype entity"))
		   (make entity-abbreviated (name name)))
	     (var (parse-entity-class name))
	     (con (parse-entity-datatype name))
	     (\) (make entity-class (name name) (methods '())))
	     (else (signal-invalid-syntax "an entity"))))
	(\.\. (if (eq? context 'export)
		  (make entity-module (name name))
		  (signal-invalid-syntax "an entity")))
	(else
	 (make entity-con (name name))))))
    (else (signal-invalid-syntax "an entity"))))))

(define (parse-entity-class class-name)
  (let ((vars (parse-var-list)))
    (make entity-class (name class-name) (methods vars))))

(define (parse-entity-datatype type-name)
  (let ((constrs (parse-con-list)))
    (make entity-datatype (name type-name) (constructors constrs))))

(define (parse-var-list)
  (parse-commaized-list-aux
   (lambda ()
     (token-case
      (var  (var->symbol))
      (else (signal-missing-token "<var>" "class entity"))))
   "class entity"))

(define (parse-con-list)
  (parse-commaized-list-aux
   (lambda ()
     (token-case
      (con  (con->symbol))
      (else (signal-missing-token "<con>" "datatype entity"))))
   "datatype entity"))
