
"""
	ComesAfter <: PropagatorConstraint

A [`ComesAfter`](@ref) constraint is a [`PropagatorConstraint`](@ref) containing the following:

- `rule::Int`: A reference to a rule in the grammar
- `predecessors`: A list of rules in the grammar

This [`Constraint`](@ref) enforces that the `rule` can only be applied if every rule in 
`predecessors` is used in the path from the root of the tree  to the current hole in the order 
that they are given. Even though the rules must be in order, there might be other rules inbetween.

For example, consider the tree `1(a, 2(b, 3(c, d))))`:

- `ComesAfter(4, [2, 3])` would enforce that rule `4` can only be used if `2` and `3` 
  are used in the path from the root in that order. Therefore, only hole `c` and `d` can be filled with `4`.
- `ComesAfter(4, [1, 3])` also allows `c` and `d` to be filled, since `1` and `3` are still used in the 
  correct order. It does not matter that `2` is also used in the path to the root.
- `ComesAfter(4, [3, 2])` does not allow any hole to be filled with `4`, since either the predecessors are 
  either not in the path or in the wrong order for each of the holes. 
"""
struct ComesAfter <: PropagatorConstraint
	rule::Int 
	predecessors::Vector{Int}
end


"""
	ComesAfter(rule::Int, predecessor::Int)

Creates a [`ComesAfter`](@ref) constraint with only a single `predecessor`. 
"""
ComesAfter(rule::Int, predecessor::Int) = ComesAfter(rule, [predecessor])

"""
	propagate(c::ComesAfter, ::AbstractGrammar, context::AbstractGrammarContext, domain::Vector{Int})::Tuple{Vector{Int}, Vector{LocalConstraint}}

Propagates the [`ComesAfter`](@ref) [`PropagatorConstraint`](@ref).
Rules in the domain that would violate the [`ComesAfter`](@ref) constraint are removed.
"""

function propagate(
    c::ComesAfter, 
    ::AbstractGrammar, 
    context::AbstractGrammarContext, 
    domain::Vector{Int}, 
    filled_hole::Union{HoleReference, Nothing}
)::Tuple{PropagatedDomain, Set{LocalConstraint}}
	# Skip the propagator if the hole that was filled isn't a parent of the current hole
	if !isnothing(filled_hole) && filled_hole.path != context.nodeLocation[begin:end-1]
		return domain, Set()
	end
	
	if c.rule in domain  # if rule is in domain, check the ancestors
		ancestors = get_rulesequence(context.originalExpr, context.nodeLocation[begin:end-1])  # remove the current node from the node sequence
    
		if containedin(c.predecessors, ancestors)
			return domain, Set()
		else
			return filter(e -> e != c.rule, domain), Set()
		end
	else # if it is not in the domain, just return domain
		return domain, Set()
	end
end


"""
Checks if the given tree abides the constraint.
"""
function check_tree(c::ComesAfter, g::AbstractGrammar, tree::AbstractRuleNode)::Bool
	@warn "ComesAfter.check_tree not implemented!"

	return true
end
