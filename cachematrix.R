# Written by Larry Mannings, 25 November 2025

# makeCacheMatrix() function leverages the makeVector example from R Programming
# Ass. 2, modified to create a list consisting of cached matrix and 
# corresponding inverse.

makeCacheMatrix <- function(x = numeric()) {
    
    # x is numeric matrix object representing an invertible matrix
    # i is matrix object representing inverse of matrix object (x)
    
    # Initialize the inverse matrix to NULL
    i <- NULL
    
    # Set the value of the matrix
    set <- function(y) {
        x <<- y
        i <<- NULL
    }
    # Get the value of the matrix
    get <- function() x
    
    # Set the value of the inverse matrix
    setinv <- function(inv) i <<- inv
    
    # Get the value of the inverse matrix
    getinv <- function() i
    
    # Store objects in a list and return
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
}


#---------------------------------------------------------------------------

# cacheSolve() function leverages the cachemean() example from R Programming
# Ass. 2, modified to compute the inverse of the returned by 
# makeCacheMatrix() function.

cacheSolve <- function(x, ...) {
    
    # x is list object representing constructed from the makeCacheMatrix 
    # function
    # i is matrix object representing inverse of matrix object (x)
    
    # Call the getinv(function) as a list object to get matrix inverse 
    i <- x$getinv()
    # If the inverse has already been calculated retrieve from the cache
    if(!is.null(i)) {
        message("getting cached data")
        return(i)
    }
    # Else, retrieve the cached matrix and solve for the inverse matrix
    data <- x$get()
    i <- solve(data, ...)
    # Cache the inverse matrix and return value
    x$setinv(i)
    i
}