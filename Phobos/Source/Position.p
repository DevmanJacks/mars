// ...

// Pos is a compact representation of a position in a file or a memory block
type Pos UInt

// 
const undefinedPos: Pos = 0

// Find the file that contains this Pos
func Pos.File() -> *File {
    var file: *File
    
    for _, f in files {
        if pos >= f.base {
            file = f
        } else {
            break
        }
    }
    
    return file
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