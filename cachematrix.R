## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) { ## arg. definition with default mode of "matrix"
    nu <- NULL                             ## set nu to NULL to hold value of matrix inverse
    set <- function(y) {                    ## set function
        x <<- y                             ## value of matrix in parent environment
        nu <<- NULL                        ## if there is a new matrix, reset nu to NULL
    }
    get <- function() x                     ## get function returns value of the matrix argumen
    
    setinverse <- function(inverse) nu <<- inverse  ## assigns value of nu in parent environment
    getinverse <- function() nu                     ## gets the value of nu where called
    list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)  }



## Write a short comment describing this function

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    nu <- x$getinverse()
    if(!is.null(nu)) {
        message("getting cached data")
        return(nu)
    }
    data <- x$get()
    nu <- solve(data, ...)
    x$setinverse(nu)
    nu
}

