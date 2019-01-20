////////////////////////////////////////////////////////////
//
// Phobos Compiler - tool for building mars operating system
//
// Copyright (c) Mark Jackson		20 January 2019
//
////////////////////////////////////////////////////////////

import Phobos.Source
import Phobos.Token

type Scanner struct {
    // Immutable state
    src:    *Source
    length: UInt

    // Scanning state
    offset:     Int
    nextOffset: Int
}

func Scanner(file: *File) -> *Scanner {

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