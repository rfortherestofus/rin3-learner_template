
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

female_artists_black <-
raw_data_artists |> 
  filter(artist_gender == "Female" & 
           artist_race == "Black or African American") |> 
  mutate(year = as.factor(year)) |> 
  group_by(year) |>
  summarise(n = n()) |> 
  arrange(desc(year))


# Data visualization ------------------------------------------------------

# What is the distribution of ethnicities of female artists cited on the book 
# throughout the years?

# Create new dataset

female_artists_ethnicity <- 
  raw_data_artists |> 
  filter(artist_gender == "Female") |>
  group_by(artist_ethnicity, year) |>
  summarise(n = n()) 

# Plot the distribution of ethnicities

ggplot(female_artists_ethnicity,        # Data
       aes(x = as.factor(year),         # X-axis
           y = n,                       # Y-axis
           group = artist_ethnicity,    # Grouping
           color = artist_ethnicity)) + # Color
  geom_line() +                         # Make it a line plot
  theme_minimal() +                     # Theme
  labs(title = "Distribution of ethnicities of female artists cited on the book 'Art Through the Ages' throughout the years",            # Title
       y = NULL,                        # Y-axis label
       x = NULL,                        # X-axis label
       color = "Artists' ethnicity")    # Legend title
