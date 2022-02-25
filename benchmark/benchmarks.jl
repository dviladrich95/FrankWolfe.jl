using FrankWolfe
using Test
using LinearAlgebra
using DoubleFloats
using DelimitedFiles
import FrankWolfe: ActiveSet

import PkgBenchmark

SUITE = PkgBenchmark.BenchmarkGroup()

SUITE["vanilla_fw"] = PkgBenchmark.BenchmarkGroup(["step_size", "momentum"])
SUITE["lazified_cd"] = PkgBenchmark.BenchmarkGroup(["step_size", "cache"])
SUITE["blas_vs_memory"] = PkgBenchmark.BenchmarkGroup(["blas", "memory"])
SUITE["dense_structure"] = PkgBenchmark.BenchmarkGroup()
SUITE["rational"] = PkgBenchmark.BenchmarkGroup()
SUITE["multi_precision"] = PkgBenchmark.BenchmarkGroup()
SUITE["stochastic_fw"] = PkgBenchmark.BenchmarkGroup()
SUITE["away_step_fw"] = PkgBenchmark.BenchmarkGroup()
SUITE["blended_cg"] = PkgBenchmark.BenchmarkGroup()

# "Testing vanilla Frank-Wolfe with various step size and momentum strategies" begin
    f(x) = norm(x)^2
    function grad!(storage, x)
        return storage .= 2x
    end
    lmo_prob = FrankWolfe.ProbabilitySimplexOracle(1)
    x0 = FrankWolfe.compute_extreme_point(lmo_prob, zeros(5))
SUITE["vanilla_fw"]["1"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            x0,
            max_iteration=1000,
            line_search=FrankWolfe.Agnostic(),
            trajectory=true,
            verbose=false,
    )

 
SUITE["vanilla_fw"]["2"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            x0,
            max_iteration=1000,
            line_search=FrankWolfe.Agnostic(),
            trajectory=true,
            verbose=false,
            gradient=collect(similar(x0)),
    )
 

SUITE["vanilla_fw"]["3"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            x0,
            max_iteration=1000,
            line_search=FrankWolfe.Goldenratio(),
            trajectory=true,
            verbose=false,
    )
 

SUITE["vanilla_fw"]["4"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            x0,
            max_iteration=1000,
            line_search=FrankWolfe.Backtracking(),
            trajectory=true,
            verbose=false,
    )
 

SUITE["vanilla_fw"]["5"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            x0,
            max_iteration=1000,
            line_search=FrankWolfe.Nonconvex(),
            trajectory=true,
            verbose=false,
    )
 

SUITE["vanilla_fw"]["6"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
        f,
        grad!,
        lmo_prob,
        x0,
        max_iteration=1000,
        line_search=FrankWolfe.Shortstep(),
        L=2,
        trajectory=true,
        verbose=false,
    )
 

SUITE["vanilla_fw"]["7"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            x0,
            max_iteration=1000,
            line_search=FrankWolfe.Nonconvex(),
            trajectory=true,
            verbose=false,
    )
 

SUITE["vanilla_fw"]["8"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            x0,
            max_iteration=1000,
            line_search=FrankWolfe.Agnostic(),
            trajectory=true,
            verbose=false,
            momentum=0.9,
    )
 

SUITE["vanilla_fw"]["9"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            x0,
            max_iteration=1000,
            line_search=FrankWolfe.Agnostic(),
            trajectory=true,
            verbose=false,
            momentum=0.5,
    )
 

SUITE["vanilla_fw"]["10"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            x0,
            max_iteration=1000,
            line_search=FrankWolfe.Agnostic(),
            trajectory=true,
            verbose=false,
            momentum=0.9,
            emphasis=FrankWolfe.memory,
    )
 

SUITE["vanilla_fw"]["11"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            x0,
            max_iteration=1000,
            line_search=FrankWolfe.Adaptive(),
            L=100,
            trajectory=true,
            verbose=false,
            momentum=0.9,
    )
 

SUITE["vanilla_fw"]["12"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            x0,
            max_iteration=1000,
            line_search=FrankWolfe.Adaptive(),
            L=100,
            trajectory=true,
            verbose=false,
            momentum=0.5,
    )
 

