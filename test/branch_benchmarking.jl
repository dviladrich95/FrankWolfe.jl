using FrankWolfe
using Test
using LinearAlgebra
using DelimitedFiles
using SparseArrays
using LibGit2
import FrankWolfe: ActiveSet



function get_include(file)
    function run_include()
        Base.invokelatest(include(file))
        return nothing
    end
end


suite=Dict()
dir_base = pwd()
example_dir = joinpath(dir_base, "examples")


example_files = filter(readdir(example_dir, join=true)) do f
    endswith(f, ".jl") && occursin("test_example_", f)
end

for file in example_files

    run_include = get_include(dir_base)

    repo_base = LibGit2.GitRepo(dir_base)
    commit_base = LibGit2.peel(LibGit2.GitCommit,LibGit2.head(repo_base))
    shastring_base = string(LibGit2.GitHash(commit_base))

    suite[shastring_base] = run_include()

    # branch where the iteration count of the benchmarking_suite.jl frank_wolfe call was halved

    commit_branch = LibGit2.GitObject(repo_base,"benchmarking-mirror")

    shastring_branch = string(LibGit2.GitHash(commit_branch))

    suite[shastring_branch] = FrankWolfe.withcommit(run_include, repo_base,shastring_branch)

end
