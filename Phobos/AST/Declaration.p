////////////////////////////////////////////////////////////
//
// Phobos Compiler - tool for building mars operating system
//
// Copyright (c) Mark Jackson		21 January 2019
//
////////////////////////////////////////////////////////////

type Declaration interface {
    DeclarationNode()
}

type ConstDeclaration struct {
    name      *Identifier
    constType Expr
    value     Expr
}

func ConstDeclaration.DeclarationNode() {}

func ConstDeclaration.Resolve() {
    value.Resolve()
    
    if constType == nil {
        constType = value.resolvedType.ToExpression()
    } else {
        constType.Resolve()
        
        if !areAssignmentCompatibleTypes(value.resolvedType, constType) {
            error(name.StartPos(), value.EndPos, "Incompatible types {constType.resolvedType} and {value.resolvedType}.")
        }
    }
}