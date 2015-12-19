## Matrix inversion is a costly computation for large matrices,
## for this reason it is beneficial to create a cache of the 
## resulting inverse matrix. 

## makeCacheMatrix returns a list containing the functions to..
## set - set the value of the original matrix
## get - get the value of the original matrix
## setinverse - compute and store the inverse of the matrix
## getinverse - get the cached inversed matrix
makeCacheMatrix <- function(x = matrix()) {
      i <- NULL
      set <- function(y) {
            x <<- y
            i <<- NULL
      }
      get <- function() x
      setinverse <- function(solve) i <<- solve
      getinverse <- function() i
      list(set = set, get = get,
           setinverse = setinverse,
           getinverse = getinverse)
}



## cacheSolve returns the inverse of the matrix. If the inverse 
## of the matrix has already been cached, then it simply returns 
## the cached matrix, if not then it calculates the inverse, 
## caches it, and then returns it.
cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    i <- x$getinverse()
    if(!is.null(i)) {
        message("getting cached data")
        return(i)
    }
    data <- x$get()
    i <- solve(data, ...)
    x$setinverse(i)
    i
}

## Sample run:
## > x <- rbind(c(7, 2, 1), c(0, 3, -1), c(-3, 4, -3))
## > m <- makeCacheMatrix(x)
## > cacheSolve(m)
## [,1] [,2]  [,3]
## [1,]  0.25 -0.5  0.25
## [2,] -0.15  0.9 -0.35
## [3,] -0.45  1.7 -1.05
## > cacheSolve(m)
## getting cached data
## [,1] [,2]  [,3]
## [1,]  0.25 -0.5  0.25
## [2,] -0.15  0.9 -0.35
## [3,] -0.45  1.7 -1.05
