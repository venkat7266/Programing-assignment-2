## This function creates a special "matrix" object that can cache its inverse.
makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL  # Initialize the inverse as NULL
  
  # Setter function to update the matrix
  set <- function(y) {
    x <<- y
    inv <<- NULL  # Reset inverse when a new matrix is set
  }
  
  # Getter function to return the matrix
  get <- function() x
  
  # Setter function for the inverse
  setInverse <- function(inverse) inv <<- inverse
  
  # Getter function for the inverse
  getInverse <- function() inv
  
  # Return a list containing all four functions
  list(set = set, get = get,
       setInverse = setInverse,
       getInverse = getInverse)
}


## This function computes the inverse of the special matrix returned by makeCacheMatrix above.
## If the inverse has already been calculated, it retrieves it from the cache instead of recomputing.
cacheSolve <- function(x, ...) {
  inv <- x$getInverse()
  
  # Check if inverse already exists
  if (!is.null(inv)) {
    message("Getting cached inverse")
    return(inv)
  }
  
  # Otherwise, calculate the inverse
  mat <- x$get()
  inv <- solve(mat, ...)  # Compute the inverse using R's 'solve' function
  x$setInverse(inv)       # Cache the inverse for later use
  inv                     # Return the computed inverse
}