SUITE["vanilla_fw"]["13"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            x0,
            max_iteration=1000,
            line_search=FrankWolfe.Adaptive(),
            L=100,
            trajectory=true,
            verbose=false,
            momentum=0.9,
            emphasis=FrankWolfe.memory,
    )



# # "Gradient with momentum correctly updated" begin
#     # fixing https://github.com/ZIB-IOL/FrankWolfe.jl/issues/47
#     include("momentum_memory.jl")
# end

# "Testing Lazified Conditional Gradients with various step size strategies" begin
        f(x) = norm(x)^2
        function grad!(storage, x)
            @. storage = 2x
            return nothing
        end
        lmo_prob = FrankWolfe.ProbabilitySimplexOracle(1)
        x0 = FrankWolfe.compute_extreme_point(lmo_prob, zeros(5))

    SUITE["lazified_cd"]["1"] = PkgBenchmark.@benchmarkable FrankWolfe.lazified_conditional_gradient(
                f,
                grad!,
                lmo_prob,
                x0,
                max_iteration=1000,
                line_search=FrankWolfe.Goldenratio(),
                trajectory=true,
                verbose=false,
        )



    SUITE["lazified_cd"]["2"] = PkgBenchmark.@benchmarkable FrankWolfe.lazified_conditional_gradient(
                f,
                grad!,
                lmo_prob,
                x0,
                max_iteration=1000,
                line_search=FrankWolfe.Backtracking(),
                trajectory=true,
                verbose=false,
        )



    SUITE["lazified_cd"]["3"] = PkgBenchmark.@benchmarkable FrankWolfe.lazified_conditional_gradient(
                f,
                grad!,
                lmo_prob,
                x0,
                max_iteration=1000,
                line_search=FrankWolfe.Shortstep(),
                L=2,
                trajectory=true,
                verbose=false,
        )




# "Testing Lazified Conditional Gradients with cache strategies" begin
    n = Int(1e5)
    L = 2
    k = 1000
    bound = 16 * L * 2 / (k + 2)

    f(x) = norm(x)^2
    function grad!(storage, x)
        @. storage = 2 * x
        return nothing
    end
    lmo_prob = FrankWolfe.ProbabilitySimplexOracle(1)
    x0 = FrankWolfe.compute_extreme_point(lmo_prob, zeros(n))

    SUITE["lazified_cd"]["4"] = PkgBenchmark.@benchmarkable FrankWolfe.lazified_conditional_gradient(
        f,
        grad!,
        lmo_prob,
        x0,
        max_iteration=k,
        line_search=FrankWolfe.Shortstep(),
        L=2,
        trajectory=true,
        verbose=false,
    )



    SUITE["lazified_cd"]["5"] = PkgBenchmark.@benchmarkable FrankWolfe.lazified_conditional_gradient(
        f,
        grad!,
        lmo_prob,
        x0,
        max_iteration=k,
        line_search=FrankWolfe.Shortstep(),
        L=2,
        cache_size=100,
        trajectory=true,
        verbose=false,
    )



    SUITE["lazified_cd"]["6"] = PkgBenchmark.@benchmarkable FrankWolfe.lazified_conditional_gradient(
        f,
        grad!,
        lmo_prob,
        x0,
        max_iteration=k,
        line_search=FrankWolfe.Shortstep(),
        L=2,
        cache_size=100,
        greedy_lazy=true,
        trajectory=true,
        verbose=false,
    )




