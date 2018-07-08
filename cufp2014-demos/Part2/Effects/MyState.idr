module MyState

import Effects

{- Effect = (x : Type) -> Type -> (x -> Type) -> Type : Type -}

data State : Effect where
  Get :      State a a (\res => a)
  Put : b -> State () a (\res => b)

STATE : Type -> EFFECT
STATE a = MkEff a State

get : { [STATE a] } Eff a
get = call Get

{-
"call" takes an effect definition such as 'State' above, and "promotes"
it to a program in Eff:

call : {e : Effect} ->
       (eff : e t a b) ->
       {auto prf : EffElem e a xs} ->
       Eff t xs (\v => updateResTy v xs prf eff)
-}

put : ?what

instance Handler State m where
    handle r Get k = k r r
    handle r (Put x) k = k () x



-- Local Variables:
-- idris-packages: ("effects")
-- End:
