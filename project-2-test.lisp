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
<<<<<<< HEAD
  (test-case (exp->nnf '(not (not a))) 'a)
  (test-case (exp->nnf '(not (and a b))) '(OR (NOT A) (NOT B)))
  (test-case (exp->nnf '(not (or a (not b)))) '(AND (NOT A) B))
  (test-case (exp->nnf '(not (:iff a b))) '(OR (AND A (NOT B)) (AND B (NOT A))))
  (test-case (exp->nnf '(:xor a b)) '(and (or a b) (or (not a) (not b))))
  (test-case (exp->nnf '(:iff a b)) '(and (or (not a) b) (or (not b) a)))
  (test-case (exp->nnf '(:implies A B)) '(or (not A) B))

  ; EXP->CNF
  ;Base cases/powerpoint cases
  (test-case (exp->cnf '(:iff A B)) '(and  (or (NOT B) A)(or (NOT A) B))) 
  (test-case (exp->cnf '(:implies A B)) '(and (or (not A) B)))
  (test-case (exp->cnf '(:xor A B)) '(and (or (not A) (not B)) (or A B)))
  (test-case (exp->cnf '(not (not a))) '(and (or A)))
  (test-case (exp->cnf '(not (and a b))) '(AND (OR (NOT A) (NOT B))))
  (test-case (exp->cnf '(or a (and b g))) '(and (or G A) (or B A)))
  (test-case (exp->nnf '(:implies (not (or a b)) c)) '(or (not a) (not b) c))
  (test-case (exp->CNF '(:xor (not (or a b)) (and a c))) '(and (or (not b) a) (or (not a) c) (or (not b)) c))

  ; DPLL-UNIT-PROPAGATE
  ;(print "UP")
  ;(print (dpll-unit-propagate (cnf-maxterms '(and (or a b) (or (not b) c d))) '((a t))))
  (test-case (dpll (cnf-maxterms '(and (or a)))) t)
  (test-case (dpll (cnf-maxterms '(and (or a) (or (not a))))) nil)
  ; (test-case (sat-p '(and (or a))) nil)
)
