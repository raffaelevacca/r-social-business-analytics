# Author: Raffaele Vacca | www.raffaelevacca.com | raffaele.vacca@unimi.it
#
# License:
# Creative Commons Attribution-NonCommercial-ShareAlike 
# CC BY-NC-SA
# http://creativecommons.org/licenses/by-nc-sa/3.0/


############################################################################## #
###                          STARTING R                                     ====
############################################################################## #
## ---- starting 

# What's the current working directory? 
# getwd() 
# Un-comment to check your actual working directory.

# Change the working directory. 
# setwd("/my/working/directory") 
# (Delete the leading "#" and type in your actual working directory's path
# instead of "/my/working/directory")

# You should use R projects (.Rproj) to point to a working directory instead of
# manually changing it.

# Suppose that we want to use the package "igraph" in the following code.
library(igraph)

# Note that we can only load a package if we have it installed. In this case, I
# have igraph already installed. Had this not been the case, I would have have
# needed to install it: 
# install.packages("igraph").
# (Packages can also be installed through an RStudio menu item).

# Let's load another suite of packages we'll use in the rest of this script.
library(tidyverse)

# Note that whatever is typed after the "#" sign has no effect but to be printed
# as is in the console: it is a comment.


## ---- end-starting
############################################################################## #
###                         OBJECTS IN R                                    ====
############################################################################## #
## ---- objects 

# Create the object a: assign the value 50 to the name "a"
a <- 50

# Display ("print") the object a.
a

# Let's create another object.
b <- "Mark"

# Display it.
b

# Create and display object at the same time.
(obj <- 10)

# Let's reuse the object we created for a simple operation.
a + 3

# What if we want to save this result?
result <- a + 3

# All objects in the workspace
ls()

# Now we can view that result whenever we need it.
result

# ...and further re-use it
result*2

# Note that R is case-sensitive, "result" is different from "reSult".
reSult

# Let's clear the workspace before proceeding.
rm(list=ls())

# The workspace is now empty.
ls()



# ---- end-objects
############################################################################## #
###                     VECTORS, MATRICES, DATA FRAMES                      ====
############################################################################## #
## ---- vectors 

# Let's create a simple vector.
(x <- c(1, 2, 3, 4))

# Shortcut for the same thing.
(y <- 1:4)

# What's the length of x?
length(x)

# Note that when we print vectors, numbers in square brackets indicate positions
# of the vector elements.

# Create a simple matrix.
adj <- matrix(c(0,1,0, 1,0,0, 1,1,0), nrow= 3, ncol=3)

# This is what our matrix looks like:
adj

# Notice the row and column numbers in square brackets. 

# Normally we create data frames by importing data from external files, for
# example csv files.
data <- read_csv("./data/data.csv")

# View the result.
data

# Note the different pieces of information that are displayed when printing a tibble
# data frame.

# ---- end-vectors
############################################################################## #
###            ARITHMETIC, STATISTICAL, COMPARISON OPERATIONS               ====
############################################################################## #
## ---- operations

# Just a few arithmetic operations between vectors to demonstrate element-wise
# calculations and the recycling rule.

(v1 <- 1:4)
(v2 <- 1:4)

# [1 2 3 4] + [1 2 3 4]
v1 + v2

# [1 2 3 4] + 1
1:4 + 1

# [1 2 3 4] + [1 2]
(v1 <- 1:4)
(v2 <- 1:2)
v1 + v2

# [1 2 3 4] + [1 2 3]
1:4 + 1:3

# Let's do a simple arithmetic operation to get respondents' age in years.

# First, let's take a single variable from the ego attribute data: ego's year of 
# birth for the first 10 respondents. Let's put the result in a separate vector. 
# This code involves indexing, we'll explain that better below.

# Respondents' year of birth
year <- data[[1]]

# Let's see the first 10 values (i.e., first 10 respondents)
year[1:10]

# Age for the first 10 respondents
(age <- 2023-year[1:10])

# Relational operations.

# Note how the following comparisons are performed element-wise, and the value
# to which age is compared (30) is recycled.

# Is age equal to 30?
age==30

# The resulting logical vector is TRUE for those elements (i.e., respondents)
# who meet the condition.

