## These 2 functions enable to calculate matrix inversion and store it
## in cache. The purpose is to avoid repeating time consuming computation.
## example call: mx <- makeCacheMatrix(matrix(c(2,5,1,3),nrow=2,ncol=2))
##               cacheSolve(mx)


## makeCacheMatrix creates an object-list based on a matrix. 
## It can be used for catching the inverse of that matrix.
## ! Assumption: x is always a square invertible matrix !

makeCacheMatrix <- function(x = matrix()) {
        #browser()
        a <- NULL
        set <- function(b = matrix()) {
                x <<- b
                a <<- x
        }
        get <- function() x
        setinv <- function(solve) a <<- solve
        getinv <- function() a
        list(set = set, get = get,
             setinv = setinv,
             getinv = getinv)
}

## cacheSolve checks if the inverse of the matrix from makeCacheMatrix has 
## already been computed. If so and the matrix not changed, it returns 
## the inverse from cache, otherwise it computes the inverse of the matrix 

cacheSolve <- function(x, ...) {
        #browser()
        a <- x$getinv()
        if(!is.null(a)) {
                message("getting matrix inversion from cache")
                return(a)
        }
        data <- x$get()
        a <- solve(data)
        x$setinv(a)
        a
}

