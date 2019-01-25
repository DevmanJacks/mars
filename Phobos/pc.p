////////////////////////////////////////////////////////////
//
// Phobos Compiler - tool for building mars operating system
//
// Copyright (c) Mark Jackson		20 January 2019
//
////////////////////////////////////////////////////////////

import Phobos.Parser

func main() {
    file := AddFile("test.p")
    scanner := Scanner(file)
    parser := Parser(scanner)
    
}