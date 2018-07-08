twoplustwo : plus 2 2 = 4
twoplustwo = refl

plus_commutes_zero : y = plus y 0
plus_commutes_zero {y = Z}     = refl
plus_commutes_zero {y = (S k)} = rewrite plus_commutes_zero {y = k} in refl

plus_commutes_suc : (k : Nat) -> (y : Nat) -> S (plus y k) = plus y (S k)
plus_commutes_suc k Z = refl
plus_commutes_suc k (S j) = rewrite plus_commutes_suc k j in refl

plus_commutes : (x : Nat) -> (y : Nat) -> plus x y = plus y x
plus_commutes Z y = plus_commutes_zero
plus_commutes (S k) y = rewrite plus_commutes k y in plus_commutes_suc k y
