var documenterSearchIndex = {"docs":
[{"location":"examples2.html#Examples","page":"Examples","title":"Examples","text":"","category":"section"},{"location":"reference.html#Algorithms","page":"References","title":"Algorithms","text":"","category":"section"},{"location":"reference.html","page":"References","title":"References","text":"This section contains all algorithms of the FrankWolfe.jl package.","category":"page"},{"location":"reference.html#Functions","page":"References","title":"Functions","text":"","category":"section"},{"location":"reference.html","page":"References","title":"References","text":"frank_wolfe\r\nlazified_conditional_gradient\r\naway_frank_wolfe\r\nblended_conditional_gradient","category":"page"},{"location":"reference.html#LMOs","page":"References","title":"LMOs","text":"","category":"section"},{"location":"reference.html","page":"References","title":"References","text":"The Linear Minimization Oracle (LMO) is an integral part of the iterative step in the FW algorithm. Given din mathcalX, it returns:","category":"page"},{"location":"reference.html","page":"References","title":"References","text":"vin argmin_xin mathcalC langle dx rangle","category":"page"},{"location":"reference.html","page":"References","title":"References","text":"FrankWolfe.jl features the following common LMOs out of the box:","category":"page"},{"location":"reference.html","page":"References","title":"References","text":"probability simplex: FrankWolfe.ProbabilitySimplexOracle\nunit simplex: FrankWolfe.UnitSimplexOracle\nK-sparse polytope: FrankWolfe.KSparseLMO\nK-norm ball: FrankWolfe.KNormBallLMO\nL^p-norm ball: FrankWolfe.LpNormLMO\nBirkhoff polytope: FrankWolfe.BirkhoffPolytopeLMO","category":"page"},{"location":"reference.html","page":"References","title":"References","text":"All of them are subtypes of FrankWolfe.LinearMinimizationOracle and implement the following method:","category":"page"},{"location":"reference.html","page":"References","title":"References","text":"compute_extreme_point","category":"page"},{"location":"reference.html#FrankWolfe.compute_extreme_point","page":"References","title":"FrankWolfe.compute_extreme_point","text":"compute_extreme_point(lmo::LinearMinimizationOracle, direction; kwargs...)\n\nComputes the point argmin_{v ∈ C} v ⋅ direction with C the set represented by the LMO. All LMOs should accept keyword arguments that they can ignore.\n\n\n\n\n\n","category":"function"},{"location":"reference.html#Functions-and-Structures","page":"References","title":"Functions and Structures","text":"","category":"section"},{"location":"reference.html","page":"References","title":"References","text":"FrankWolfe.LinearMinimizationOracle\r\nFrankWolfe.CachedLinearMinimizationOracle\r\nFrankWolfe.SingleLastCachedLMO\r\nFrankWolfe.MultiCacheLMO\r\nFrankWolfe.VectorCacheLMO\r\nFrankWolfe.ProductLMO\r\ncompute_extreme_point(lmo::FrankWolfe.ProductLMO, direction::Tuple; kwargs...)\r\ncompute_extreme_point(lmo::FrankWolfe.ProductLMO{N},direction::AbstractArray;storage=similar(direction),direction_indices,kwargs...,) where {N}\r\nFrankWolfe.UnitSimplexOracle\r\ncompute_extreme_point(lmo::FrankWolfe.UnitSimplexOracle{T}, direction) where {T}\r\nFrankWolfe.compute_dual_solution(::FrankWolfe.UnitSimplexOracle{T}, direction, primalSolution) where {T}\r\nFrankWolfe.ProbabilitySimplexOracle\r\ncompute_extreme_point(lmo::FrankWolfe.ProbabilitySimplexOracle{T}, direction; kwargs...) where {T}\r\nFrankWolfe.compute_dual_solution(::FrankWolfe.ProbabilitySimplexOracle{T},direction,primal_solution;kwargs...,) where {T}\r\nFrankWolfe.KSparseLMO\r\nFrankWolfe.BirkhoffPolytopeLMO\r\nFrankWolfe.LpNormLMO\r\nFrankWolfe.KNormBallLMO\r\nFrankWolfe.NuclearNormLMO\r\ncompute_extreme_point(lmo::FrankWolfe.NuclearNormLMO, direction::AbstractMatrix; tol=1e-8, kwargs...)\r\nFrankWolfe.MathOptLMO\r\nFrankWolfe.convert_mathopt","category":"page"},{"location":"reference.html#FrankWolfe.LinearMinimizationOracle","page":"References","title":"FrankWolfe.LinearMinimizationOracle","text":"Supertype for linear minimization oracles.\n\nAll LMOs must implement compute_extreme_point(lmo::LMO, direction) and return a vector v of the appropriate type.\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.CachedLinearMinimizationOracle","page":"References","title":"FrankWolfe.CachedLinearMinimizationOracle","text":"CachedLinearMinimizationOracle{LMO}\n\nOracle wrapping another one of type lmo. Subtypes of CachedLinearMinimizationOracle contain a cache of previous solutions.\n\nBy convention, the inner oracle is named inner. Cached optimizers are expected to implement Base.empty! and Base.length.\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.SingleLastCachedLMO","page":"References","title":"FrankWolfe.SingleLastCachedLMO","text":"SingleLastCachedLMO{LMO, VT}\n\nCaches only the last result from an LMO and stores it in last_vertex. Vertices of LMO have to be of type VT if provided.\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.MultiCacheLMO","page":"References","title":"FrankWolfe.MultiCacheLMO","text":"MultiCacheLMO{N, LMO, VT}\n\nCache for a LMO storing up to N vertices in the cache, removed in FIFO style. oldest_idx keeps track of the oldest index in the tuple, i.e. to replace next. VT, if provided, must be the type of vertices returned by LMO\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.VectorCacheLMO","page":"References","title":"FrankWolfe.VectorCacheLMO","text":"VectorCacheLMO{N, LMO, VT}\n\nCache for a LMO storing an unbounded number of vertices of type VT in the cache. VT, if provided, must be the type of vertices returned by LMO\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.ProductLMO","page":"References","title":"FrankWolfe.ProductLMO","text":"ProductLMO(lmos...)\n\nLinear minimization oracle over the Cartesian product of multiple LMOs.\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.compute_extreme_point-Tuple{FrankWolfe.ProductLMO, Tuple}","page":"References","title":"FrankWolfe.compute_extreme_point","text":"compute_extreme_point(lmo::ProductLMO, direction::Tuple; kwargs...)\n\nExtreme point computation on Cartesian product, with a direction (d1, d2, ...) given as a tuple of directions. All keyword arguments are passed to all LMOs.\n\n\n\n\n\n","category":"method"},{"location":"reference.html#FrankWolfe.compute_extreme_point-Union{Tuple{N}, Tuple{FrankWolfe.ProductLMO{N, TL} where TL<:Tuple{Vararg{FrankWolfe.LinearMinimizationOracle, N}}, AbstractArray}} where N","page":"References","title":"FrankWolfe.compute_extreme_point","text":"compute_extreme_point(lmo::ProductLMO, direction::AbstractArray; direction_indices, storage=similar(direction))\n\nExtreme point computation, with a direction array and direction_indices provided such that: direction[direction_indices[i]] is passed to the i-th LMO. The result is stored in the optional storage container.\n\nAll keyword arguments are passed to all LMOs.\n\n\n\n\n\n","category":"method"},{"location":"reference.html#FrankWolfe.UnitSimplexOracle","page":"References","title":"FrankWolfe.UnitSimplexOracle","text":"UnitSimplexOracle(right_side)\n\nRepresents the scaled unit simplex:\n\nC = {x ∈ R^n_+, ∑x ≤ right_side}\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.compute_extreme_point-Union{Tuple{T}, Tuple{FrankWolfe.UnitSimplexOracle{T}, Any}} where T","page":"References","title":"FrankWolfe.compute_extreme_point","text":"LMO for scaled unit simplex: ∑ x_i = τ Returns either vector of zeros or vector with one active value equal to RHS if there exists an improving direction.\n\n\n\n\n\n","category":"method"},{"location":"reference.html#FrankWolfe.compute_dual_solution-Union{Tuple{T}, Tuple{FrankWolfe.UnitSimplexOracle{T}, Any, Any}} where T","page":"References","title":"FrankWolfe.compute_dual_solution","text":"Dual costs for a given primal solution to form a primal dual pair for scaled unit simplex. Returns two vectors. The first one is the dual costs associated with the constraints  and the second is the reduced costs for the variables.\n\n\n\n\n\n","category":"method"},{"location":"reference.html#FrankWolfe.ProbabilitySimplexOracle","page":"References","title":"FrankWolfe.ProbabilitySimplexOracle","text":"ProbabilitySimplexOracle(right_side)\n\nRepresents the scaled probability simplex:\n\nC = {x ∈ R^n_+, ∑x = right_side}\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.compute_extreme_point-Union{Tuple{T}, Tuple{FrankWolfe.ProbabilitySimplexOracle{T}, Any}} where T","page":"References","title":"FrankWolfe.compute_extreme_point","text":"LMO for scaled probability simplex. Returns a vector with one active value equal to RHS in the most improving (or least degrading) direction.\n\n\n\n\n\n","category":"method"},{"location":"reference.html#FrankWolfe.compute_dual_solution-Union{Tuple{T}, Tuple{FrankWolfe.ProbabilitySimplexOracle{T}, Any, Any}} where T","page":"References","title":"FrankWolfe.compute_dual_solution","text":"Dual costs for a given primal solution to form a primal dual pair for scaled probability simplex. Returns two vectors. The first one is the dual costs associated with the constraints  and the second is the reduced costs for the variables.\n\n\n\n\n\n","category":"method"},{"location":"reference.html#FrankWolfe.KSparseLMO","page":"References","title":"FrankWolfe.KSparseLMO","text":"KSparseLMO{T}(K::Int, right_hand_side::T)\n\nLMO for the K-sparse polytope:\n\nC = B_1(τK) ∩ B_∞(τ)\n\nwith τ the right_hand_side parameter. The LMO results in a vector with the K largest absolute values of direction, taking values -τ sign(x_i).\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.BirkhoffPolytopeLMO","page":"References","title":"FrankWolfe.BirkhoffPolytopeLMO","text":"BirkhoffPolytopeLMO\n\nThe Birkhoff polytope encodes doubly stochastic matrices. Its extreme vertices are all permutation matrices of side-dimension dimension.\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.LpNormLMO","page":"References","title":"FrankWolfe.LpNormLMO","text":"LpNormLMO{T, p}(right_hand_side)\n\nLMO with feasible set being a bound on the L-p norm:\n\nC = {x ∈ R^n, norm(x, p) ≤ right_side}\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.KNormBallLMO","page":"References","title":"FrankWolfe.KNormBallLMO","text":"KNormBallLMO{T}(K::Int, right_hand_side::T)\n\nLMO for the K-norm ball, intersection of L1-ball (τK) and L∞-ball (τ/K)\n\nC_{K,τ} = conv { B_1(τ) ∪ B_∞(τ / K) }\n\nwith τ the right_hand_side parameter.\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.NuclearNormLMO","page":"References","title":"FrankWolfe.NuclearNormLMO","text":"NuclearNormLMO{T}(δ)\n\nLMO over matrices that have a nuclear norm less than δ. The LMO returns the rank-one matrix with singular value δ.\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.compute_extreme_point-Tuple{FrankWolfe.NuclearNormLMO, AbstractMatrix{T} where T}","page":"References","title":"FrankWolfe.compute_extreme_point","text":"Best rank-one approximation using the Golub-Kahan-Lanczos bidiagonalization from IterativeSolvers.\n\nWarning: this does not work (yet) with all number types, BigFloat and Float16 fail.\n\n\n\n\n\n","category":"method"},{"location":"reference.html#FrankWolfe.MathOptLMO","page":"References","title":"FrankWolfe.MathOptLMO","text":"MathOptLMO{OT <: MOI.Optimizer} <: LinearMinimizationOracle\n\nLinear minimization oracle with feasible space defined through a MathOptInterface.Optimizer. The oracle call sets the direction and reruns the optimizer.\n\nThe direction vector has to be set in the same order of variables as the MOI.ListOfVariableIndices() getter.\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.convert_mathopt","page":"References","title":"FrankWolfe.convert_mathopt","text":"convert_mathopt(lmo::LMO, optimizer::OT; kwargs...) -> MathOptLMO{OT}\n\nConverts the given LMO to its equivalent MathOptInterface representation using optimizer. Must be implemented by LMOs.\n\n\n\n\n\n","category":"function"},{"location":"reference.html#Components","page":"References","title":"Components","text":"","category":"section"},{"location":"reference.html","page":"References","title":"References","text":"This section gathers all additional relevant components of the FrankWolfe.jl package.","category":"page"},{"location":"reference.html#Functions-and-Structures-2","page":"References","title":"Functions and Structures","text":"","category":"section"},{"location":"reference.html","page":"References","title":"References","text":"FrankWolfe.ActiveSet\r\nFrankWolfe.active_set_update!\r\nFrankWolfe.compute_active_set_iterate\r\nFrankWolfe.active_set_argmin\r\nFrankWolfe.active_set_argminmax\r\nFrankWolfe.find_minmax_directions\r\nFrankWolfe.minimize_over_convex_hull!\r\nFrankWolfe.build_reduced_problem(atoms::AbstractVector{<:FrankWolfe.ScaledHotVector},hessian,weights,gradient,tolerance)\r\nFrankWolfe.build_reduced_problem(atoms::AbstractVector{<:SparseArrays.AbstractSparseArray},hessian,weights,gradient,tolerance)\r\nFrankWolfe.build_reduced_problem(atoms::AbstractVector{<:Array},hessian,weights,gradient,tolerance)\r\nFrankWolfe.Strong_Frank_Wolfe_gap\r\nFrankWolfe.accelerated_simplex_gradient_descent_over_probability_simplex\r\nFrankWolfe.simplex_gradient_descent_over_probability_simplex\r\nFrankWolfe.projection_simplex_sort\r\nFrankWolfe.Strong_Frank_Wolfe_gap_probability_simplex\r\nFrankWolfe.simplex_gradient_descent_over_convex_hull\r\nFrankWolfe.lp_separation_oracle\r\nFrankWolfe.LineSearchMethod\r\nFrankWolfe.Emphasis\r\nFrankWolfe.ObjectiveFunction\r\nFrankWolfe.compute_value_gradient\r\nFrankWolfe.StochasticObjective\r\nFrankWolfe.ScaledHotVector\r\nFrankWolfe.RankOneMatrix\r\nFrankWolfe.line_search_wrapper\r\nFrankWolfe.adaptive_step_size\r\nFrankWolfe.plot_results\r\nFrankWolfe._unsafe_equal\r\nFrankWolfe.check_gradients\r\nFrankWolfe.trajectory_callback","category":"page"},{"location":"reference.html#FrankWolfe.ActiveSet","page":"References","title":"FrankWolfe.ActiveSet","text":"ActiveSet{AT, R, IT}\n\nRepresents an active set of extreme vertices collected in a FW algorithm, along with their coefficients (λ_i, a_i). R is the type of the λ_i, AT is the type of the atoms a_i. The iterate x = ∑λ_i a_i is stored in x with type IT.\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.active_set_update!","page":"References","title":"FrankWolfe.active_set_update!","text":"active_set_update!(active_set::ActiveSet, lambda, atom)\n\nAdds the atom to the active set with weight lambda or adds lambda to existing atom.\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.compute_active_set_iterate","page":"References","title":"FrankWolfe.compute_active_set_iterate","text":"compute_active_set_iterate(active_set)\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.active_set_argmin","page":"References","title":"FrankWolfe.active_set_argmin","text":"active_set_argmin(active_set::ActiveSet, direction)\n\nComputes the linear minimizer in the direction on the active set. Returns (λ_i, a_i, i)\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.active_set_argminmax","page":"References","title":"FrankWolfe.active_set_argminmax","text":"active_set_argminmax(active_set::ActiveSet, direction)\n\nComputes the linear minimizer in the direction on the active set. Returns (λ_min, a_min, i_min, λ_max, a_max, i_max)\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.find_minmax_directions","page":"References","title":"FrankWolfe.find_minmax_directions","text":"find_minmax_directions(active_set::ActiveSet, direction, Φ)\n\nComputes the point of the active set minimizing in direction on the active set (local Frank Wolfe) and the maximizing one (away step). Returns the two corresponding indices in the active set, along with a flag indicating if the direction improvement is above a threshold. goodstep_tolerance ∈ (0, 1] is a tolerance coefficient multiplying Φ for the validation of the progress. \n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.minimize_over_convex_hull!","page":"References","title":"FrankWolfe.minimize_over_convex_hull!","text":"minimize_over_convex_hull!\n\nGiven a function f with gradient grad! and an active set  active_set this function will minimize the function over  the convex hull of the active set until the strong-wolfe  gap over the active set is below tolerance.\n\nIt will either directly minimize over the convex hull using simplex gradient descent, or it will transform the problem  to barycentric coordinates and minimize over the unit  probability simplex using gradient descent or Nesterov's  accelerated gradient descent.\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.build_reduced_problem-Tuple{AbstractVector{var\"#s11\"} where var\"#s11\"<:FrankWolfe.ScaledHotVector, Any, Any, Any, Any}","page":"References","title":"FrankWolfe.build_reduced_problem","text":"build_reduced_problem(atoms::AbstractVector{<:FrankWolfe.ScaledHotVector}, hessian, weights, gradient, tolerance)\n\nGiven an active set formed by ScaledHotVector, a (constant) Hessian and a gradient constructs a quadratic problem  over the unit probability simplex that is equivalent to  minimizing the original function over the convex hull of the active set. If λ are the barycentric coordinates of dimension equal to the cardinality of the active set, the objective  function is:     f(λ) = reducedlinear^T λ + 0.5 * λ^T reducedhessian λ\n\nIn the case where we find that the current iterate has a strong-Wolfe  gap over the convex hull of the active set that is below the tolerance  we return nothing (as there is nothing to do).\n\n\n\n\n\n","category":"method"},{"location":"reference.html#FrankWolfe.build_reduced_problem-Tuple{AbstractVector{var\"#s11\"} where var\"#s11\"<:AbstractSparseArray, Any, Any, Any, Any}","page":"References","title":"FrankWolfe.build_reduced_problem","text":"buildreducedproblem\n\nSame as the function above, but for the case where the active  set is formed by Sparse Arrays.\n\n\n\n\n\n","category":"method"},{"location":"reference.html#FrankWolfe.build_reduced_problem-Tuple{AbstractVector{var\"#s11\"} where var\"#s11\"<:Array, Any, Any, Any, Any}","page":"References","title":"FrankWolfe.build_reduced_problem","text":"build_reduced_problem(atoms::AbstractVector{<:Array}, hessian, weights, gradient, tolerance)\n\nSame as the two function above, but for the case where the active  set is formed by dense Arrays.\n\n\n\n\n\n","category":"method"},{"location":"reference.html#FrankWolfe.Strong_Frank_Wolfe_gap","page":"References","title":"FrankWolfe.Strong_Frank_Wolfe_gap","text":"Checks the strong Frank-Wolfe gap for the reduced problem.\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.accelerated_simplex_gradient_descent_over_probability_simplex","page":"References","title":"FrankWolfe.accelerated_simplex_gradient_descent_over_probability_simplex","text":"accelerated_simplex_gradient_descent_over_probability_simplex\n\nMinimizes an objective function over the unit probability simplex  until the Strong-Wolfe gap is below tolerance using Nesterov's  accelerated gradient descent.\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.simplex_gradient_descent_over_probability_simplex","page":"References","title":"FrankWolfe.simplex_gradient_descent_over_probability_simplex","text":"simplexgradientdescentoverprobability_simplex\n\nMinimizes an objective function over the unit probability simplex  until the Strong-Wolfe gap is below tolerance using gradient descent.\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.projection_simplex_sort","page":"References","title":"FrankWolfe.projection_simplex_sort","text":"projection_simplex_sort(x; s=1.0)\n\nPerform a projection onto the probability simplex of radius s using a sorting algorithm.\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.Strong_Frank_Wolfe_gap_probability_simplex","page":"References","title":"FrankWolfe.Strong_Frank_Wolfe_gap_probability_simplex","text":"StrongFrankWolfegapprobability_simplex\n\nCompute the Strong-Wolfe gap over the unit probability simplex  given a gradient.\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.simplex_gradient_descent_over_convex_hull","page":"References","title":"FrankWolfe.simplex_gradient_descent_over_convex_hull","text":"simplexgradientdescentoverconvex_hull\n\nMinimizes an objective function over the convex hull of the active set until the Strong-Wolfe gap is below tolerance using simplex gradient descent.\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.lp_separation_oracle","page":"References","title":"FrankWolfe.lp_separation_oracle","text":"Returns either a tuple (y, val) with y an atom from the active set satisfying the progress criterion and val the corresponding gap dot(y, direction) or the same tuple with y from the LMO.\n\ninplace_loop controls whether the iterate type allows in-place writes. kwargs are passed on to the LMO oracle.\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.LineSearchMethod","page":"References","title":"FrankWolfe.LineSearchMethod","text":"Line search method to apply once the direction is computed.\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.Emphasis","page":"References","title":"FrankWolfe.Emphasis","text":"Emphasis given to the algorithm for memory-saving or not. The memory-saving mode may not be faster than the default blas mode for small dimensions.\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.ObjectiveFunction","page":"References","title":"FrankWolfe.ObjectiveFunction","text":"ObjectiveFunction{VT}\n\nRepresents an objective function optimized by algorithms. Subtypes of ObjectiveFunction must implement at least\n\ncompute_value(::ObjectiveFunction, x) for primal value evaluation\ncompute_gradient(::ObjectiveFunction, x) for gradient evaluation.\n\nand optionally compute_value_gradient(::ObjectiveFunction, x) returning the (primal, gradient) pair.\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.compute_value_gradient","page":"References","title":"FrankWolfe.compute_value_gradient","text":"compute_value_gradient(f::ObjectiveFunction, x; kwargs)\n\nComputes in one call the pair (function_value, function_grad) evaluated at x. By default, calls compute_value and compute_gradient with keyword kwargs passed to both.\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.StochasticObjective","page":"References","title":"FrankWolfe.StochasticObjective","text":"StochasticObjective{F, G, XT}(f::F, grad::G, xs::XT)\n\nRepresents an objective function evaluated with stochastic gradient. f(θ, x) evaluates the loss for data point x and parameter θ. grad(θ, x) evaluates the loss gradient with respect to data point x at parameter θ. xs must be an indexable iterable (Vector{Vector{Float64}} for instance). Functions using a StochasticObjective have optional keyword arguments rng, batch_size and full_evaluation controlling whether the function should be evaluated over all data points.\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.ScaledHotVector","page":"References","title":"FrankWolfe.ScaledHotVector","text":"ScaledHotVector{T}\n\nRepresents a vector of at most one value different from 0.\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.RankOneMatrix","page":"References","title":"FrankWolfe.RankOneMatrix","text":"RankOneMatrix{T, UT, VT}\n\nRepresents a rank-one matrix R = u * vt'. Composes like a charm.\n\n\n\n\n\n","category":"type"},{"location":"reference.html#FrankWolfe.line_search_wrapper","page":"References","title":"FrankWolfe.line_search_wrapper","text":"line search wrapper NOTE: The stepsize is defined as x - gamma * d\n\nReturns the step size gamma and the Lipschitz estimate L\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.adaptive_step_size","page":"References","title":"FrankWolfe.adaptive_step_size","text":"Slight modification of Adaptive Step Size strategy from https://arxiv.org/pdf/1806.05123.pdf\n\nNote: direction is opposite to the improving direction norm(gradient, direction) > 0 TODO: \n\nmake emphasis aware and optimize\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.plot_results","page":"References","title":"FrankWolfe.plot_results","text":"plot_results\n\nGiven a series of list, generate subplots. listdatay -> contains a list of a list of lists (where each list refers to a subplot, and a list of lists refers to the y-values of the series inside a subplot). listdatax -> contains a list of a list of lists (where each list refers to a subplot, and a list of lists refers to the x-values of the series inside a subplot). So if we have one plot with two series, these might look like:     listdatay = [[[1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6]]]     listdatax = [[[1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6]]]\n\nAnd if we have two plots, each with two series, these might look like:     listdatay = [[[1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6]], [[7, 8, 9, 10, 11, 12], [7, 8, 9, 10, 11, 12]]]     listdatax = [[[1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6]], [[7, 8, 9, 10, 11, 12], [7, 8, 9, 10, 11, 12]]]\n\nlistlabel -> contains the labels for the series that will be plotted, which has to have a length equal to the number of series that are being plotted:     listlabel = [\"Series 1\", \"Series 2\"]\n\nlistaxisx -> contains the labels for the x-axis that will be plotted,  which has to have a length equal to the number of subplots:      listaxisx = [\"x-axis plot 1\", \"x-axis plot 1\"]\n\nlistaxisy -> Same as listaxisx but for the y-axis\n\nxscalelog -> A list of values indicating the type of axes to use in each subplot, must be equal to the number of subplots:     xscalelog = [:log, :identity]\n\nyscalelog -> Same as xscalelog but for the y-axis\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe._unsafe_equal","page":"References","title":"FrankWolfe._unsafe_equal","text":"isequal without the checks. Assumes a and b have the same axes.\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.check_gradients","page":"References","title":"FrankWolfe.check_gradients","text":"Check if the gradient using finite differences matches the grad! provided.\n\n\n\n\n\n","category":"function"},{"location":"reference.html#FrankWolfe.trajectory_callback","page":"References","title":"FrankWolfe.trajectory_callback","text":"trajectory_callback(storage)\n\nCallback pushing the state at each iteration to the passed storage. The state data is only the 5 first fields, usually: (t,primal,dual,dual_gap,time)\n\n\n\n\n\n","category":"function"},{"location":"indexlist.html#Index","page":"Index","title":"Index","text":"","category":"section"},{"location":"indexlist.html","page":"Index","title":"Index","text":"","category":"page"},{"location":"index.html#Introduction","page":"Home","title":"Introduction","text":"","category":"section"},{"location":"index.html","page":"Home","title":"Home","text":"","category":"page"},{"location":"index.html","page":"Home","title":"Home","text":"This package defines a generic interface and several implementations for Frank-Wolfe algorithms.","category":"page"}]
}