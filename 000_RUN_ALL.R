if (compareVersion(as.character(getRversion()), "4.1") < 0) {
  stop("Require at least R 4.1")
}

requiredPackages <- c(
  "tidyverse",
  "sandwich",
  "fixest",
  "foreach",
  "doParallel",
  "s2",
  "sf",
  "cowplot",
  "remotes",
  "rlang")
missingPackages <- requiredPackages[!requiredPackages %in% .packages(all = TRUE)]
lapply(missingPackages, install.packages) |> invisible()

# May need following specific version of ggplot2 for placing the legend correctly.
# remotes::install_version(
#   "ggplot2", 
#   version = "3.4.1", 
#   repos = "http://cran.us.r-project.org")



scripts <- 
  list.files(pattern ="^\\d{2}_\\d{1}_.*\\.R$") |> 
  sort()
for (script in scripts) {
  cat("Starting script", script, "\n")
  st <- Sys.time()
  errorCode <- system(paste("Rscript", script))
  cat("Finished running script", script, "after", format(Sys.time() - st), "\n")
  stopifnot(errorCode == 0)
}
