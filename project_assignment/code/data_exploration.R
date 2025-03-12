
# Load packages -----------------------------------------------------------
library(dplyr)
library(tidyr)
library(readr)
library(skimr)


# Load data ---------------------------------------------------------------

raw_data_artists <- read_csv("data-raw/artists.csv")

# Explore dataset ---------------------------------------------------------

skim(raw_data_artists)

raw_data_artists |> 
  select(artist_name) |> 
  distinct()