# "Testing emphasis blas vs memory" begin
    n = Int(1e5)
    k = 100
    xpi = rand(n)
    total = sum(xpi)
    xp = xpi ./ total
    f(x) = norm(x - xp)^2
    function grad!(storage, x)
        @. storage = 2 * (x - xp)
        return nothing
    end
    # "Using sparse structure" begin
        lmo_prob = FrankWolfe.ProbabilitySimplexOracle(1.0)
        x0 = FrankWolfe.compute_extreme_point(lmo_prob, zeros(n))

    SUITE["blas_vs_memory"]["time"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            x0,
            max_iteration=k,
            line_search=FrankWolfe.Backtracking(),
            print_iter=k / 10,
            trajectory=true,
            verbose=false,
            emphasis=FrankWolfe.blas,
        )



    SUITE["blas_vs_memory"]["time"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            x0,
            max_iteration=k,
            line_search=FrankWolfe.Backtracking(),
            print_iter=k / 10,
            trajectory=true,
            verbose=false,
            emphasis=FrankWolfe.memory,
        )



    # "Using dense structure" begin
        lmo_prob = FrankWolfe.L1ballDense{Float64}(1)
        x0 = FrankWolfe.compute_extreme_point(lmo_prob, zeros(n))

    SUITE["dense_structure"]["time"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            copy(x0),
            max_iteration=k,
            line_search=FrankWolfe.Backtracking(),
            print_iter=k / 10,
            trajectory=true,
            verbose=false,
            emphasis=FrankWolfe.blas,
        )



    SUITE["dense_structure"]["time"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            copy(x0),
            max_iteration=k,
            line_search=FrankWolfe.Backtracking(),
            print_iter=k / 10,
            trajectory=true,
            verbose=false,
            emphasis=FrankWolfe.memory,
        )



        line_search = FrankWolfe.MonotonousStepSize()
    SUITE["dense_structure"]["time"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            copy(x0),
            max_iteration=k,
            line_search=line_search,
            print_iter=k / 10,
            trajectory=true,
            verbose=false,
            emphasis=FrankWolfe.memory,
        )


        line_search = FrankWolfe.MonotonousNonConvexStepSize()
    SUITE["dense_structure"]["time"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo_prob,
            copy(x0),
            max_iteration=k,
            line_search=line_search,
            print_iter=k / 10,
            trajectory=true,
            verbose=false,
            emphasis=FrankWolfe.memory,
        )



# "Testing rational variant" begin
    rhs = 1
    n = 40
    k = 1000

    xpi = rand(big(1):big(100), n)
    total = sum(xpi)
    xp = xpi .// total

    f(x) = norm(x - xp)^2
    function grad!(storage, x)
        @. storage = 2 * (x - xp)
    end

    lmo = FrankWolfe.ProbabilitySimplexOracle{Rational{BigInt}}(rhs)
    direction = rand(n)
    x0 = FrankWolfe.compute_extreme_point(lmo, direction)

SUITE["rational"]["time"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
        f,
        grad!,
        lmo,
        x0,
        max_iteration=k,
        line_search=FrankWolfe.Agnostic(),
        print_iter=k / 10,
        emphasis=FrankWolfe.blas,
        trajectory=true,
        verbose=false,
    )



SUITE["rational"]["time"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
        f,
        grad!,
        lmo,
        x0,
        max_iteration=k,
        line_search=FrankWolfe.Agnostic(),
        print_iter=k / 10,
        emphasis=FrankWolfe.memory,
        trajectory=true,
        verbose=false,
    )



    # very slow computation, explodes quickly
    x0 = collect(FrankWolfe.compute_extreme_point(lmo, direction))
SUITE["rational"]["time"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
        f,
        grad!,
        lmo,
        x0,
        max_iteration=15,
        line_search=FrankWolfe.RationalShortstep(),
        L=2,
        print_iter=k / 100,
        emphasis=FrankWolfe.memory,
        trajectory=true,
        verbose=false,
    )

    x0 = FrankWolfe.compute_extreme_point(lmo, direction)
SUITE["rational"]["time"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
        f,
        grad!,
        lmo,
        x0,
        max_iteration=15,
        line_search=FrankWolfe.RationalShortstep(),
        L=2,
        print_iter=k / 10,
        emphasis=FrankWolfe.memory,
        trajectory=true,
        verbose=false,
    )


