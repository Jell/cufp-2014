
data Nat = Z
         | S Nat

%name Nat k, j

plus : Nat -> Nat -> Nat
plus Z j = j
plus (S k) j = S (plus k j)

mult : Nat -> Nat -> Nat
mult Z j = Z
mult (S Z) j = j
mult (S k) j = plus j (mult k j)
