## these functions allow for calculating the inverse of a matrix and stores the final output
## this allows for data to be retrieved instead of recalculating when a matrix has already been previously calculated

## makeCacheMatrix() allows the user to create a matrix

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  
  # setter and getter for original matrix
  
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  
  get <- function() x
  
  # setter and getter for inverse 

  set_inverse <- function(solve) inv <<- solve
  get_inverse <- function() inv
  list(set = set, get = get,
       set_inverse = set_inverse,
       get_inverse = get_inverse)
}


## cacheSolve() finds the inverse of the matrix
## it gives the cached result if previously available

cacheSolve <- function(x, ...) {
  
  ## finds stored inverse and returns it if possible
  
  inv <- x$get_inverse()
  if(!is.null(inv)) {
    message("Getting cached inverse matrix...")
    return(inv)
  }
  
  ## calculates new matrix if unavailable
  
  data <- x$get()
  inv <- solve(data, ...)
  x$set_inverse(inv)
  
  inv
}
