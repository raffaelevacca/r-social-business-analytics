## ----message=FALSE-------------------------------------------------------------------------
# Load packages
library(tidyverse)
library(skimr)
library(janitor)

# Clear the workspace
rm(list = ls())

# Let's read the data in as a tibble data frame.
(data <- read_csv("./data/data.csv"))


## ------------------------------------------------------------------------------------------
# Give better names to the variables: by variable name.
data |> 
  rename(
    birth.y = `1. Il tuo anno di nascita è...`,
    gender = `2. Il tuo genere è...`
  )

# Give better names to the variables: by variable position.
data |> 
  rename(
    birth.y = 1,
    gender = 2
  )

# Rename all or a collection of variables with a function: .x represents each
# variable name
data |> 
  rename_with(~ toupper(.x))

# Final names 
data <- data |> 
  rename(
    birth.y = `1. Il tuo anno di nascita è...`,
    gender = `2. Il tuo genere è...`,
    nato.it = `4. Sei nato/a in Italia?`,
    edu = `11. Il tuo ultimo titolo di studi conseguito è...`
  )
data

# Subset to specific variables of interest.
data |> 
  select(gender, edu)

# Remove certain variables
data |> 
  select(-gender)
data |> 
  select(-c(gender, edu))

# Reorder variables.
data |> 
  select(company, edu, gender)

# Subset/reorder while renaming
data |> 
  select(company2 = company, education = edu)

# Select offers very flexible syntax to indicate variable names, for example:
# Select variables whose name ends with "y".
data |> 
  select(ends_with("y"))
# Select variables which are numeric.
data |> 
  select(where(is.numeric))

# See ?select for all options.

# Note the difference between these two types of subsetting.

# Option 1: keeping the data frame structure
data |> 
  select(birth.y)

# This is the same as
data["birth.y"]

# Option 2: getting the inner vector out of the data frame structure (just print
# the first few values).
data |> 
  pull(birth.y) |> 
  head()

# This is the same as 
data$birth.y |> 
  head()


## ------------------------------------------------------------------------------------------
# Create new variable from existing continuous variable.
data <- data |> 
  mutate(
    age = 2023 - birth.y
  )

# See result.
data |> 
  select(birth.y, age)

# Recode continuous variable into categorical (i.e., factor).

# Age -> Generation
# Gen Z: 1996-2010 -> Fascia età 13-27
# Millennials: 1980-1995 -> Fascia età 28-43
# Gen X: 1965-1979 -> Fascia età 44-58
# Baby boomers: 1946-1964 -> Fascia età 59-77 (ma includiamo respondents fino a 
# 80).
data <- data |> 
  mutate(
    gen1 = cut(age, c(13, 27, 43, 58, 80))
  )

# View. Note the new variable is listed as <fct>.
data |> 
  select(birth.y, age, gen1)

# Recode factor: new labels for generations
data <- data |> 
  mutate(
    gen = fct_recode(gen1, `gen z` = "(13,27]", `millennials` = "(27,43]", 
                     `gen x` = "(43,58]", `baby boomers` = "(58,80]")
  )

# View.
data |> 
  select(age, gen1, gen)

# Factors have levels (i.e., categories). These are stored in a specific order.
data |> 
  pull(gen) |> 
  levels()

# This order affects the output of certain functions, including those for 
# producing summary tables and visualizations. For example:
data |> 
  tabyl(gen)

# We can change the order of levels.
data <- data |> 
  mutate(
    gen = fct_relevel(gen, "baby boomers", "gen x", "millennials", "gen z")
  )

# See the result.
data |> 
  pull(gen) |> 
  levels()

# Now the summary table has rows in a different order.
data |> 
  tabyl(gen)

# Recode age in a different way: 10-year age brackets.
data <- data |> 
  mutate(
    age.br = cut(age, c(20, 30, 40, 50, 60, 70, 80))
  )

# View.
data |> 
  select(age, age.br)

# Levels of the new variable
data |> 
  pull(age.br) |> 
  levels()

# Recode, i.e., re-label age brackets.
data <- data |> 
  mutate(
    age.br.2 = fct_recode(age.br,
      `21-30` = "(20,30]",
      `31-40` = "(30,40]",
      `41-50` = "(40,50]",
      `51-60` = "(50,60]",
      `61-70` = "(60,70]",
      `71-80` = "(70,80]"
    )
  )

# View results.
data |> 
  select(age, age.br, age.br.2)

# Collapse 10-year brackets into 20-year.
data <- data |> 
  mutate(
    age.br.3 = fct_collapse(age.br.2,
      `21-40` = c("21-30", "31-40"),
      `41-60` = c("41-50", "51-60"),
      `61-80` = c("61-70", "71-80")
    )
  )

# View results.
data |> 
  select(age, age.br.2, age.br.3)

# Check consistency with cross-tabulations. 
data |> 
  tabyl(age.br.2)
data |> 
  tabyl(age.br.3)
# Is this what we should expect?
data |> 
  tabyl(age.br.2, age.br.3)

# Another example of recoding/collapsing. Check out the original education 
# categories (are they in the correct order?).
data |> 
  tabyl(edu)

# Recode education. Note other_level = ... argument.
data <- data |> 
  mutate(
    edu = fct_collapse(edu,
      `Medie o meno` = "Diploma di scuole medie o inferiore",
      Superiori = "Diploma di scuola superiore",
      Laurea = "Laurea",
      `Post-laurea` = c("Master post-laurea", "Dottorato"), 
      other_level = "Altro"
    )
  )

