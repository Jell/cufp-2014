module System.Popen

do_popen : String -> String -> IO Ptr
do_popen f m = mkForeign (FFun "fileOpen" [FString, FString] FPtr) f m

public 
popen : String -> Mode -> IO File
popen f m = do ptr <- do_popen f (modeStr m)
               return (FHandle ptr)
  where
    modeStr Read  = "r"
    modeStr Write = "w"
    modeStr ReadWrite = "r+"
