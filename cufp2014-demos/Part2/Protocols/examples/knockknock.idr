import System.Protocol

Literal : String -> Type
Literal x = (s : String ** x = s)

joke : Protocol ['A, 'B] ()
joke = do 'A ==> 'B | Literal "Knock knock"
          'B ==> 'A | Literal "Who's there?"
          name <- 'A ==> 'B | String
          'B ==> 'A | Literal (name ++ " who?")
          'A ==> 'B | (punchline : String ** 
                          Literal (name ++ punchline))
          Done

