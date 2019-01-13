// Phobos language compiler

type Parser {
    scanner: *Scanner
}

func Parser() -> *Parser {
    p := new Parser
    return p
}

func Parser.Scanner() -> *Scanner {
    return scanner
}

