(define (domain hanoi)
  (:predicates 
    (clear ?x)
    (smaller ?x ?y)
    (on ?x ?y))

  (:action move-disk
    :parameters (?disk ?from ?to)
    :precondition (and (smaller ?disk ?to)
                       (on ?disk ?from)
		               (clear ?disk)
		               (clear ?to))
    :effect  (and (clear ?from)
                  (on ?disk ?to)
                  (not (on ?disk ?from))
		          (not (clear ?to)))))
