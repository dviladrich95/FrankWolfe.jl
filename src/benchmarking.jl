"""
Runs a function at a commit on a repo and afterwards goes back
to the original commit / branch.
"""
function withcommit(f, repo, commit)
    original_commit = shastring(repo, "HEAD")
    LibGit2.transact(repo) do r
        branch = try LibGit2.branch(r) catch err; nothing end
        try
            LibGit2.checkout!(r, shastring(r, commit))
            f()
        catch err
            rethrow(err)
        finally
            if branch !== nothing
                LibGit2.branch!(r, branch)
            else
                LibGit2.checkout!(r, original_commit)
            end
        end
    end
end

shastring(r::LibGit2.GitRepo, targetname) = string(LibGit2.revparseid(r, targetname))
shastring(dir::AbstractString, targetname) = LibGit2.with(r -> shastring(r, targetname), LibGit2.GitRepo(dir))