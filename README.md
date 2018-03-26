# Random-Access-Lists-in-Haskell
Implementing lists in Haskell with random access like C++'s `std::vector`,`ArrayList<T>` in Java based on Okasaki's "Random Access Lists" from Purely Functional Data Structures.

To run the code first type `$ghci` to load the GHCI interpreter and then `:l random-access-list.hs` to load the code. Once that has been done, here's how to play with the code - 

* Call the `convertToRandom` function and provide a regular list to convert it to a random access list

`let foo = convertToRandom [1,2,3,4]` 

`foo` holds the list, typing it on the interpreter and pressing enter displays

`[(1, Leaf 1), (3, Node 2 (Leaf 3) (Leaf 4))]`

where `(1,Leaf 1)` indicates first the size of the node(i.e 1) and `Leaf 1` holds the value, a node is represented either as a `Leaf` or a `Node (CompleteTree) (CompleteTree)` type indicating a node and its children nodes(or subtrees) , so
`(3, Node 2 (Leaf 3) (Leaf 4))` indicates a node of size 3, and elements 2,3,4 with 2 being the parent node holding 3 and 4.

* Now `cons 5 foo` adds 5 to the head of the list, though since Haskell is a pure functional language no permanent changes are made to `foo` it will permanently represent a list `[1,2,3,4]`

* `head foo` returns the head, obviously `tail` returns the tail of the list.

* `index foo 0` returns the element at the 0-th index , so well for other indexes just enter the index you want.

* `convertToNormal foo` returns a normal Haskell list.
