////////////////////////////////////////////////////////////
//
// Phobos Compiler - tool for building mars operating system
//
// Copyright (c) Mark Jackson		20 January 2019
//
////////////////////////////////////////////////////////////

import Phobos.Scanner
import Phobos.Token

type Parser struct {
    scanner: *Scanner

    // Current token
    lexeme: String
    pos:    pos
    token:  Token

    // Are composite literals allowed in the current parsing context
    // They are not allowed in function signatures and control statement expressions
    compositeAllowed: Bool
}

func Parser(scanner: *Scanner) -> *Parser {
    p := new Parser
    p.scanner = scanner
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

