## Put comments here that give an overall description of what your
## functions do

## this function returns a list of functions.
## the functions within the list all have their scope set within the parent function
## the functions within the list allow us to cache a matrix, retrieve a cached matrix, 
## cache inverse of the cached matrix, retrieve cached inverse of the a cached matrix

makeCacheMatrix <- function(x = matrix()) {
  i <- NULL
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  get <- function() x
  setinverse <- function() {
    i <<- solve(x)
  }
  getinverse <- function() i
  list(set=set,get=get,setinverse=setinverse,getinverse=getinverse)
}


## this function returns the inverse of the cached matrix within the variable
## the functions first checks if the inverse is cached and sends the cached results back if condition is true
## if the inverse of the matrix isn't cached the the function solves for the inverse, caches it, and shares back the result

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  i <- x$getinverse()
  if (!is.null(i)){
    message("from the cache")
    return(i)
  }
  i <- x$setinverse()
  i
}