# "Multi-precision tests" begin
    rhs = 1
    n = 100
    k = 1000

    xp = zeros(n)

    L = 2
    bound = 2 * L * 2 / (k + 2)

    f(x) = norm(x - xp)^2
    function grad!(storage, x)
        @. storage = 2 * (x - xp)
    end
    test_types = (Float16, Float32, Float64, Double64, BigFloat, Rational{BigInt})
    
    for T in test_types
        println("\nTesting precision for type: ", T)
        lmo = FrankWolfe.ProbabilitySimplexOracle{T}(rhs)
        direction = rand(n)
        x0 = FrankWolfe.compute_extreme_point(lmo, direction)

        SUITE["multi_precision"]["time"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo,
            x0,
            max_iteration=k,
            line_search=FrankWolfe.Agnostic(),
            print_iter=k / 10,
            emphasis=FrankWolfe.blas,
            trajectory=true,
            verbose=false,
        )




        SUITE["multi_precision"]["time"] = PkgBenchmark.@benchmarkable FrankWolfe.frank_wolfe(
            f,
            grad!,
            lmo,
            x0,
            max_iteration=k,
            line_search=FrankWolfe.Agnostic(),
            print_iter=k / 10,
            emphasis=FrankWolfe.memory,
            trajectory=true,
            verbose=false,
        )




        # SUITE["multi_precision"]["away_fw"] = PkgBenchmark.@benchmarkable FrankWolfe.away_frank_wolfe(
        #     f,
        #     grad!,
        #     lmo,
        #     x0,
        #     max_iteration=k,
        #     line_search=FrankWolfe.Adaptive(),
        #     print_iter=k / 10,
        #     emphasis=FrankWolfe.memory,
        #     trajectory=true,
        #     verbose=false,
        # )




        # SUITE["multi_precision"]["blended"] = PkgBenchmark.@benchmarkable FrankWolfe.blended_conditional_gradient(
        #     f,
        #     grad!,
        #     lmo,
        #     x0,
        #     max_iteration=k,
        #     line_search=FrankWolfe.Adaptive(),
        #     print_iter=k / 10,
        #     emphasis=FrankWolfe.memory,
        #     trajectory=true,
        #     verbose=false,
        # )
    end





# "Stochastic FW linear regression" begin
    function simple_reg_loss(θ, data_point)
        (xi, yi) = data_point
        (a, b) = (θ[1:end-1], θ[end])
        pred = a ⋅ xi + b
        return (pred - yi)^2 / 2
    end

    function ∇simple_reg_loss(storage, θ, data_point)
        (xi, yi) = data_point
        (a, b) = (θ[1:end-1], θ[end])
        pred = a ⋅ xi + b
        storage[1:end-1] .+= xi * (pred - yi)
        storage[end] += pred - yi
        return storage
    end

    xs = [10 * randn(5) for i in 1:20000]
    params = rand(6) .- 1 # start params in (-1,0)
    bias = 2π
    params_perfect = [1:5; bias]

    params = rand(6) .- 1 # start params in (-1,0)

    data_perfect = [(x, x ⋅ (1:5) + bias) for x in xs]
    f_stoch = FrankWolfe.StochasticObjective(simple_reg_loss, ∇simple_reg_loss, data_perfect, similar(params))
    lmo = FrankWolfe.LpNormLMO{2}(1.1 * norm(params_perfect))

    SUITE["stochastic_fw"]["1"] = PkgBenchmark.@benchmarkable FrankWolfe.stochastic_frank_wolfe(
        f_stoch,
        lmo,
        copy(params),
        momentum=0.95,
        trajectory=true,
        verbose=false,
        line_search=FrankWolfe.Nonconvex(),
        max_iteration=100_000,
        batch_size=length(f_stoch.xs) ÷ 100,
    )


    # SFW with incrementing batch size
    batch_iterator = FrankWolfe.IncrementBatchIterator(
        length(f_stoch.xs) ÷ 1000,
        length(f_stoch.xs) ÷ 10,
        2,
    )
    SUITE["stochastic_fw"]["batch_iterator"] = PkgBenchmark.@benchmarkable FrankWolfe.stochastic_frank_wolfe(
        f_stoch,
        lmo,
        copy(params),
        momentum=0.95,
        trajectory=true,
        verbose=false,
        line_search=FrankWolfe.Nonconvex(),
        max_iteration=5000,
        batch_iterator=batch_iterator,
        
    )

    # SFW damped momentum 
    momentum_iterator = FrankWolfe.ExpMomentumIterator()
    SUITE["stochastic_fw"]["damped_momentum"] = FrankWolfe.stochastic_frank_wolfe(
        f_stoch,
        lmo,
        copy(params),
        trajectory=true,
        verbose=false,
        line_search=FrankWolfe.Nonconvex(),
        max_iteration=5000,
        batch_size=1,
        
        momentum_iterator=momentum_iterator,
    )
    SUITE["stochastic_fw"]["damped_momentum"] = PkgBenchmark.@benchmarkable FrankWolfe.stochastic_frank_wolfe(
        f_stoch,
        lmo,
        copy(params),
        line_search=FrankWolfe.Nonconvex(),
        max_iteration=5000,
        batch_size=1,
        trajectory=true,
        verbose=false,
        
        momentum_iterator=nothing,
    )


