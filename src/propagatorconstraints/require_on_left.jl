"""
Rules have to be used in the specified order.
That is, rule at index K can only be used if rules at indices [1...K-1] are used in the left subtree of the current expression
"""
struct RequireOnLeft <: PropagatorConstraint
	order::Vector{Int}
end


"""
Propagates the RequireOnLeft constraint.
It removes every element from the domain that does not have a necessary 
predecessor in the left subtree.
"""
function propagate(c::RequireOnLeft, ::Grammar, context::GrammarContext, domain::Vector{Int})::Tuple{Vector{Int}, Vector{LocalConstraint}}
	rules_on_left = rulesonleft(context.originalExpr, context.nodeLocation)
	
	last_rule_index = 0
	for (i, r) ∈ enumerate(c.order)
		r in rules_on_left ? last_rule_index = i : break
	end

	rules_to_remove = Set(c.order[last_rule_index+2:end]) # +2 because the one after the last index can be used

	return filter((x) -> !(x in rules_to_remove), domain), []
end
