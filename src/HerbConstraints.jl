module HerbConstraints

using ..HerbGrammar

abstract type PropagatorConstraint <: Constraint end

abstract type LocalConstraint <: Constraint end

@enum PropagateFailureReason unchanged_domain=1
PropagatedDomain = Union{PropagateFailureReason, Vector{Int}}

include("matchfail.jl")
include("matchnode.jl")
include("context.jl")
include("patternmatch.jl")
include("rulenodematch.jl")

include("propagatorconstraints/comesafter.jl")
include("propagatorconstraints/forbidden_path.jl")
include("propagatorconstraints/ordered_path.jl")
include("propagatorconstraints/forbidden.jl")
include("propagatorconstraints/ordered.jl")
include("propagatorconstraints/programmatic.jl")
include("propagatorconstraints/disjunctive.jl")

include("localconstraints/local_forbidden.jl")
include("localconstraints/local_ordered.jl")
include("localconstraints/local_programmatic.jl")
include("localconstraints/local_disjunctive.jl")

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
    PropagateFailureReason,
    PropagatedDomain,

    propagate,
    check_tree,

    ComesAfter,
    ForbiddenPath,
    OrderedPath,
    Forbidden,
    Ordered,
    Programmatic,
    Disjunctive,

    LocalForbidden,
    LocalOrdered,
    LocalProgrammatic
    LocalOrdered,
    LocalDisjunctive

end # module HerbConstraints
