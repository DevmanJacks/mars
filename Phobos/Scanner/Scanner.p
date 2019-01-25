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
    source: *Source
    code:   []Byte

    // Scanning state
    offset:     Int
    nextOffset: Int
    
    currentChar: Char
}

func Scanner(source: Source) -> *Scanner {
    s := new Scanner
    s.offset = 0
    s.nextOffset = 0
    s.Next()
    return s
}

// Advance to the next character in the code
func Scanner.Next() {
    if nextOffset < code.length() {
        offset = nextOffset
        
        if code[offset] < 128 {
            // ASCII
            currentChar = Char(code[offset])
            nextOffset += 1
            
            if currentChar == '\n' {
                source.AddLine(offset)
            }
        } else {
            // Unicode
            currentChar, numBytes := Char(code[offset..])
            nextOffset += numBytes
        }
    } else {
        currentChar = -1
    }
}

func Scanner.Peek() -> Char {
    if nextOffset < code.length() {
        if code[nextOffset] < 128 {
            return Char(code[nextOffset])
        } else {
            char, _ := Char(code[offset..])
            return char
        }
    } else {
        return -1
    }
}

func Scanner.ScanIdentifier() -> (token: Token, lexeme: String) {
    start := offset
    
    while IsLetter(currentChar) || IsDigit(currentChar) {
        self.Next()
    }

    lexeme = source.code[start..offset-1].ToString()
    token = CheckKeyword(lexeme)
    return
}

func Scanner.SkipWhitespace() {
    while currentChar == ' ' || chrrentChar == '\t' || currentChar == '\r' || currentChar == '\n' {
        self.Next()
    }
}

func Scanner.Scan() -> (pos: Pos, token: Token, lexeme: String) {
    switch currentChar {
    default:
        if IsLetter(currentChar) {
            token, lexeme := self.ScanIdentifier()
        } else if IsDigit(currentChar) {
            token, lexeme := self.ScanNumber()
        }
    }
}

// ========== Helpers ==========

func IsDigit(ch: Char) -> Bool {
    return '0' <= ch && ch <= '9'    // TODO: Add unicode checks
}

func IsLetter(ch: Char) -> Bool {
    return 'A' <= ch && ch <= 'Z' || 'a' <= ch && ch <= 'z' || ch == '_'    // TODO: Add unicode checks
}