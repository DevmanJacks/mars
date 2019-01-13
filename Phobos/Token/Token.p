// Phobos language compiler

type Token enum {
    Identifier

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
    [Identifier] = "Identifier"
    
    [LeftBrace] = "{"
    [RightBrace] = "}"
    [LeftBracket] = "["
    [RightBracket] = "]"
    [LeftParen] = "("
    [RightParen] = ")"
    [Colon] = ":"
    [Comma] = ","
    [Dot] = "."
    [Returns] = "->"

    [Asterisk] = "*"

    [Enum] = "enum"
    [Func] = "func"
    [Import] = "import"
    [Return] = "return"
    [Struct] = "struct"
}