# Results:
data |> 
  tabyl(edu)

# We still need to arrange levels (categories) in the right order.
data <- data |> 
  mutate(
    edu = fct_relevel(edu, "Medie o meno", "Superiori", "Laurea", "Post-laurea", "Altro")
  )

# See the new order of levels.
data |> 
  tabyl(edu)

# Recode gender.

# See unique (distinct) values of gender
data |> 
  tabyl(gender)

# Recode and reorder levels in the same call
data <- data |> 
  mutate(
    gender = fct_recode(gender, 
                        NR = "Preferisco non rispondere",
                        `Altra identità` = "Altra identità di genere (transgender, non binario, ecc.)") |> 
      fct_relevel("Donna", "Uomo", "Altra identità")
  )

# View
data |> 
  tabyl(gender)

# Only keep variables of interest for the following analyses.
# What is this code doing with the age.br variable?
data <- data |> 
  select(birth.y, age, gen, age.br = age.br.2, gender, nato.it, edu, company, work.exp.y, driver.sum)


## ------------------------------------------------------------------------------------------
# Respondents whose age is exactly 40.
data |> 
  filter(age == 40)

# With education = Laurea
data |> 
  filter(edu == "Laurea")

# The %in% operator is useful when you need to select multiple values.
data |> 
  filter(edu %in% c("Superiori", "Laurea"))

# All education categories except "Medie o meno"
data |> 
  filter(edu != "Medie o meno")

# Missing value on nato.it
data |> 
  filter(is.na(nato.it))

# Multiple conditions can be combined: intersection (&, i.e. AND) or 
# union (|, i.e. OR). 

# Respondents between 30 and 40.
data |> 
  filter(age >= 30 & age <=40)

# Respondents who are either younger than 20 or older than 40.
data |> 
  filter(age < 20 | age > 40)

# Respondents who are younger than 40 AND whose education is post-laurea
data |> 
  filter(age < 40 & edu == "Post-laurea")

# The filtered data can be saved to new objects, for example:
data.40 <- data |> 
  filter(age <= 40)

# Different dplyr verbs can be combined in a pipe chain:
data |> 
  filter(age < 40) |> 
  select(age, gen, edu)

# Rearrange rows by increasing values on a variable.
data |> 
  arrange(birth.y)

# By decreasing value:
data |> 
  arrange(desc(birth.y))


## ------------------------------------------------------------------------------------------
save(data, file = "my_data.rda")


## ------------------------------------------------------------------------------------------
# Mean of one continuous variable
data |> 
  summarize(avg.age = mean(age))

# Number of unique or distinct values in edu.
data |> 
  summarize(n.edu = n_distinct(edu))

# Absolute frequency of women.
data |> 
  summarize(count.women = sum(gender == "Donna"))

# We can obtain a battery of multiple summary statistics.
data |> 
  summarize(
    min.year = min(birth.y),
    avg.age = mean(age),
    sd.age = sd(age),
    count.women = sum(gender == "Donna"),
    # What am I doing in this last line?
    prop.foreign = mean(nato.it == "No", na.rm = TRUE)
  )


## ------------------------------------------------------------------------------------------
# Battery of descriptive statistics on age.
data |> 
  skimr::skim_tee(age)

# Tabulation for gender
data |> 
  janitor::tabyl(gender)

# Note that count() gives us similar information.
data |> 
  count(gender)

# Cross-tabulation for education and gender
data |> 
  tabyl(edu, gender)


## ------------------------------------------------------------------------------------------
# Add column totals.
data |> 
  tabyl(gender) |> 
  adorn_totals(where = "row")

# Format percentage
data |> 
  tabyl(gender) |> 
  adorn_totals(where = "row") |> 
  adorn_pct_formatting()


## ------------------------------------------------------------------------------------------
data |> 
  skimr::skim(age) |> 
  as_tibble() |> 
  select(variable = skim_variable, mean = numeric.mean, sd = numeric.sd)


## ------------------------------------------------------------------------------------------
# Let's run summarize() as above, but now by gender. What are the results telling us?
data |> 
  group_by(gender) |> 
  summarize(
    min.year = min(birth.y),
    avg.age = mean(age),
    sd.age = sd(age),
    prop.foreign = mean(nato.it == "No", na.rm = TRUE)
  )

# Average age in each company
data |> 
  group_by(company) |> 
  summarize(avg.age = mean(age))

# Let's now only keep Donna and Uomo as gender, and re-run by groups given by 
# combinations of gender and education categories.
data |> 
  filter(gender %in% c("Donna", "Uomo")) |> 
  group_by(gender, edu) |> 
  summarize(
    min.year = min(birth.y),
    avg.age = mean(age),
    sd.age = sd(age),
    prop.foreign = mean(nato.it == "No", na.rm = TRUE)
  )

# skimr functions are also compatible with group_by().
data |> 
  group_by(gender) |> 
  skim_tee(age)


## ------------------------------------------------------------------------------------------
data |> 
  filter(gender %in% c("Donna", "Uomo")) |> 
  group_by(gender, edu) |> 
  summarize(
    min.year = min(birth.y),
    avg.age = mean(age),
    sd.age = sd(age),
    prop.foreign = mean(nato.it == "No", na.rm = TRUE)
  ) |> 
  write_csv("summarize_by_gender-edu.csv")

data |> 
  group_by(gender) |> 
  skim(age) |> 
  as_tibble() |> 
  write_csv("skim_by_gender.csv")

