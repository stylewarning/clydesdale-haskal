(SETF *WRITER-VERSION* '"Y2.2")
(SETF *MODULES-IMPORTED* (VECTOR (LOCATE-MODULE '|Prelude|) (LOCATE-MODULE '|PreludeArray|) (LOCATE-MODULE '|PreludeArrayInternal|) (LOCATE-MODULE '|PreludeComplex|) (LOCATE-MODULE '|PreludeCore|) (LOCATE-MODULE '|PreludeMonadicIO|) (LOCATE-MODULE '|PreludeContinuationIO|) (LOCATE-MODULE '|PreludeList|) (LOCATE-MODULE '|PreludeRatio|) (LOCATE-MODULE '|PreludeText|) (LOCATE-MODULE '|PreludeTuple|) (LOCATE-MODULE '|PreludeC|) (LOCATE-MODULE '|Symbol|) (LOCATE-MODULE '|Dynamic|) (LOCATE-MODULE '|DynamicInternal|) (LOCATE-MODULE '|PreludeDerivings|) (LOCATE-MODULE '|PreludeDynamicHandlers|) (LOCATE-MODULE '|DynamicPrims|) (LOCATE-MODULE '|SymbolPrims|) (LOCATE-MODULE '|PreludeBltinIO|) (LOCATE-MODULE '|PreludeTuplePrims|) (LOCATE-MODULE '|PreludeBltinArray|) (LOCATE-MODULE '|PreludePrims|) (LOCATE-MODULE '|DynamicPrims|) (LOCATE-MODULE '|SymbolPrims|) (LOCATE-MODULE '|PreludeBltinIO|) (LOCATE-MODULE '|PreludeTuplePrims|) (LOCATE-MODULE '|PreludeBltinArray|) (LOCATE-MODULE '|PreludePrims|) (LOCATE-MODULE '|DynamicPrims|) (LOCATE-MODULE '|SymbolPrims|) (LOCATE-MODULE '|PreludeBltinIO|) (LOCATE-MODULE '|PreludeTuplePrims|) (LOCATE-MODULE '|PreludeBltinArray|) (LOCATE-MODULE '|PreludePrims|) (LOCATE-MODULE '|Prelude|) (LOCATE-MODULE '|PreludeArray|) (LOCATE-MODULE '|PreludeArrayInternal|) (LOCATE-MODULE '|PreludeComplex|) (LOCATE-MODULE '|PreludeCore|) (LOCATE-MODULE '|PreludeMonadicIO|) (LOCATE-MODULE '|PreludeContinuationIO|) (LOCATE-MODULE '|PreludeList|) (LOCATE-MODULE '|PreludeRatio|) (LOCATE-MODULE '|PreludeText|) (LOCATE-MODULE '|PreludeTuple|) (LOCATE-MODULE '|PreludeC|) (LOCATE-MODULE '|Symbol|) (LOCATE-MODULE '|Dynamic|) (LOCATE-MODULE '|DynamicInternal|) (LOCATE-MODULE '|PreludeDerivings|) (LOCATE-MODULE '|PreludeDynamicHandlers|) (LOCATE-MODULE '|DynamicPrims|) (LOCATE-MODULE '|SymbolPrims|) (LOCATE-MODULE '|PreludeBltinIO|) (LOCATE-MODULE '|PreludeTuplePrims|) (LOCATE-MODULE '|PreludeBltinArray|) (LOCATE-MODULE '|PreludePrims|)))
(SETF *MODULES-LOADED* (VECTOR (MAKE MODULE (UNIT '|Main|) (NAME '|Main|) (TYPE 'STANDARD))))
(SETF *DEFS-REFERENCED* (MAKE-VECTOR 18))
(SET-DEF-N/VAR 0 0 'CONSTANT80771)
(SET-DEF-N/IMPORT 1 39 '|Int-type|)
(SET-DEF-N/VAR 2 0 'CONSTANT80782)
(SET-DEF-N/VAR 3 0 'CONSTANT80781)
(SET-DEF-N/IMPORT 4 39 '|List-type|)
(SET-DEF-N/VAR 5 0 'CONSTANT80780)
(SET-DEF-N/VAR 6 0 '|main|)
(SET-DEF-N/VAR 7 0 'CONSTANT80741)
(SET-DEF-N/VAR 8 0 'CONSTANT80789)
(SET-DEF-N/VAR 9 0 '|pascal|)
(SET-DEF-N/VAR 10 0 'CONSTANT80772)
(SET-DEF-N/VAR 11 0 'CONSTANT80790)
(SET-DEF-N/VAR 12 0 '|showRow|)
(SET-DEF-N/VAR 13 0 '|tab|)
(SET-DEF-N/VAR 14 0 '|showTriangle|)
(SET-DEF-N/VAR 15 0 '|Main-instances|)
(SET-DEF-N/VAR 16 0 'CONSTANT80760)
(SET-DEF-N/VAR 17 0 'CONSTANT80791)
(SETF *TYPES-REFERENCED* (MAKE-VECTOR 12))
(SET-TYPE-N 0 (NTYCON/DEF |*core-UnitType*|))
(SET-TYPE-N 1 (NTYCON/DEF |*core-IO*| 0))
(SET-TYPE-N 2 (NTYCON/DEF |*core-Int*|))
(SET-TYPE-N 3 (LIST/N 2))
(SET-TYPE-N 4 (LIST/N 3))
(SET-TYPE-N 5 (NTYCON/DEF |*core-ShowS*|))
(SET-TYPE-N 6 (ARROW/N 3 5))
(SET-TYPE-N 7 (ARROW/N 2 5))
(SET-TYPE-N 8 (NTYCON/DEF |*core-String*|))
(SET-TYPE-N 9 (ARROW/N 2 4 8 8))
(SET-TYPE-N 10 (**GTYVAR 0))
(SET-TYPE-N 11 (LIST/N 10))
(SETF *DUMP-FILE-NAMES* '("pascal.hs"))
(SETF (MODULE-STAND-ALONE? (LOOKUP-DEFINED-MOD 0)) COMMON-LISP:NIL)
(SETF (MODULE-UNRESOLVED-SYMBOLS (LOOKUP-DEFINED-MOD 0)) COMMON-LISP:NIL)
(SETF (MODULE-INTERFACE-DEFINITIONS (LOOKUP-DEFINED-MOD 0)) (LIST))
(SETF (MODULE-USES-STANDARD-PRELUDE? (LOOKUP-DEFINED-MOD 0)) T)
(SETF (MODULE-DEFAULT (LOOKUP-DEFINED-MOD 0)) (MAKE DEFAULT-DECL (TYPES (LIST (TYCON/DEF |*core-Int*|) (TYCON/DEF |*core-Double*|)))))
(SETF (MODULE-INSTANCE-DEFS (LOOKUP-DEFINED-MOD 0)) COMMON-LISP:NIL)
(SETF (MODULE-EXPORT-TABLE (LOOKUP-DEFINED-MOD 0)) (LET ((TAB (MAKE-TABLE))) (SET-EXPORT/DEF-N/LIST TAB '(14 13 12 9 6)) TAB))
(SETF (AST-NODE-LINE-NUMBER (LOOKUP-DEFINED-MOD 0)) (RESTORE-SOURCE-POINTER '0 '5))
(SETF (MODULE-FIXITY-TABLE (LOOKUP-DEFINED-MOD 0)) (MAKE-FIXITY-TABLE '((|.| R 9) (>> R 1) (&& R 3) ($ R 0) (% L 7) (|\\\\| N 5) (// L 9) (>>= R 1) (|notElem| N 4) (|elem| N 4) (^ R 8) (!! L 9) (++ R 5) (! L 9) (|\|\|| R 2) (^^ R 8))))
(SETF (MODULE-SYMBOL-TABLE (LOOKUP-DEFINED-MOD 0)) (LET ((TAB (MAKE-TABLE))) (SET-SYMTAB/DEF-N/LIST TAB '(17 16 15 14 13 3 12 11 10 9 8 5 7 6 2 0)) TAB))
(SET-VAR-VALUE 17 (MAKE-FLIC-APP/PACK |*core-MkSignature*| (MAKE-FLIC-PACK |*core-Nil*|) (MAKE-FLIC-REF/N 11)))
(INIT-VAR-SLOTS 17 COMMON-LISP:NIL T COMMON-LISP:NIL COMMON-LISP:NIL COMMON-LISP:NIL 'COMMON-LISP:NIL 'COMMON-LISP:NIL)
(SET-VAR-VALUE 16 (MAKE-FLIC-APP/PACK |*core-:*| (MAKE-FLIC-CONST 0) (MAKE-FLIC-PACK |*core-Nil*|)))
(INIT-VAR-SLOTS 16 COMMON-LISP:NIL T COMMON-LISP:NIL COMMON-LISP:NIL T 'COMMON-LISP:NIL 'COMMON-LISP:NIL)
(SET-VAR-VALUE 15 (MAKE-FLIC-PACK |*core-Nil*|))
(INIT-VAR-SLOTS 15 T T (GTYPE/NULL 1 11) T COMMON-LISP:NIL 'COMMON-LISP:NIL 'COMMON-LISP:NIL)
(INIT-FN-SLOTS 14 T T (GTYPE/NULL 0 9) COMMON-LISP:NIL COMMON-LISP:NIL 3 (STRICTNESS-N 12) '|Function Main:showTriangle| '0 '16)
(INIT-FN-SLOTS 13 T T (GTYPE/NULL 0 7) COMMON-LISP:NIL COMMON-LISP:NIL 2 (STRICTNESS-N 6) '|Function Main:tab| '0 '9)
(INIT-FN-SLOTS 12 T T (GTYPE/NULL 0 6) COMMON-LISP:NIL COMMON-LISP:NIL 2 (STRICTNESS-N 6) '|Function Main:showRow| '0 '13)
(SET-VAR-VALUE 11 (MAKE-FLIC-APP/PACK |*core-Tycon*| (MAKE-FLIC-REF/N 4) (MAKE-FLIC-REF/N 8)))
(INIT-VAR-SLOTS 11 COMMON-LISP:NIL T COMMON-LISP:NIL COMMON-LISP:NIL COMMON-LISP:NIL 'COMMON-LISP:NIL 'COMMON-LISP:NIL)
(SET-VAR-VALUE 10 (MAKE-FLIC-APP/PACK |*core-MkSignature*| (MAKE-FLIC-PACK |*core-Nil*|) (MAKE-FLIC-REF/N 0)))
(INIT-VAR-SLOTS 10 COMMON-LISP:NIL T COMMON-LISP:NIL COMMON-LISP:NIL COMMON-LISP:NIL 'COMMON-LISP:NIL 'COMMON-LISP:NIL)
(INIT-VAR-SLOTS 9 T T (GTYPE/NULL 0 4) COMMON-LISP:NIL COMMON-LISP:NIL '0 '6)
(SET-VAR-VALUE 8 (MAKE-FLIC-APP/PACK |*core-:*| (MAKE-FLIC-REF/N 3) (MAKE-FLIC-PACK |*core-Nil*|)))
(INIT-VAR-SLOTS 8 COMMON-LISP:NIL T COMMON-LISP:NIL COMMON-LISP:NIL T 'COMMON-LISP:NIL 'COMMON-LISP:NIL)
(SET-VAR-VALUE 7 (MAKE-FLIC-APP/PACK |*core-:*| (MAKE-FLIC-CONST 1) (MAKE-FLIC-PACK |*core-Nil*|)))
(INIT-VAR-SLOTS 7 COMMON-LISP:NIL T COMMON-LISP:NIL COMMON-LISP:NIL T 'COMMON-LISP:NIL 'COMMON-LISP:NIL)
(INIT-FN-SLOTS 6 T T (GTYPE/NULL 0 1) COMMON-LISP:NIL COMMON-LISP:NIL 1 (STRICTNESS-N 2) '|Function Main:main| '0 '19)
(SET-VAR-VALUE 2 (MAKE-FLIC-APP/PACK |*core-MkSignature*| (MAKE-FLIC-PACK |*core-Nil*|) (MAKE-FLIC-REF/N 3)))
(SET-VAR-VALUE 3 (MAKE-FLIC-APP/PACK |*core-Tycon*| (MAKE-FLIC-REF/N 4) (MAKE-FLIC-REF/N 5)))
(SET-VAR-VALUE 5 (MAKE-FLIC-APP/PACK |*core-:*| (MAKE-FLIC-REF/N 0) (MAKE-FLIC-PACK |*core-Nil*|)))
(INIT-VAR-SLOTS 5 COMMON-LISP:NIL T COMMON-LISP:NIL COMMON-LISP:NIL T 'COMMON-LISP:NIL 'COMMON-LISP:NIL)
(INIT-VAR-SLOTS 3 COMMON-LISP:NIL T COMMON-LISP:NIL COMMON-LISP:NIL COMMON-LISP:NIL 'COMMON-LISP:NIL 'COMMON-LISP:NIL)
(INIT-VAR-SLOTS 2 COMMON-LISP:NIL T COMMON-LISP:NIL COMMON-LISP:NIL COMMON-LISP:NIL 'COMMON-LISP:NIL 'COMMON-LISP:NIL)
(SET-VAR-VALUE 0 (MAKE-FLIC-APP/PACK |*core-Tycon*| (MAKE-FLIC-REF/N 1) (MAKE-FLIC-PACK |*core-Nil*|)))
(INIT-VAR-SLOTS 0 COMMON-LISP:NIL T COMMON-LISP:NIL COMMON-LISP:NIL COMMON-LISP:NIL 'COMMON-LISP:NIL 'COMMON-LISP:NIL)
