makeCacheMatrix <- function(x = matrix()){
      inversa <- NULL
      set <- function(y){
            x <<- y
            inv <<- NULL
      }
      get <- function() {x}
      setInverse <- function(inverse) {inversa <<- inverse}
      getInverse <- function() {inversa}
      list(set = set, 
           get = get,
           setInverse = setInverse,
           getInverse = getInverse)
}

cacheSolve <- function(x, ...){
      inversa <- x$getInverse()
      if(!is.null(inversa)){
            message("getting cached data")
            return(inversa)
      }
      matris <- x$get()
      inversa <- solve(matris, ...)
      x$setInverse(inversa)
      inv
}