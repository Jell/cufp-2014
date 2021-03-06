module Main

import Effects
import Effect.StdIO

import System.Protocol

------
data Command = Next | SetIncrement | Stop 

count : Protocol ['Client, 'Server] ()
count = do cmd <- 'Client ==> 'Server | Command 
           case cmd of
              Next => 
                  do 'Server ==> 'Client | Int 
                     Rec count 
              SetIncrement => 
                  do 'Client ==> 'Server | Int
                     Rec count
              Stop => Done

------
covering
countServer : (c : Int) -> (v : Int) -> (inc : Int) -> (client : PID) ->
              Process count 'Server ['Client := client] [] ()
countServer c v inc client 
        = do cmd <- recvFrom 'Client
             case cmd of
                    Next => do sendTo 'Client v
                               rec (countServer 0 (v + inc) inc client)
                    SetIncrement => do i <- recvFrom 'Client
                                       rec (countServer 0 v i client)
                    Stop => pure ()

------
covering
countClient : (server : PID) ->
              Process count 'Client ['Server := server] [STDIO] ()
countClient server = do 
                 putStr "More? ('n' to stop) "
                 x <- getStr
                 case (trim x /= "n") of
                    True => let xval : Int = cast (trim x) in
                                case xval /= 0 of
                                     True => do
                                       sendTo 'Server SetIncrement
                                       sendTo 'Server xval
                                       rec (countClient server)
                                     False => do
                                       sendTo 'Server Next
                                       ans <- recvFrom 'Server
                                       putStrLn (show ans)
                                       rec (countClient server)
                    False => do sendTo 'Server Stop
                                pure ()

------
doCount : Process count 'Client [] [STDIO] ()
doCount = do server <- spawn (countServer 0 0 1) []
             setChan 'Server server 
             countClient server 
             dropChan 'Server

main : IO ()
main = do runConc [()] doCount

