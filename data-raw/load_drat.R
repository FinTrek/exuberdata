push_local <- function(msg = NULL) {
  if (is.null(msg)) msg <- "updated data"
  local_repo <- git2r::repository()
  git2r::add(local_repo, path = ".")
  git2r::commit(local_repo, message = msg)
  git2r::push(local_repo, name = "origin", refspec = "refs/heads/master",
             credentials = git2r::cred_token(), set_upstream = TRUE)
}

load_drat <- function(repo = "../drat") {
  # Assure that you have update local repo b,efore pushing to drat
  
  # Start Building
  pkg <- devtools::build()
  drat::addRepo("kvasilopoulos")
  drat::insertPackage(pkg, repodir = repo, commit = TRUE)
  
  # commit and push the new version -----------------------------------------
  drat_repo <- git2r::repository(repo)
  
  # git2r::pull(drat_repo, ".")
  
  # git2r::add(drat_repo, ".")
  # git2r::commit(drat_repo, "Update Data")
  git2r::push(drat_repo, name = "origin", refspec = "refs/heads/gh-pages", 
              credentials = git2r::cred_token(), set_upstream = TRUE)
  on.exit(unlink(pkg))
}

