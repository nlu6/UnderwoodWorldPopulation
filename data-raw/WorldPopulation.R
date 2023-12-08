library(readxl)
library(tidyverse)

UNPopulationEstimates <- read_excel("data-raw/World_Population.xlsx",
                                    range = "A17:BZ306", sheet = "ESTIMATES")

# Read in the data.  Do some cleaning/verification
WorldPopulation <- UNPopulationEstimates %>%

  # Isolate countries from regions and sub-regions
  filter(Type == "Country/Area") %>%

  # Gather useful columns
  select(3, 8:78) %>%
  rename("Country" = `Region, subregion, country or area *`) %>%

  # Clean the data to be the way we want (as doubles)
  mutate(across(2:72, as.numeric))

# Save the data frame to the data/ directory as WorldPopulation.rda
usethis::use_data(WorldPopulation, overwrite = TRUE)
