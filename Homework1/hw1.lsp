;TREE-CONTAINS takes a number N and an ordered TREE,
;returns true if the number N is in the TREE, otherwise NIL.
;Check TREE, and then check current node to decide which side to work on. 
(defun TREE-CONTAINS (N TREE)
  (if (numberp TREE) 
      (= N TREE)
      (cond ((= N (second TREE)) T)
	    ((< N (second TREE)) (TREE-CONTAINS N (first TREE)))
	    (T (TREE-CONTAINS N (third TREE)))
      )
  )
)				    

;TREE-MAX takes an ordered TREE,
;returns the maximum number in the TREE.
;Check TREE, and then check the right side of the current node.
(defun TREE-MAX (TREE)
  (if (numberp TREE) TREE
      (TREE-MAX (third TREE))
  )
)

;TREE-ORDER takes an ordered TREE,
;returns an ordered list of all elements in the TREE.
;Check TREE, and then combine left, middle, right list into one.
(defun TREE-ORDER (TREE)
  (if (numberp TREE) 
      (list TREE)
      (append (TREE-ORDER (first TREE)) (cons (second TREE) (TREE-ORDER (third TREE))))
  )
)

;SUB-LIST takes a list L, an index START and a number LEN,
;returns a list extraced from L by slicing from START with length LEN.
;Check LEN, then check if the extraction begins at head, 
;otherwise, delete the head and run again.
(defun SUB-LIST (L START LEN)
  (cond ((NULL L) NIL)
        ((= 0 LEN) NIL)
	((= 0 START) (cons (car L) (SUB-LIST (cdr L) START (- LEN 1))))
	(T (SUB-LIST (cdr L) (- START 1) LEN))
  )
)

;SPLIT-LIST takes a list L,
;returns two lists L1 and L2, which construct the L.
;Check empty list, and then divide into two cases: even & odd length,
;use SUB-LIST to extract the lists we need.
(defun SPLIT-LIST (L)
  (let* ((length (list-length L)))
    (cond ((= 0 length) '(() ()))
	  ((evenp length) (let* ((half (/ length 2)))
			    (list (SUB-LIST L 0 half) (SUB-LIST L half half))
			  )
	  )
	  (T (let* ((half (/ (- length 1) 2)))
	       (list (SUB-LIST L 0 half) (SUB-LIST L half (+ 1 half)))
	     )
	  )
    )
  )
)

;BTREE-HEIGHT takes a binary TREE,
;returns the height of this TREE.
;Check TREE, and then compares the height of left and right sub-trees, adds 1 to the larger one.
(defun BTREE-HEIGHT (TREE)
  (cond ((null TREE) 0)
        ((numberp TREE) 0)
	(T (let* ((left-height (BTREE-HEIGHT (first TREE)))
		  (right-height (BTREE-HEIGHT (second TREE))))
	     (if (> left-height right-height) (+ 1 left-height)
	       (+ 1 right-height)
	     )
	   )
	 )
  )
)

;LIST2BTREE takes a non-empty list LEAVES, which has atoms,
;returns a balanced binary tree.
;Check the case that the list contains one or two elements, which do not need to be splited,
;then use SPLIT-LIST to split LEAVES into two and work on each part.  
(defun LIST2BTREE (LEAVES)
  (let* ((length (list-length LEAVES)))
    (cond ((= length 1) (car LEAVES))
	  ((= length 2) LEAVES)
	  (T (let* ((split (SPLIT-LIST LEAVES)))
	       (list (LIST2BTREE (first split)) (LIST2BTREE (second split)))
	     )
	  )
    )
  )
)

;BTREE2LIST takes a binary TREE,
;returns a list of atoms.
;Check TREE, then concatenate the list computed from left and right sub-trees.
(defun BTREE2LIST (TREE)
  (cond ((null TREE) NIL) 
	((numberp TREE) (list TREE))
	(T (append (BTREE2List (first TREE)) (BTREE2LIST (second TREE))))
  )
)

;IS-SAME takes 2 LISP expressions E1 and E2,
;returns true if E1 and E2 are identical.
;Check E1 or E2 is an empty list, check E1 or E2 is an atom, 
;then apply the general case that check both of the first element and the rest of two expressions.
(defun IS-SAME (E1 E2)
  (cond ((null E1) (if (null E2) T))
        ((numberp E1) (if (numberp E2) (= E1 E2) NIL)) 	   
	((numberp E2) NIL)
	(T (and (IS-SAME (car E1) (car E2)) (IS-SAME (cdr E1) (cdr E2))))
  )
)