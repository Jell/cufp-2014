module Main

import Effect.State
import Effect.Exception
import Effect.Random
import Effect.StdIO

getRnd : Integer -> { [RND] } Eff Integer
getRnd upper = rndInt 0 upper

data Expr = Var String
          | Val Integer
          | Add Expr Expr
          | Random Integer

Env : Type
Env = List (String, Integer)

eval : Expr -> { [EXCEPTION String, STATE Env, RND] } Eff Integer
eval (Var x)
   = do vs <- get
        case lookup x vs of
             Nothing => raise ("No such variable " ++ x)
             Just val => return val
eval (Val x) = return x
eval (Add l r) = do l' <- eval l
                    r' <- eval r
                    return (l' + r')
eval (Random x) = getRnd x

testExpr : Expr
testExpr = Add (Add (Var "foo") (Val 42)) (Val 100)

runEval : List (String, Integer) -> Expr -> IO Integer
runEval args expr = run (eval' expr)
  where eval' : Expr ->
                { [EXCEPTION String, STATE Env, RND] } Eff Integer
        eval' e = do put args
                     eval e
main : IO ()
main = do putStr "Number: "
          x <- getLine
          val <- runEval [("foo", cast x)] testExpr
          putStrLn $ "Answer: " ++ show val

-- Local Variables:
-- idris-packages: ("effects")
-- End:
