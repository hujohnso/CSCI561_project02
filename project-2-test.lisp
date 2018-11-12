; sbcl --load project-2.lisp --load project-2-test.lisp --eval '(run-tests)'

(defmacro test-case (stx result)
  `(let ((actual ,stx))
     (if (equal actual ,result)
       (format t "PASS")
       (format t "FAIL"))
     (format t " ~a == ~a, got ~a~%" (quote ,stx) ,result actual)))

(defun test-set-eq (a b) (test-case (set-difference a b) NIL))

(defun run-tests ()
  ; EXP->NNF
  (test-case (exp->nnf '(not (not a))) 'a)
  (test-case (exp->nnf '(not (and a b))) '(OR (NOT A) (NOT B)))
  (test-case (exp->nnf '(not (or a (not b)))) '(AND (NOT A) B))
  (test-case (exp->nnf '(not (:iff a b))) '(OR (AND A (NOT B)) (AND B (NOT A))))
)
