makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL  # this will store the inverse later
  
  # 1. set() - set a new matrix and reset cached inverse
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  
  # 2. get() - get the current matrix
  get <- function() x
  
  # 3. setinverse() - store (cache) the inverse
  setinverse <- function(inverse) inv <<- inverse
  
  # 4. getinverse() - get the cached inverse
  getinverse <- function() inv
  
  # return a list of all 4 functions
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}

cacheSolve <- function(x, ...) {
  inv <- x$getinverse()  # check if inverse already cached
  
  if (!is.null(inv)) {   # if yes, just return it
    message("getting cached data")
    return(inv)
  }
  
  # if not cached, calculate it
  data <- x$get()
  inv <- solve(data, ...)  # compute inverse
  x$setinverse(inv)        # store inverse in cache
  
  inv                      # return the result
}
