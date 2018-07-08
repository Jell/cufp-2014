module Main

import Effect.State
import Effect.StdIO

data Tree a = Leaf
            | Node (Tree a) a (Tree a)

flattenTree : Tree a -> List a
flattenTree Leaf = []
flattenTree (Node l x r) = flattenTree l ++ (x :: flattenTree r)

testTree : Tree String
testTree = Node Leaf "Zero"
                (Node (Node Leaf "One" (Node Leaf "Two" Leaf))
                      "Three"
                      (Node (Node Leaf "Four" Leaf) "Five" Leaf))

data Tag : Type where
data Leaves : Type where

label : Tree a -> { [STDIO, STATE Int] } Eff (Tree (Int, a))
label Leaf = return Leaf
label (Node l x r) = do l' <- label l
                        lbl <- get
                        put (lbl + 1)
                        r' <- label r
                        putStrLn (show lbl)
                        return (Node l' (lbl, x) r')

main : IO ()
main = do t <- run (label testTree)
          print (flattenTree t)














{-
label Leaf = return Leaf
label (Node l x r) = do l' <- label l
                        lbl <- get
                        put (lbl + 1)
                        r' <- label r
                        return (Node l' (lbl, x) r')
-}

-- Local Variables:
-- idris-packages: ("effects")
-- End:
