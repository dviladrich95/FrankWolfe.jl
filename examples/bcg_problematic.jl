import FrankWolfe
using LinearAlgebra
using Random

s = rand(1:100)
s = 98
@info "Seed $s"
Random.seed!(s)


n = Int(1e2)
k = 3000

xpi = rand(n * n);
total = sum(xpi);
# next line needs to be commented out if we use the GLPK variants
xpi = reshape(xpi, n, n)
const xp = xpi # ./ total;

# better for memory consumption as we do coordinate-wise ops

function cf(x, xp)
    return LinearAlgebra.norm(x .- xp)^2 / n^2
end

function cgrad!(storage, x, xp)
    return @. storage = 2 * (x - xp) / n^2
end

# initial direction for first vertex
direction_vec = Vector{Float64}(undef, n * n)
randn!(direction_vec)
direction_mat = reshape(direction_vec, n, n)

lmo = FrankWolfe.BirkhoffPolytopeLMO()
x00 = FrankWolfe.compute_extreme_point(lmo, direction_mat)

FrankWolfe.benchmark_oracles(
    x -> cf(x, xp),
    (str, x) -> cgrad!(str, x, xp),
    () -> randn(n, n),
    lmo;
    k=100,
)


# BCG run

x0 = deepcopy(x00)

@time x, v, primal, dual_gap, trajectoryBCG = FrankWolfe.blended_conditional_gradient(
    x -> cf(x, xp),
    (str, x) -> cgrad!(str, x, xp),
    lmo,
    x0,
    max_iteration=k,
    L=100,
    line_search=FrankWolfe.adaptive,
    print_iter=k / 10,
    linesearch_tol=1e-7,
    emphasis=FrankWolfe.memory,
    trajectory=true,
    verbose=true,
);


data = [trajectoryBCG]
label = ["BCG"]

FrankWolfe.plot_trajectories(data, label)