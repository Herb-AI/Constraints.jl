module HerbConstraints

using ..HerbCore
using ..HerbGrammar

abstract type PropagatorConstraint <: Constraint end

abstract type LocalConstraint <: Constraint end

include("matchfail.jl")
include("matchnode.jl")
include("context.jl")
include("patternmatch.jl")
include("rulenodematch.jl")

include("propagatorconstraints/comesafter.jl")
include("propagatorconstraints/forbidden_path.jl")
include("propagatorconstraints/require_on_left.jl")
include("propagatorconstraints/forbidden.jl")
include("propagatorconstraints/ordered.jl")

include("localconstraints/local_forbidden.jl")
include("localconstraints/local_ordered.jl")

export
    AbstractMatchNode,
    MatchNode,
    MatchVar,
    matchnode2expr,

    GrammarContext,
    addparent!,
    copy_and_insert,

    contains_var,

    PropagatorConstraint,
    LocalConstraint,

    propagate,
    check_tree,

    ComesAfter,
    ForbiddenPath,
    RequireOnLeft,
    Forbidden,
    Ordered,

    LocalForbidden,
    LocalOrdered

end # module HerbConstraints
