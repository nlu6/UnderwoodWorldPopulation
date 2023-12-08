library(rvest)
library(tidyverse)

url <- "https://en.wikipedia.org/wiki/FIFA_World_Cup#Attendance"
page <- read_html(url)

# Scrape the data from Wikipedia
WorldCupAttendance <- page %>%
  html_nodes("table") %>%
  .[[4]] %>%
  html_table(header=FALSE, fill=TRUE) %>%
  slice(-1 * 1:2 )

World_Cup <- WorldCupAttendance %>%

  # Get the columns that we want
  select(c(X1, X2, X4:X6)) %>%
  magrittr::set_colnames(c("Year", "Hosts","Totalattendance", "Matches",
                           "Averageattendance")) %>%

  # Remove unwanted rows (World Cups that haven't happened and the overall)
  slice(-1 * 23:26 ) %>%

  # Clean the data to be the way we want (as doubles)
  mutate(across(1:5, str_remove_all, ',')) %>%
  mutate(across(3:5, as.numeric)) %>%

  # Merge the host countries name and the host year
  mutate(WorldCup = paste(Hosts, Year, sep = ''), .before = 1) %>%

  # Remove the original host and year columns
  select(-c(Hosts, Year))

# Save the data frame to the data/ directory as World_Cup.rda
usethis::use_data(World_Cup, overwrite = TRUE)
