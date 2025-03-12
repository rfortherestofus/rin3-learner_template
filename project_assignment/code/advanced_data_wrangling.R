# Load packages -----------------------------------------------------------
library(tidyverse)
library(fs)
library(readxl)
library(janitor)

# Import datasets ---------------------------------------------------------
# Download datasets from the Oregon Department of Education website
# https://www.oregon.gov/ode/educator-resources/assessment/Pages/Assessment-Group-Reports.aspx

download.file("https://www.oregon.gov/ode/educator-resources/assessment/Documents/TestResults2122/pagr_schools_math_tot_raceethnicity_2122.xlsx",
              mode = "wb",
              destfile = "data-raw/pagr_schools_math_tot_raceethnicity_2122.xlsx")

download.file("https://www.oregon.gov/ode/educator-resources/assessment/Documents/TestResults2122/TestResults2019/pagr_schools_math_tot_raceethnicity_1819.xlsx",
              mode = "wb",
              destfile = "data-raw/pagr_schools_math_tot_raceethnicity_1819.xlsx")

download.file("https://www.oregon.gov/ode/educator-resources/assessment/TestResults2018/pagr_schools_math_raceethnicity_1718.xlsx",
              mode = "wb",
              destfile = "data-raw/pagr_schools_math_raceethnicity_1718.xlsx")

download.file("https://www.oregon.gov/ode/educator-resources/assessment/TestResults2017/pagr_schools_math_raceethnicity_1617.xlsx",
              mode = "wb",
              destfile = "data-raw/pagr_schools_math_raceethnicity_1617.xlsx")

download.file("https://www.oregon.gov/ode/educator-resources/assessment/TestResults2016/pagr_schools_math_raceethnicity_1516.xlsx",
              mode = "wb",
              destfile = "data-raw/pagr_schools_math_raceethnicity_1516.xlsx")

# Read in data and assign it to an object
math_scores_2021_2022 <-
  read_excel(path = "data-raw/pagr_schools_math_tot_raceethnicity_2122.xlsx") |> 
  clean_names()


# Advanced data wrangling -------------------------------------------------

# Check for tidy principles (each columns is a variable, each cell is a single value, every row is an observation)
# Lessons 3, 4 and 5 of week 7

third_grade_math_proficiency_2021_2022 <-
  math_scores_2021_2022 |> 
  filter(student_group == "Total Population (All Students)") |> 
  filter(grade_level == "Grade 3") |> 
  select(academic_year, school_id, contains("number_level")) |> 
  pivot_longer(cols = starts_with("number_level"),
               names_to = "proficiency_level",
               values_to = "number_of_students")

third_grade_math_proficiency_2021_2022 <- 
third_grade_math_proficiency_2021_2022 |> 
  mutate(proficiency_level = case_when(
    proficiency_level == "number_level_4" ~ "4",
    proficiency_level == "number_level_3" ~ "3",
    proficiency_level == "number_level_2" ~ "2",
    proficiency_level == "number_level_1" ~ "1"
  )) |> 
  mutate(proficiency_level = parse_number(proficiency_level))


# Identify repetitive tasks and create a function
# Lesson 1 of week 8

# Export clean data into the data folder
# Lesson 3 of week 8
