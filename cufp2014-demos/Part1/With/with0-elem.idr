
data Elem : a -> List a -> Type where
     Here : Elem x (x :: xs)
     There : Elem x xs -> Elem x (y :: xs)

isElem_example : Elem 2 [1..4]
isElem_example = There Here

checkElem : (DecEq a) => (x : a) -> (xs : List a) -> Maybe (Elem x xs)
checkElem x [] = Nothing
checkElem x (y :: xs) with (decEq x y)
  checkElem x (x :: xs) | (Yes refl) = Just Here
  checkElem x (y :: xs) | (No contra) = [| There (checkElem x xs) |]
