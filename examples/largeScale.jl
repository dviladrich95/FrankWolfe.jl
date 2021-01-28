import FrankWolfe
import LinearAlgebra

n = Int(1e9)
k = 1000

xpi = rand(n);
total = sum(xpi);
const xp = xpi ./ total;

f(x) = norm(x - xp)^2
grad(x) = 2 * (x - xp)

# better for memory consumption as we do coordinate-wise ops

function cf(x, xp)
    return @. norm(x - xp)^2
end

function cgrad(x, xp)
    return @. 2 * (x - xp)
end

lmo = FrankWolfe.ProbabilitySimplexOracle(1);
x0 = FrankWolfe.compute_extreme_point(lmo, zeros(n));

FrankWolfe.benchmark_oracles(x -> cf(x, xp), x -> cgrad(x, xp), lmo, n; k=100, T=Float64)

@time x, v, primal, dual_gap, trajectory = FrankWolfe.fw(
    cf,
    cgrad,
    lmo,
    x0,
    max_iteration=k,
    line_search=FrankWolfe.agnostic,
    print_iter=k / 10,
    emphasis=FrankWolfe.memory,
    verbose=true,
);
