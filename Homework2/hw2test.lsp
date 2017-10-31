(DFS '((A (B)) C (D))) ;(A B C D)
(DFS '((w x) (y z))) ;(w x y z)
(DFS '(A B ((C) D) E)) ;(A B C D E)
(DFS NIL) ;NIL
(DFS '(((((A B) C))))) ;(A B C)
(DFS '(A)) ;(A)
(DFS '((A) (((B))) (C (D (E F (G)))))) ;(A B C D E F G)

(DFID '((A (B)) C (D)) 3) ;(C A C D A B C D)
(DFID '((A C) B) 2) ;(B A C B)
(DFID '(A (B C) (D) (E (F G))) 3) ;(A A B C D E A B C D E F G)
(DFID '((w x) (y z)) 2) ;(W X Y Z)
(DFID '(A B (C ((D E) F)) G) 4) ;(A B G A B C G A B C F G A B C D E F G)

(final-state '(3 3 NIL))
(final-state '(3 2 NIL))
(final-state '(3 3 T))
(final-state '(2 3 NIL))
(final-state '(3 3))

(next-state '(3 3 T) 1 1) ;((1 1 NIL))
(next-state '(1 1 T) 2 0) ;NIL
(next-state '(1 1 T) 0 2) ;NIL
(next-state '(3 3 T) 2 1) ;NIL
(next-state '(2 2 T) 2 0) ;((3 1 NIL))
(next-state '(3 3 T) 2 0) ;NIL
(next-state '(2 3 T) 0 2) ;NIL
(next-state '(3 3 T) 0 1) ;((0 1 NIL))
(next-state '(3 3 T) 1 0) ;NIL
(next-state '(2 2 T) 0 2) ;NIL
(next-state '(1 1 NIL) 1 0) ;((3 2 T))

(succ-fn '(3 3 T)) ;((1 1 NIL) (0 1 NIL) (0 2 NIL))
(succ-fn '(3 2 T)) ;((1 1 NIL) (0 2 NIL) (0 3 NIL))
(succ-fn '(1 1 NIL)) ;((3 2 T) (3 3 T))
(succ-fn '(3 3 NIL)) ;((0 1 T) (1 1 T) (0 2 T))
(succ-fn '(2 2 NIL)) ;((2 2 T) (3 1 T))

(mult-dfs '((3 2 NIL) (3 3 NIL)) '((1 1 T)) 0) ;((1 1 T) (3 3 NIL))
(mult-dfs '((3 2 NIL) (3 3 NIL)) '((0 2 T)) 0) ;((0 2 T) (3 3 NIL))
(mult-dfs '((1 1 T) (0 2 T) (0 3 T)) '((3 2 NIL)) 1) ;((3 2 NIL) (1 1 T) (3 3 NIL))
(mult-dfs '((3 1 NIL) (3 2 NIL)) '((0 3 T)) 1) ;NIL
(mult-dfs '((3 1 NIL) (3 2 NIL)) '((0 3 T)) 2) ;((0 3 T) (3 2 NIL) (1 1 T) (3 3 NIL))

(single-dfs '(1 1 T) '((3 2 NIL)) 1) ;((3 2 NIL) (1 1 T) (3 3 NIL))
(single-dfs '(0 3 T) '((3 1 NIL)) 2) ;NIL
(single-dfs '(0 3 T) '((3 1 NIL)) 3) ;((3 1 NIL) (0 3 T) (3 2 NIL) (1 1 T) (3 3 NIL))

(id-dfs '(3 3 T) 0) ;((3 3 T) (1 1 NIL) (3 2 T) (0 3 NIL) (3 1 T) (2 2 NIL) (2 2 T) (3 1 NIL)
 ;(0 3 T) (3 2 NIL) (1 1 T) (3 3 NIL))