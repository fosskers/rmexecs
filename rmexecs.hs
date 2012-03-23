-- Removes all executables from the current directory.

import System.Directory (getDirectoryContents, removeFile)
import System.Posix.Files (getFileStatus, isDirectory)
import ElfMagic (isExecutable)
import ColinPrelude (filterM)

main = do
  files  <- getDirectoryContents "."
  noDirs <- filterM notADir files
  execs  <- filterM isExecutable noDirs
  mapM_ removeFile execs

notADir :: FilePath -> IO Bool
notADir file = getFileStatus file >>= return . not . isDirectory