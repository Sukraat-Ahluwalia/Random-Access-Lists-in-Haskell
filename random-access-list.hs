-- Haskell code for implementing Okasaki's random access lists.
-- Random access lists support lookups in O(log N) time compared to O(N)
-- for regular lists. 

--They are implemented using heaps taken as a 2-ple of the size
-- and the heaps themselves

--operations supported - cons,tail,head,index

--Author: Sukraat Ahluwalia(sxa4430@rit.edu)

--hide default head and tail since this will require its own
--implementation of head and tail
import Prelude hiding (head, tail)
import Data.List (mapAccumL)

data CompleteTree a = Leaf a | Node a (CompleteTree a) (CompleteTree a) deriving (Eq, Show)

type RandomList a = [(Int, CompleteTree a)]

--create an empty instance of the list
emptyList::RandomList a
emptyList = []

--get a random list from a regular list 
convertToRandom::[a]->RandomList a
convertToRandom lst = fst $ mapAccumL (\lst e -> (cons e lst,lst)) emptyList (reverse lst)

--get a regular [a] type list
convertToNormal::RandomList a -> [a]
convertToNormal [] = []
convertToList lst = head lst:convertToNormal (tail lst)

--Implement the cons operation for the list
--Take an element and an random list and
--return a new version of the random list.

--If sizes of the two nodes are the same
--then merge and add1 to the size
--else add a new node as a Leaf with size 1
cons ::a->RandomList a->RandomList a
cons elem xs@((size1,tree1):(size2,tree2):others) = if size1 == size2 
							then (1+size1+size2, Node elem tree1 tree2):others 
							else (1, Leaf elem):xs
cons elem xs = (1, Leaf elem):xs 

--return the first element
--if there is one Leaf node only return the element it stores
--otherwise the first element in the complete tree node
--guanrateed to work since it stores stuff in preorder
head::RandomList a -> a
head [] = error "empty list, Can't return anything"
head ((_,Leaf firstElem):_) = firstElem
head ((_, Node firstElem _ _):_) = firstElem

--return the rest of the list
--If there is one leaf node conjoined with
--the rest then just return the rest
--else split the node into two and join with the rest to return the tail
tail::RandomList a->RandomList a
tail ((_,Leaf _):others) = others --if there is a singleton node at the front, return the leaf
tail ((size,Node _ tree1 tree2):others) = ((size-1) `div` 2, tree1):((size-1) `div` 2, tree2):others

--take the list and and index and return the element at that index
--for 0 index and single leaf just return the elem
--if index is greater than there are elements, underflow
--otherwize split the tree and reduce by 1.
index::RandomList a->Int->a
index ((size,tree):others) index' = if index' < size 
						then index'' (size, tree) index' 
						else index others (index'-size)
     where index'' (size, Leaf elem) 0 = elem
	   index'' (size, Leaf elem) index' = error "Underflow"
	   index'' (size, Node elem tree1 tree2) 0 = elem
	   index'' (size, Node elem tree1 tree2) index = 
		  let size_split = size `div` 2
	     	    in if index <= size_split
			  then index'' (size_split,tree1) (index' -1)
			  else index'' (size_split,tree2) (index'-1-size_split)
     