# Which respondent's age is greater than 40?
age > 40

# Which respondent age values are lower than 40 OR greater than 60?
age < 40 | age > 60

# Which elements of "age" are lower than 40 AND greater than 30?
age < 40 & age > 30

# Notice the difference between OR (|) and AND (&).

# Is 30 in "age"? I.e., is one of the respondents of 30 years of age?
30 %in% age

# Is "age" in c(30, 42)? That is, which values of "age" are either 30 or 35?
age %in% c(30, 42)

# A logical vector can be converted to numeric: TRUE becomes 1 and FALSE becomes
# 0.
age > 45
as.numeric(age > 45)

# This allows us to use the sum() and the mean() functions to get the count and
# proportion of TRUE's in a logical vector.

# Count of TRUE's: Number of respondents (elements of "age") that are older than
# 40.
sum(age > 45)

# How many respondents in the vector are older than 30?
sum(age > 30)

# Proportion of TRUE's: What's the proportion of "age" elements (respondents)
# that are greater than 50?
mean(age > 50)


# ***** EXERCISES
#
# (1) Obtain a logical vector indicating which elements of "age" are smaller than 30
# OR greater than 50. Then obtain a logical vector indicating which elements of
# "age" are smaller than 30 AND greater than 50. Why all elements are FALSE in
# the latter vector?
#
# (2) Using the : shortcut, create a vector that goes from 1 to 100 in steps of 1.
# Obtain a logical vector that is TRUE for the first 10 elements and the last 10
# elements of the vector.
#
# (3) Use the age vector with relational operators and sum/mean to answer these
# questions: How many respondents are younger than 50? What percentage of
# respondents is between 30 and 40 years of age, including 30 and 40? Is there
# any respondent who is younger than 20 OR older than 70 (use any())?
#
# (4) How many elements of the vector 1:100 are greater than the length of that 
# vector divided by 2? Use sum().
#
# *****

# ---- end-operations
############################################################################## #
###                           SUBSETTING                                      ====
############################################################################## #
## ---- indexing

# Numeric subsetting                                                          ----
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# Let's use our vector of ego age values again.
age

# Index its 2nd element: The age of the 2nd respondent.
age[2]

# Its 2nd, 4th and 5th elements.
age[c(2,4,5)]

# Fifth to seventh elements
age[5:7]

# Use indexing to assign (replace) an element.
age[2] <- 45

# The content of x has now changed.
age

# Let's subset the adjacency matrix we created before.
adj

# Its 2,3 cell: Edge from node 2 to node 3.
adj[2,3]
# Its 2nd column: All edges to node 2.
adj[,2]
# Its 2nd and 3rd row: All edges from nodes 2 and 3.
adj[2:3,]

# Logical subsetting                                                          ----
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# Which values of "age" are between 40 and 60?

# Let's create a logical index that flags these values.
(ind <- age > 40 & age < 60)

# Use this index to extract these values from vector "age" via logical subsetting.
age[ind]

# We could also have typed directly:
age[age > 40 & age < 60]


# Subsetting data frames                                                     ---- 
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# We'll use our data frame (just its first 20 rows).
data.20 <- data |> 
  slice(1:20)

# Numeric subsetting works on data frames too: it allows you to index variables.

# The 3rd variable.
data.20[3]

# Note the difference with the double square bracket.
data.20[[3]]

# What do you think is the difference?
class(data.20[3])
class(data.20[[3]])

# The [[ ]] notation extracts the actual column as a vector, while [ ] keeps
# the data frame class.

# We can also subset data frames as matrices.
# The second and third columns.
data.20[,2:3]
# Lines 1 to 3
data.20[1:3,]

# We can use name indexing with data frames, selecting variables by name
data.20["company"]
data.20[["company"]]

# The $ notation is very common and concise. It's equivalent to the [[ notation.
data.20$company

# This is the same as data.20[[3]] or data.20[["ego.age"]]
identical(data.20[[5]], data.20$company)

# With tidyverse, this type of subsetting syntax is replaced by new "verbs" 
# (see next chapter):
# * Index data frame rows: filter() instead of []
# * Index data frame columns: select() instead of []
# * Extract data frame variable as a vector: pull() instead of [[]] or $


