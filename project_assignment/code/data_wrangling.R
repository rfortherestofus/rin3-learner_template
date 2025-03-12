
# Load Packages -----------------------------------------------------------
library(tidyverse)

# Import data -------------------------------------------------------------
raw_data_artists <- read_csv("data-raw/artists.csv")

# Questions about the data ------------------------------------------------

# How many women artists have Hispanic or Latino origin?
raw_data_artists |> 
  filter(artist_gender == "Female" & 
           artist_ethnicity == "Hispanic or Latino origin") |> 
  distinct(artist_name) |> 
  count()

# What are the top 5 nationalities of the non-white artists in the dataset?
raw_data_artists |> 
  filter(artist_ethnicity != "White") |>
  group_by(artist_nationality) |>
  summarise(n = n()) |> 
  arrange(desc(n)) |> 
  print(n = 5)

# Have the number of black female artists cited in the book increased over the years?

raw_data_artists |> 
  filter(artist_gender == "Female" & 
           artist_race == "Black or African American") |> 
  mutate(year = as.factor(year)) |> 
  group_by(year) |>
  summarise(n = n()) |> 
  arrange(desc(year))

