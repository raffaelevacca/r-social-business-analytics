## ----message=FALSE------------------------------------------------------------
# Load packages
library(tidyverse)

# Clear the workspace
rm(list = ls())

# Let's load the data we cleaned in the previous chapter
load("my_data.rda")


## -----------------------------------------------------------------------------
ggplot(data = data) +
  geom_histogram(aes(x = age))


## -----------------------------------------------------------------------------
ggplot(data = data) +
  geom_histogram(aes(x = age), binwidth = 1)


## -----------------------------------------------------------------------------
ggplot(data = data) +
  geom_histogram(aes(x = age), binwidth = 1,
                 color = "white", fill = "black")


## -----------------------------------------------------------------------------
ggplot(data = data) +
  geom_histogram(aes(x = age), binwidth = 1,
                 color = "white", fill = "black") +
  scale_x_continuous(breaks = seq(20, 80, by = 10))


## -----------------------------------------------------------------------------
ggplot(data = data) +
  geom_histogram(aes(x = age), binwidth = 1,
                 color = "white", fill = "black") +
  scale_x_continuous(breaks = seq(20, 80, by = 10)) +
  theme_bw()


## -----------------------------------------------------------------------------
ggplot(data = data) +
  geom_histogram(aes(x = age, y = after_stat(density)), binwidth = 1,
                 color = "white", fill = "black") +
  geom_density(aes(x = age), linewidth = 1, color = "red") +
  scale_x_continuous(breaks = seq(20, 80, by = 10)) +
  theme_bw()


## -----------------------------------------------------------------------------
ggplot(data = data) +
  geom_boxplot(aes(x = age))


## -----------------------------------------------------------------------------
set.seed(194)
ggplot(data = data) +
  geom_point(aes(x = age, y = 0), 
             shape = 21,
             position = position_jitter(h = 0.2)) +
  geom_boxplot(aes(x = age), fill = NA, color = "red")


## -----------------------------------------------------------------------------
ggplot(data = data) +
  geom_bar(aes(x = edu))


## -----------------------------------------------------------------------------
ggplot(data = data) +
  geom_bar(aes(x = edu, fill = edu))


## -----------------------------------------------------------------------------
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


## -----------------------------------------------------------------------------
ggplot(data = data) +
  geom_bar(aes(x = edu, fill = edu)) +
  scale_fill_manual(values = c(`Medie o meno` = "#002e4e", 
                               Superiori = "#afe1da", 
                               Laurea = "#ff4639", 
                               `Post-laurea` = "#b4abd7", 
                               Altro = "#fad774")) +
  theme_minimal()

