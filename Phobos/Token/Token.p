////////////////////////////////////////////////////////////
//
// Phobos Compiler - tool for building mars operating system
//
// Copyright (c) Mark Jackson		20 January 2019
//
////////////////////////////////////////////////////////////

type Token enum {
    EndOfFile
    Character
    Identifier
    String
    
    LeftBrace
    RightBrace
    LeftBracket
    RightBracket
    LeftParen
    RightParen
    Colon
    Comma
    Dot
    Returns

    Asterisk

    Enum
    Func
    Import
    Return
    Struct
}

var tokens = []String {
    [Token.Identifier] = "Identifier",
    
    [Token.LeftBrace] = "{",
    [Token.RightBrace] = "}",
    [Token.LeftBracket] = "[",
    [Token.RightBracket] = "]",
    [Token.LeftParen] = "(",
    [Token.RightParen] = ")",
    [Token.Colon] = ":",
    [Token.Comma] = ",",
    [Token.Dot] = ".",
    [Token.Returns] = "->",

    [Token.Asterisk] = "*",

    [Token.Enum] = "enum",
    
    [Token.Func] = "func",
    [Token.Import] = "import",
    [Token.Return] = "return",
    [Token.Struct] = "struct"
}

func Token.ToString() -> String {
	return tokens[self]
}

// Binary search on tokens to see if the string is a keyword
func CheckKeyword(s: String) -> Token {
    start := Token.Enum
    end := Token.Struct
    
    while end > start {
        index := (end - start) / 2 + start
        
        if s == tokens[index] {
            return index
        } else if s < tokens[index] {
            end = index - 1
        } else {
            start = index + 1
        }
    }
    
    return Token.Identifier
}