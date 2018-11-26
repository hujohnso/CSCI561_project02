;;This is the facts for Three pegs and two disks
(define 
 (problem towers-of-hundi-three-pegs-two-disks)
 (:domain hanoi)
 (:objects disk1 disk2 peg1 peg2 peg3)
 (:init 
  (on disk1 disk2)
  (on disk2 peg1)
  (clear disk1)
  (clear peg2)
  (clear peg3)
  (smaller disk1 disk2)
  (smaller disk1 peg1) (smaller disk1 peg2) (smaller disk1 peg3)
  (smaller disk2 peg1) (smaller disk2 peg2) (smaller disk2 peg3)
  )
 (:goal (and
  (on disk1 disk2)
  (on disk2 peg3)))
 )