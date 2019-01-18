// ...

import System.IO

type Source struct {
    filename: String
    code:     []UInt8

    base:   UInt
    length: Uint

    lines: []UInt
}

// Column returns the column in the line in the Source containing the Pos
func Source.Column(pos: Pos) -> UInt {
    line := self.Line(pos)
    return pos - lines[line - 1] + 1
}

// Line returns the line in the Source containing the Pos
func Source.Line(pos: Pos) -> UInt {
    Assert(pos >= base && pos - base < length)
   
    for line, offset in lines {
        if pos < offset {
            return line - 1
        }
    return lines.length - 1
}

var sources: []*Source
var base:    UInt = 1

func AddFile(filename: String) -> *File {
    code, error := ReadFile(filename)

    if error == Error.FileNotFound {
        Assert(0)
    }

    source := &Source { filename = filename, code = code, lines = { base }}
    base += code.Length()
    sources.Append(source)
    return source
}