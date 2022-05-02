using FrankWolfe
using Test
using LinearAlgebra
using DelimitedFiles
using SparseArrays
using LibGit2
import FrankWolfe: ActiveSet

function get_include(file)
    return function run_include()
        return include(file)
    end
end

suite=Dict()
dir_base = pwd()
example_dir = joinpath(dir_base, "examples_benchmarking")

example_files = filter(readdir(example_dir, join=true)) do f
    endswith(f, ".jl") && occursin("test_example_", f)
end

for file in example_files
    repo_base = LibGit2.GitRepo(dir_base)
    commit_base = LibGit2.peel(LibGit2.GitCommit,LibGit2.head(repo_base))
    shastring_base = string(LibGit2.GitHash(commit_base))
    
    commit_branch = LibGit2.GitObject(repo_base,"benchmarking-mirror")
    shastring_branch = string(LibGit2.GitHash(commit_branch))

    run_include = get_include(file)
    suite[string(shastring_base,"_",file)] = run_include()
    suite[string(shastring_branch,"_",file)] = FrankWolfe.withcommit(run_include, repo_base,shastring_branch)
end
