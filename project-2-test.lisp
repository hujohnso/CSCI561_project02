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
  (test-case (exp->nnf '(xor a b)) '(and (or a b) (or (not a) (not b))))

  ; EXP->CNF
  ;Base cases/powerpoint cases
  (test-case (exp->cnf '(:iff A B)) '(and (or (NOT A) B) (or A (NOT B))))
  (test-case (exp->cnf '(:implies A B)) (or (not A) B))
  (test-case (exp->cnf '(:xor A B)) '(and (or (not A) (not B)) (or A B)))
  (test-case (exp->cnf '(not (not a))) 'a)
  (test-case (exp->cnf '(not (and a b))) '(OR (NOT A) (NOT B)))
  (test-case (exp->cnf '(or a (and b g))) '(and (or a b) (or a g)))
  (test-case (exp->cnf '(:implies (not (or a b) c))) '(or (not a) (not b) c))
  (test-case (exp->CNF '(:xor (not (or a b)) (and a c))) '(and (or (not b) a) (or (not a) c) (or (not b)) c))

  ; DPLL-UNIT-PROPAGATE
  (print "UP")
  (print (dpll-unit-propagate (cnf-maxterms '(and (or a b) (or (not b) c d))) '((a t))))
  ; (print (dpll (cnf-maxterms '(and (or a)))))
  ; (test-case (sat-p '(and (or a))) nil)
)
