## Assigning a value to x
x <- 1
print(x)

## all variables are vectors

## assign a range to a variable
y <- 1:20
y

## atomic types: character, numeric, integer, 
##               complex, logical (true/false)
## basic object: vector
##  - can only contain the same atomic types
##  - except is a list
##  - empty vectors can be created with vector()

## explicity make an integer
x <- 3L

## infinity
i <- Inf

## Not a number
n <- NaN

## Attributes of objects: names, dimnames
##      dimensions (matrices, arrays), class, 
##      length, user defined other
##    - can be accessed using the attributes() function

## create a vector with values
y <- c(0.5, 0.6, 0.7)
y

## convert types
## as.numeric(x), as.logical(x), as.character(x)
as.character(y)
y
## when converting doesnt work "NA" will be the value

## List, like a vector but elements can be different types
y <- list(1, "a", TRUE, 1+4i)
y

## Matrices
m <- matrix(nrow = 2, ncol = 3)
m
dim(m) ## showsthe dimension of the matrix
attributes(m) ## returns the dimension attribute of m

m <- matrix(1:6, nrow=2, ncol=3) #inserts values by column

## turn a set of values into a matrix
y <- 1:10 ## values
y
dim(y) <- c(2, 5) ## add dimensions
y

## binding, taking sets of values and concatenating them 
## to make matrices
x <- 1:3
y <- 10:12
cbind(x,y)
rbind(x, y)

## Factors represent categorical data
## unordered and ordered
x <- factor(c("yes", "yes", "no", "yes", "no"))
x
table(x)
unclass(x)
## assigning order of levels
x <- factor(c("yes", "yes", "no", "yes", "no"), levels=c("yes","no"))
unclass(x)

## missing values
is.na(x)
is.nan(x)

## Data Frames
##  - used to store tabular data
##  - special attribute called row.names (used for annotation)
##  - created by read.table(), or read.csv()
##  - converted to a matrix data.matrix()
x <- data.frame(foo = 1:4, bar = c(T,T,F,F))
x
nrow(x)
ncol(x)

## Names
x <- 1:3
names(x)
names(x) <- c("foo", "bar", "norf")
x
names(x)
x

## Lists with names
x <- list(a = 1, b=2, c=3)
x

#Matrices with names
m <- matrix(1:4, nrow=2, ncol=2)
dimnames(m) <- list(c("a", "b"), c("c", "d"))
m

## Reading data
## read.table, read.csv, readLines, source, dget, load
## unserialize

## read.table arguments: file, header, sep, colClasses, nrows
##    comment.char, skip, stringsAsFactors
## basic: usage data <- read.table("foo.txt")
##    automatically will set other arguments
## read.csv is basically the same as read.table

## Reading large data
## - make sure there is enough RAM to store data
## - use the colClasses argument so R doesn't choke

## read in some data find the types, then read in the
## whole data set with colClasses set
##    initial <-read.table("datatable.txt", nrows=100)
##    classes <- sapply(initial, class)
##    tabAll <- read.table("database.txt", colClasses = classes)

## Writing data
## write.table, writeLines, dump, dput, save, serialize

## Subsetting elements
## [] to return an element
x <- c("a", "b", "c")
x[1]
x[1:2]
x[x>"a"]
u <- x > "a"
u

## Subsetting lists
x <- list(foo = 1:4, bar = 0.6, foof = 7:9)
x[1]
x[[1]]
x$bar
x[["bar"]]
x["bar"]

## multiple subsetted lists
x[c(1,3)]


## subsetting matrices
m <- matrix(1:6, 2, 3)
m
m[1,2]
m[2,1]
m[1,]
m[,2]

## if you want to retun a matrix from subsetting you have
## you have to set "drop" to false
m[1,2, drop = FALSE]
m[1, , drop =FALSE]

## partial matching
x <- list(aardvark = 1:5)
x$a
x[["a"]]
x[["a", exact = FALSE]]


## removing missing values
x <- c(1, 2, NA, 4, NA, 5)
bad <- is.na(x)  ## finds locations of NA
x[!bad]          ## return everything that isn't in bad


y <- c("a", "b", NA, "d", NA, "f")
good <- complete.cases(x, y)
good
x[good]
y[good]