# ***** EXERCISES 
#
# Create the fictitious variable var <- c(1:30, rep(NA, 3), 34:50). Use is.na()
# to index all the NA values in the variable. Then use is.na() to index all
# values that are *not* NA. Hint: Remember the operator used to negate a logical
# vector. Finally, use this indexing to remove all NA values from var.
#
# *****


# ---- end-indexing
############################################################################## #
###                       PIPES                              ====
############################################################################## #
## ---- pipes

# Respondent gender variable 
gender <- data[[2]]

# First 10 values
gender[1:10]

# Frequency of gender categories in the data
table(gender)

# Average frequency
mean(table(gender))

# Let's re-write this with the pipe operator
gender |> 
  table() |> 
  mean()


# ---- end-pipes

############################################################################## #
###                        OBJECT TYPES AND CLASSES                              ====
############################################################################## #
## ---- types

# A numeric vector of integers.
n <- 1:100

# Let's check the class and type.
class(n)
typeof(n)

# A character object.
(char <- c("a", "b", "c", "d", "e", "f"))

# Class and type.
class(char)
typeof(char)

# Let's put n in a matrix.
(M <- matrix(n, nrow=10, ncol=10))

# Class/type of this object.
class(M)
# Type and mode tell us that this is an *integer* matrix.
typeof(M)

# There are character and logical matrices too.
char
(C <- matrix(char, nrow=3, ncol= 2))

# Class and type.
class(C)
typeof(C)

# Notice that a matrix can contain numbers but still be stored as character.
(M <- matrix(c("1", "2", "3", "4"), nrow=2, ncol=2))

class(M)
typeof(M)

# Let's convert "char" to factor.
char
(char <- as.factor(char))

# This means that now char is not just a collection of strings, it is a
# categorical variable in R's mind: it is a collection of numbers with character
# labels attached.

# Compare the different behavior of as.numeric(): char as character...
(char <- c("a", "b", "c", "d", "e", "f"))

# Convert to numeric
as.numeric(char)

# ...versus char as factor.
char <- c("a", "b", "c", "d", "e", "f")
(char <- as.factor(char))
as.numeric(char)

# char is a different object in R's mind when it's character vs when
# it's factor. Characters can't be converted to numbers,
# but factors can.

# ---- end-types
############################################################################## #
###                         WRITING R FUNCTIONS                             ====
############################################################################## #
## ---- functions

# Any piece of code you can write and run in R, you can also put in a function.

# Let's write a trivial function that takes its argument and multiplies it by 2.
times2 <- function(x) {
  x*2
}

# Now we can run the function on any argument.
times2(x= 3)
times2(x= 10)
times2(50)

# A function that takes its argument and prints a sentence with it:
myoutput <- function(word) {
  print(paste("My output is", word))
}

# Let's run the function.
myoutput("cat")
myoutput(word= "table")
myoutput("any word here")
# Not necessarily a useful function...

# Note that the function output is the last object that is printed at the end
# of the function code.
times2 <- function(x) {
  y <- x*2
  y
}
times2(x=4)

# If nothing is printed, then the function returns nothing.
times2 <- function(x) {
  y <- x*2
}
times2(x=4)

# A function will return an error if it's executed on arguments that are not
# suitable for the code inside the function. E.g., R can't multiply "a" by 2...
times2 <- function(x) {
  x*2
}
times2(x= "a")

# Let's then specify that the function's argument must be numeric.
times2 <- function(x) {
  stopifnot(is.numeric(x))  
  x*2
}

# Let's try it now.
times2(x= "a")
# This still throws and error, but it makes the error clearer to the user and 
# it immidiately indicates where the problem is.

# Using if, we can also re-write the function so that it returns NA with a
# warning if its argument is not numeric -- instead of just stopping with an
# error.
times2 <- function(x) {
  # If x is not numeric
  if(!is.numeric(x)) {
    # Give the warning
    warning("Your argument is not numeric!", call. = FALSE)
    # Return missing value
    return(NA)
    # Otherwise, return x*2
  } else {
    return(x*2)
  }
}

# Try the function
times2(2)
times2("a")

## ---- end-functions