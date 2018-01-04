## makeCacheMatrix, and cacheSolve are 2 functions that we will use to save some
## processing for calculating matrix inverses. 

## makeCacheMatrix function takes a matrix as an argument, and creates functions
## on this matrix, such as set to set the values in this matrix, get to get the
## actual matrix data, and setinverse and getinverse to set and get the inverse
## of this matrix, then returns a list of all these functions..
makeCacheMatrix <- function(x = matrix()) {
    x_inv <- matrix()
    set <- function(y) {
        x <<- y
        x_inv <<-- matrix();
    }
    get <- function() x
    setinverse <- function(inv) x_inv <<- inv
    getinverse <- function() x_inv
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}

## cacheSolve, takes a makeCacheMatrix object as an argument, 
## checks if it already has an 
## inverse stored in it, if yes, it returns the inverse from cache
## if not it solves for the inverse saves it in cache and returns it.
cacheSolve <- function(x, ...) {
    #check if getinverse is not na, then we already calculated it
    if(!is.na(x$getinverse())){
        print("Getting inverse from cache")
        return(x$getinverse())
    }
    # get the matrix data
    data <- x$get()
    # solve for its inverse
    inv <- solve(data)
    # call set inverse to set the cache inverse
    x$setinverse(inv)
    # return the inverse
    x$getinverse()
}
