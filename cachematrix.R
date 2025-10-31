## This function creates a special matrix object that can store a matrix ans its cached inverse

makeCacheMatrix <- function(x = matrix()) {
    m <- NULL
    set <- function(y){
        x <<- y
        m <<- NULL #Reset the inverse when the matrix changes
    }
    get <- function() x
    setsolve <- function(solve) m <<- solve
    getsolve <- function() m
    list(set =set, get=get, 
         setsolve=setsolve, 
         getsolve=getsolve)
}


## Computes the inverse of the special matrix object

cacheSolve <- function(x, ...) { #first checks if it has been already calculated
    m <- x$getsolve()
    if(!is.null(m)) {
        message("getting cached data") #if it has been calculated return the cached value
        return(m)
    }
    data <- x$get() #if it has not been calculated it makes the calculation
    m <-solve (data, ...)
    x$setsolve(m)
    m
    }
    ## Return a matrix that is the inverse of 'x'
