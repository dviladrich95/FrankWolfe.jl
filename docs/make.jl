using Documenter, FrankWolfe
using SparseArrays
using LinearAlgebra

using Literate, Test

const _EXAMPLE_DIR = joinpath(@__DIR__, "src", "examples")

"""
    _include_sandbox(filename)
Include the `filename` in a temporary module that acts as a sandbox. (Ensuring
no constants or functions leak into other files.)
"""
function _include_sandbox(filename)
    mod = @eval module $(gensym()) end
    return Base.include(mod, filename)
end

function _file_list(full_dir, relative_dir, extension)
    return map(
        file -> joinpath(relative_dir, file),
        filter(file -> endswith(file, extension), sort(readdir(full_dir))),
    )
end

function literate_directory(dir)
    rm.(_file_list(dir, dir, ".md"))
    for filename in _file_list(dir, dir, ".jl")
        # `include` the file to test it before `#src` lines are removed. It is
        # in a testset to isolate local variables between files.
        @testset "$(filename)" begin
            _include_sandbox(filename)
        end
        Literate.markdown(
            filename,
            dir;
            documenter = true,
        )
    end
    return
end

literate_directory(_EXAMPLE_DIR)

ENV["GKSwstype"] = "100"

makedocs(
    modules=[FrankWolfe],
    sitename="FrankWolfe.jl",
    format=Documenter.HTML(prettyurls=get(ENV, "CI", nothing) == "true"),
    pages=[
        "Home" => "index.md",
        "Examples" => [
        joinpath("examples", f) for f in readdir(_EXAMPLE_DIR) if endswith(f, ".md")
        ],
        "References" => "reference.md",
        "Index" => "indexlist.md",
    ],
)

deploydocs(repo="github.com/ZIB-IOL/FrankWolfe.jl.git", push_preview=true)
