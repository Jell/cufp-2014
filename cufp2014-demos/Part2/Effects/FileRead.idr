module Main

import Effect.File
import Effect.State
import Effect.StdIO
import Control.IOExcept

FileIO : Type -> Type -> Type
FileIO st t
  = { [FILE_IO st, STDIO, STATE Int] } Eff t 

readFile : FileIO (OpenFile Read) (List String)
readFile = readAcc [] where
    readAcc : List String -> FileIO (OpenFile Read) (List String)
    readAcc acc = do e <- eof
                     if (not e)
                        then do str <- readLine
                                put (!get + 1)
                                readAcc (str :: acc)
                        else return (reverse acc)

dumpFile : String -> FileIO () ()
dumpFile fname = do open fname Read
                    putStrLn !readFile
                    close

main : IO ()
main = run $ dumpFile "testfile"


