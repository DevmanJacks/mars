// ...

import System.IO

type File struct {
    filename: Strin
    src:      []UInt8

    base:   UInt
    length: Uint

    lines []UInt
}

var files: []*File
var base:  UInt = 1

func AddFile(filename: String) -> *File {
    src, error := ReadFile(filename)

    if error == Error.FileNotFound {
        Assert(0)
    }

    file := &File { filename = filename, src = src }
    files.Append(file)
    return file
}