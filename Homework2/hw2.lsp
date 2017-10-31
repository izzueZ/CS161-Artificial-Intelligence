;DFS takes a tree,
;returns a list of the node in order of depth-first search.
(defun DFS (TREE)
	(cond ((null TREE) NIL) ;check if the tree has node
		  ((atom TREE) (list TREE)) ;check if the tree is a leaf, return a list of itself
		  (t (append (DFS (first TREE)) (DFS (rest TREE)))) ;otherwise, the tree has branches, work on the first element and the rest
	)
)

;DFID takes a tree and an integer representing the maximum depth of the tree,
;returns a list of the node in order of depth-first iterative deepening.
(defun DFID (TREE D)
	(cond ((null TREE) NIL) ;check if the tree has node
		  ((< D 0) NIL) ;check if the input D is valid
		  (t (append (DFID TREE (- D 1)) (LDFS TREE D))) ;combine the result from a shallower DFID and a list of traverse with maximum depth
	)
)

;LDFS takes a tree and an integer representing the depth to traverse,
;returns a list of the node in order of depth-first search
(defun LDFS (TREE L)
	(cond ((null TREE) NIL) ;check if the tree has node
		  ((< L 0) NIL) ;check if the level is valid
		  ((atom TREE) (list TREE)) ;check if the tree is a leaf, return a list of itself
		  (t (append (LDFS (first TREE) (- L 1)) (LDFS (rest TREE) L))) ;otherwise, combine the result of the first element (l-1 means it goes one level deeper) and the rest
	)
)

; FINAL-STATE takes a single argument (S), the current state, and returns T if
; it is the goal state (3 3 NIL) and NIL otherwise.
(defun final-state (s)
	(equal s '(3 3 NIL)) ;check equals the goal state
)

; NEXT-STATE returns the state that results from applying an operator to the
; current state. It takes three arguments: the current state (S), a number of
; missionaries to move (M), and a number of cannibals to move (C). It returns a
; list containing the state that results from moving that number of missionaries
; and cannibals from the current side of the river to the other side of the
; river. If applying this operator results in an invalid state (because there
; are more cannibals than missionaries on either side of the river, or because
; it would move more missionaries or cannibals than are on this side of the
; river) it returns NIL.
;
; NOTE that next-state returns a list containing the successor state (which is
; itself a list); the return should look something like ((1 1 T)).
(defun next-state (s m c)
	(cond	((> m (first s)) NIL) ;check # of moving missionaries is valid
			((> c (second s)) NIL) ;check # of moving cannibals is valid
			((> (+ m c) 2) NIL) ;at most two people on the boat
			((and (> (- (first s) m) 0) (< (- (first s) m) (- (second s) c))) NIL) ;check current side after movement is valid
			((and (> (+ (- 3 (first s)) m) 0) (< (+ (- 3 (first s)) m) (+ (- 3 (second s)) c))) NIL) ;check the other side after movement is valid
			(t (list (list (+ (- 3 (first s)) m) (+ (- 3 (second s)) c) (not (third s))))) ;combine the three elements to represent the current state
	)
)

; SUCC-FN returns all of the possible legal successor states to the current
; state. It takes a single argument (S), which encodes the current state, and
; returns a list of states that can be reached by applying legal operators to
; the current state.
(defun succ-fn (s)
	(append (next-state s 2 0) 
			(next-state s 1 0) 
			(next-state s 1 1) 
			(next-state s 0 1) 
			(next-state s 0 2)) ;combine all the possible states after calling next-state
)

; MULT-DFS is a helper function for SINGLE-DFS. It takes three arguments: the
; path from the initial state to the current state (PATH), the legal successor
; states to the last state on PATH (STATES), and the depth (DEPTH). PATH is a
; first-in first-out list of states; that is, the first element is the initial
; state for the current search and the last element is the most recent state
; explored. 
; MULT-DFS does a single depth-first iteration to the given depth on
; each element of STATES in turn. If any of those searches reaches the final
; state, MULT-DFS returns the complete path from the initial state to the goal
; state. Otherwise, it returns NIL.
(defun mult-dfs (states path depth)
	(cond	((null states) NIL) ;check valid states
		 	((null path) NIL) ;check valid path
		 	((< depth 0) NIL) ;check valid depth
		 	((final-state (first states)) (append path (list (first states)))) ;if the first successor state is G.S, combine it with path and return
		 	((null (mult-dfs (succ-fn (first states)) (append path (list (first states))) (- depth 1))) (mult-dfs (rest states) path depth)) 
		 	;if the first successor state cannot derive any successful path, work on the rest of the successor states
		 	(t (mult-dfs (succ-fn (first states)) (append path (list (first states))) (- depth 1))) ;the first successor can derive a path, returns the path
	)
)

; SINGLE-DFS does a single depth-first iteration to the given depth. It takes
; three arguments: a state (S), the path from the initial state to S (PATH), and
; the depth (DEPTH). If S is the initial state in our search, PATH should be
; NIL. It performs a depth-first search starting at the given state. It returns
; the path from the initial state to the goal state, if any, or NIL otherwise.
(defun single-dfs (s path depth)
	(mult-dfs (succ-fn s) (append path (list s)) (- depth 1)) ;creates a list of legal succesor for s and pass into the mult-dfs
)

; ID-DFS is the top-level function. It takes two arguments: an initial state (S)
; and a search depth (DEPTH). ID-DFS performs a series of depth-first
; iterations, starting from the given depth until a solution is found. It
; returns the path from the initial state to the goal state. The very first call
; to ID-DFS should use depth = 0.
(defun id-dfs (s depth)
	(if (null (single-dfs s NIL depth))	(id-dfs s (+ depth 1)) ;check if the current depth is not enough for the search, increases the depth
		(single-dfs s NIL depth)
	)	
)
