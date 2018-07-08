data Parity : Nat -> Type where
     Even : (j : Nat) -> Parity (j + j)
     Odd  : (j : Nat) -> Parity (S (j + j))

-- definition deferred...
parity : (n : Nat) -> Parity n

natToBin : (n : Nat) -> List Bool














---------

parity Z = Even Z
parity (S k) with (parity k)
  parity (S (plus j j))     | (Even j) = Odd j
  parity (S (S (plus j j))) | (Odd j) ?= {parity_odd_lemma} Even (S j)

---------- Proofs ----------

Main.parity_odd_lemma = proof
  compute
  intros
  rewrite sym (plusSuccRightSucc j j)
  exact value


