// Phobos language compiler

import Phobos.Token

type Scanner struct {
    // Immutable state
    src:    []UInt8
    length: UInt

    // Scanning state
    offset:     Int
    nextOffset: Int
}

func Scanner() -> *Scanner {

}

func Scanner.Next() {

}

func Scanner.Peek() {

}

func Scanner.ScanIdentifier() -> (token: Token, lexeme: String) {

}

func Scanner.SkipWhitespace() {

}

func Scanner.Scan() -> (pos: Pos, token: Token, lexeme: String) {

}