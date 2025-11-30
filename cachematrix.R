## The makeCacheMatrix function creates a special list object that stores a matrix and also contains a cache for its inverse. The structure is based on the example from the exercise in which the mean value of a vector was temporarily stored. This principle has been applied to matrices here.

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL      # Cache für die Inverse
  
  set <- function(y) {
    x <<- y        # neue Matrix setzen
    inv <<- NULL   # Cache resetten, weil Matrix sich geändert hat
  }
  
  get <- function() {
    x
  }
  
  setinv <- function(inverse) {
    inv <<- inverse
  }
  
  getinv <- function() {
    inv
  }
  
  list(
    set = set,
    get = get,
    setinv = setinv,
    getinv = getinv
  )
}

## The cacheSolve function computes the inverse of the matrix stored inside a makeCacheMatrix object. It first checks whether the inverse is already available in the cache. If so, it returns the cached value immediately to avoid redundant computation.
cacheSolve <- function(x, ...) {
  inv <- x$getinv()
  
  if (!is.null(inv)) {
    message("getting cached data")
    return(inv)
  }
  
  mat <- x$get()
  inv <- solve(mat, ...)   # Inverse berechnen
  x$setinv(inv)
  inv
}
