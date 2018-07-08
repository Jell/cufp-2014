import Effect.Msg
import System.Protocol

Literal : String -> Type
Literal x = (s : String ** x = s)

echo : Protocol ['C, 'S] ()
echo = do msg <- 'C ==> 'S | String
          'S ==> 'C | Literal msg
          Done
