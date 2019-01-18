// Phobos language compiler

import Token

type Parser {
    scanner: *Scanner

    // Current token
    lexeme: String
    pos:    pos
    token:  Token

    // Are composite literals allowed in the current parsing context
    // Not allowed in function signatures and control statements
    compositeAllowed: Bool
}

func Parser() -> *Parser {
    p := new Parser
    p.compositeAllowed = true
    p.Next()
    return p
}

// Next gets the next token from the Scanner
func Parser.Next() {

}

func Parser.Scanner() -> *Scanner {
    return scanner
}

