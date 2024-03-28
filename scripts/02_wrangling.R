# Subsetting data frames with dplyr: filter and select                      ----
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# Filter to egos who are older than 40
data |> 
  filter(ego.age > 40)

# Filter to egos with Primary education
data |> 
  filter(ego.edu == "Primary")

# Combine the two conditions: Intersection.
data |> 
  filter(ego.age > 40 & ego.edu == "Primary")

# Combine the two conditions: Union.
data |> 
  filter(ego.age > 40 | ego.edu == "Primary")

# Note that the object data hasn't changed. To re-use any of the filtered data
# frames above, we have to assign them to an object.
data.40 <- data |> 
  filter(ego.age > 40)

data.40

# Select specific variables
data.40 |>
  dplyr::select(ego.sex, ego.age)

# As usual, we can re-assign the result to the same data object
data.40 <- data.40 |> 
  dplyr::select(ego.sex, ego.age)

data.40

# Pull a variable out of a data frame, as a vector
data |>
  pull(ego.age)

# This is the same as
data$ego.age