struct Programmatic <: PropagatorConstraint
    tree::AbstractMatchNode
    condition::Function
end
    

function propagate(
    c::Programmatic, 
    g::Grammar, 
    context::GrammarContext, 
    domain::Vector{Int}, 
    filled_hole::Union{HoleReference, Nothing}
)::Tuple{Vector{Int}, Set{LocalConstraint}}
    programmatic_constraint = LocalProgrammatic(context.nodeLocation, c.tree, c.condition)
    if in(programmatic_constraint, context.constraints) return domain, Set() end

    new_domain, new_constraints = propagate(programmatic_constraint, g, context, domain, filled_hole)
    return new_domain, new_constraints
end
