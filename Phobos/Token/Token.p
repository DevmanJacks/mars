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
    [Token.Identifier] = "Identifier"
    
    [Token.LeftBrace] = "{"
    [Token.RightBrace] = "}"
    [Token.LeftBracket] = "["
    [Token.RightBracket] = "]"
    [Token.LeftParen] = "("
    [Token.RightParen] = ")"
    [Token.Colon] = ":"
    [Token.Comma] = ","
    [Token.Dot] = "."
    [Token.Returns] = "->"

    [Token.Asterisk] = "*"

    [Token.Enum] = "enum"
    [Token.Func] = "func"
    [Token.Import] = "import"
    [Token.Return] = "return"
    [Token.Struct] = "struct"
}