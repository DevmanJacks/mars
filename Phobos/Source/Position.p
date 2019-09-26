////////////////////////////////////////////////////////////
//
// Phobos Compiler - tool for building mars operating system
//
// Copyright (c) Mark Jackson		20 January 2019
//
////////////////////////////////////////////////////////////

// Pos is a compact representation of a position in a file or a memory block
type Pos UInt

// An undefined position
const undefinedPos: Pos = 0

// Find the Source that contains this Pos
func Pos.Source() -> *Source {
    var source: *Source
    
    for _, s in sources {
        if pos >= s.base {
            source = s
        } else {
            break
        }
    }
    
    return source
}

func Pos.ToString() -> String {
    var str: String
    file := self.File()
    
    if file.filename == nil {
        str += "<Anonymous>"
    } else {
        str += filename
    }
    
    str += ":" + file.Line(self).ToString() + ":" + file.Column(self).ToString()
    return str
}