module HerbConstraints

using ..HerbGrammar

abstract type PropagatorConstraint <: Constraint end

include("constraintmatchnode.jl")

include("comesafter.jl")
include("forbidden.jl")
include("ordered.jl")
include("forbidden_tree.jl")

export
    ConstraintMatchNode,
    ConstraintMatchVar,

    PropagatorConstraint,

    propagate,

    _match_expr, # Temporary

    ComesAfter,
    Forbidden,
    Ordered,
    ForbiddenTree

end # module HerbConstraints
