@testset "Annotated Grammar Macro" verbose=false begin
    g₁ = HerbConstraints.@csgrammar_annotated begin
        Element = 1
        Element = x
        Element = Element + Element := commutative
        Element = Element * Element := (commutative, transitive)
    end

    @test @macroexpand HerbConstraints.@csgrammar_annotated begin end isa Expr
end