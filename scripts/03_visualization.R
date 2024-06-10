## ----message=FALSE-------------------------------------------------------------------------
# Load packages
library(tidyverse)
library(janitor)

# Clear the workspace
rm(list = ls())

# Let's load the data we cleaned in the previous chapter
load("my_data.rda")


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_histogram(aes(x = age))


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_histogram(aes(x = age), binwidth = 1)


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_histogram(aes(x = age), binwidth = 1,
                 color = "white", fill = "black")


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_histogram(aes(x = age), binwidth = 1,
                 color = "white", fill = "black") +
  scale_x_continuous(breaks = seq(20, 80, by = 10))


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_histogram(aes(x = age), binwidth = 1,
                 color = "white", fill = "black") +
  scale_x_continuous(breaks = seq(20, 80, by = 10)) +
  theme_bw()


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_histogram(aes(x = age, y = after_stat(density)), binwidth = 1,
                 color = "white", fill = "black") +
  geom_density(aes(x = age), linewidth = 1, color = "red") +
  scale_x_continuous(breaks = seq(20, 80, by = 10)) +
  theme_bw()


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_boxplot(aes(x = age))


## ------------------------------------------------------------------------------------------
set.seed(194)
ggplot(data = data) +
  geom_point(aes(x = age, y = 0), 
             shape = 21,
             position = position_jitter(h = 0.2)) +
  geom_boxplot(aes(x = age), fill = NA, color = "red")


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_bar(aes(x = edu))


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_bar(aes(x = edu, fill = edu))


## ------------------------------------------------------------------------------------------
# Original level order
data$edu |> 
  levels()

# Let's change it to this:
data$edu |>
  fct_rev() |> 
  levels()
# Make the change in the data
data.rev <- data |> 
  mutate(edu = fct_rev(edu))

# Not plot with the new level order
ggplot(data = data.rev) +
  geom_bar(aes(x = edu, fill = edu))


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_bar(aes(x = edu, fill = edu)) +
  scale_fill_manual(values = c(`Medie o meno` = "#002e4e", 
                               Superiori = "#afe1da", 
                               Laurea = "#ff4639", 
                               `Post-laurea` = "#b4abd7", 
                               Altro = "#fad774")) +
  theme_minimal()


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_point(aes(x = age, y = work.exp.y))


## ------------------------------------------------------------------------------------------
data |> 
  group_by(age, work.exp.y) |> 
  count() |> 
  arrange(desc(n))


## ------------------------------------------------------------------------------------------
set.seed(106)
ggplot(data = data) +
  geom_point(aes(x = age, y = work.exp.y), shape = 21, position = position_jitter(w = 0.3))


## ------------------------------------------------------------------------------------------
set.seed(106)
ggplot(data = data, aes(x = age, y = work.exp.y)) +
  geom_point(shape = 21, position = position_jitter(w = 0.3)) +
  geom_smooth()


## ------------------------------------------------------------------------------------------
set.seed(106)
ggplot(data = data, aes(x = age, y = driver.sum)) +
  geom_point(shape = 21, color = "white", position = position_jitter(w = 0.3)) +
  geom_smooth(color = "red") +
  theme_dark()


## ------------------------------------------------------------------------------------------
data |> 
  tabyl(edu, gen) 


## ------------------------------------------------------------------------------------------
data |> 
  tabyl(edu, gen) |> 
  adorn_percentages(denominator = "col") |> 
  adorn_rounding(2)


## ------------------------------------------------------------------------------------------
data |> 
  tabyl(edu, gen) |> 
  adorn_percentages(denominator = "row") |> 
  adorn_rounding(2)


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_bar(aes(x = fct_rev(gen), fill = edu), position = "dodge")


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_bar(aes(x = edu, fill = fct_rev(gen)), position = "dodge")


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_bar(aes(x = fct_rev(gen), fill = edu))


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_bar(aes(x = fct_rev(gen), fill = edu), position = "fill")


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_boxplot(aes(x = driver.sum, y = gen))


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_histogram(aes(x = driver.sum, y = after_stat(density)), binwidth = 5, color = "white") +
  theme_bw()


## ------------------------------------------------------------------------------------------
ggplot(data = data) +
  geom_histogram(aes(x = driver.sum, y = after_stat(density)), binwidth = 5, color = "white") +
  facet_wrap(~ gen) +
  theme_bw()


## ------------------------------------------------------------------------------------------
# For simplicity, let's first subset the data to just Male and Female genders.
data.mf <- data |> 
  filter(gender %in% c("Donna", "Uomo"))

# Now plot
ggplot(data = data.mf) +
  geom_histogram(aes(x = driver.sum, y = after_stat(density)), binwidth = 5, color = "white") +
  facet_grid(gen ~ gender) +
  theme_bw()

