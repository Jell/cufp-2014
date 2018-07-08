test_list : List (String, Int)
test_list = [("foo", 42), ("bar", 12), ("baz", 6)]

data IsKey : key -> List (key, value) -> Type where
     IsFirst :               IsKey x ((x, val) :: xs)
     IsLater : IsKey x xs -> IsKey x ((y, val) :: xs)

alookup : (x : key)
        -> (xs : List (key, value))
        -> {auto prf : IsKey x xs}
        -> value
alookup x ((x, val) :: ys) {prf = IsFirst} = val
alookup x ((y, val) :: ys) {prf = (IsLater z)} = alookup x ys

checkKey : DecEq key =>
           (x : key) -> (xs : List (key, value)) -> Maybe (IsKey x xs)
checkKey x [] = Nothing
checkKey x ((key, val) :: xs) with (decEq x key)
  checkKey x ((x, val) :: xs) | (Yes refl) = Just IsFirst
  checkKey x ((key, val) :: xs) | (No contra) = do w <- checkKey x xs
                                                   return IsLater w
