using Pkg
Pkg.activate(@__DIR__)

example_files = filter(readdir(@__DIR__, join=true)) do f
    endswith(f, ".jl") && occursin("test_example", f)
end

for file in example_files
    @info "running example $file"
    include(file)
    println(a)
end