# "Away-step FW" begin
    n = 50
    lmo_prob = FrankWolfe.ProbabilitySimplexOracle(1.0)
    x0 = FrankWolfe.compute_extreme_point(lmo_prob, rand(n))
    f(x) = norm(x)^2
    function grad!(storage, x)
        @. storage = 2x
    end
    k = 1000
    active_set = ActiveSet([(1.0, x0)]) 

    # compute reference from vanilla FW
    xref, _ = FrankWolfe.frank_wolfe(
        f,
        grad!,
        lmo_prob,
        x0,
        max_iteration=k,
        line_search=FrankWolfe.Backtracking(),
        trajectory=true,
        verbose=false,
        emphasis=FrankWolfe.blas,
    )

    SUITE["away_step_fw"]["1"] = PkgBenchmark.@benchmarkable FrankWolfe.away_frank_wolfe(
        f,
        grad!,
        lmo_prob,
        x0,
        max_iteration=k,
        line_search=FrankWolfe.Backtracking(),
        print_iter=k / 10,
        trajectory=true,
        verbose=false,
        emphasis=FrankWolfe.blas,
    )




    SUITE["away_step_fw"]["2"] = PkgBenchmark.@benchmarkable FrankWolfe.away_frank_wolfe(
        f,
        grad!,
        lmo_prob,
        x0,
        max_iteration=k,
        away_steps = false,
        line_search=FrankWolfe.Backtracking(),
        print_iter=k / 10,
        trajectory=true,
        verbose=false,
        emphasis=FrankWolfe.blas,
    )




    SUITE["away_step_fw"]["3"] = PkgBenchmark.@benchmarkable FrankWolfe.away_frank_wolfe(
        f,
        grad!,
        lmo_prob,
        active_set,
        max_iteration=k,
        line_search=FrankWolfe.Backtracking(),
        print_iter=k / 10,
        trajectory=true,
        verbose=false,
        emphasis=FrankWolfe.blas,
    )




    SUITE["away_step_fw"]["4"] = PkgBenchmark.@benchmarkable FrankWolfe.away_frank_wolfe(
        f,
        grad!,
        lmo_prob,
        x0,
        max_iteration=k,
        line_search=FrankWolfe.Backtracking(),
        print_iter=k / 10,
        trajectory=true,
        verbose=false,
        emphasis=FrankWolfe.memory,
    )




    SUITE["away_step_fw"]["5"] = PkgBenchmark.@benchmarkable FrankWolfe.away_frank_wolfe(
        f,
        grad!,
        lmo_prob,
        x0,
        max_iteration=k,
        away_steps=false,
        line_search=FrankWolfe.Backtracking(),
        print_iter=k / 10,
        trajectory=true,
        verbose=false,
        emphasis=FrankWolfe.memory,
    )




    SUITE["away_step_fw"]["6"] = PkgBenchmark.@benchmarkable FrankWolfe.away_frank_wolfe(
        f,
        grad!,
        lmo_prob,
        active_set,
        max_iteration=k,
        line_search=FrankWolfe.Backtracking(),
        print_iter=k / 10,
        trajectory=true,
        verbose=false,
        emphasis=FrankWolfe.memory,
    )

# "Blended conditional gradient" begin
    n = 50
    lmo_prob = FrankWolfe.ProbabilitySimplexOracle(1.0)
    x0 = FrankWolfe.compute_extreme_point(lmo_prob, randn(n))
    f(x) = norm(x)^2
    function grad!(storage, x)
        @. storage = 2x
    end
    k = 1000

    # compute reference from vanilla FW
    xref, _ = FrankWolfe.frank_wolfe(
        f,
        grad!,
        lmo_prob,
        x0,
        max_iteration=k,
        line_search=FrankWolfe.Backtracking(),
        trajectory=true,
        verbose=false,
        emphasis=FrankWolfe.blas,
    )

    SUITE["blended_cg"]["1"] = PkgBenchmark.@benchmarkable FrankWolfe.blended_conditional_gradient(
        f,
        grad!,
        lmo_prob,
        x0;
        line_search=FrankWolfe.Backtracking(),
        L=Inf,
        epsilon=1e-9,
        max_iteration=k,
        print_iter=1,
        
        trajectory=true,
        verbose=false,
        linesearch_tol=1e-10,
    )