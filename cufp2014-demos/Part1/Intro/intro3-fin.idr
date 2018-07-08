
data Nat = Z | S Nat

plus : Nat -> Nat -> Nat
plus Z y = y 
plus (S x) y = S (plus x y)

infixr 5 ::

data Vect : Nat -> Type -> Type where
     Nil  : Vect Z a
     (::) : a -> Vect k a -> Vect (S k) a

%name Vect xs, ys, zs

data Fin : Nat -> Type where
     fZ : Fin (S k)
     fS : Fin k -> Fin (S k)

index : Fin k -> Vect k a -> a

