makeCacheMatrix <- function(m = numeric()) {
  mat <- NULL
  get <- function() {
    mat
  }
  set <- function(v) {
    mat <<- v
  }
  list(set = set, get = get)
}