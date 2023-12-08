library(tidyverse)
library(ggplot2)

#' Graph the population estimates of a country.
#'
#' A graph of the UN population estimates for a country is returned when
#' entering a country name (must be a member of the United Nations) into the
#' function. If a country that does not exist or is not a UN member nation is
#' input, then an error is returned.
#'
#' @param \code{country} A UN member nation name (string)
#' @return A ggplot of \code{country} showing population estimates between 1950
#' and 2020
#' @examples
#' CountryPopulation("Egypt")
#' CountryPopulation("Indonesia)
#' CountryPopulation("Latvia")
#' @export
CountryPopulation <- function(country) {

  # check if the input is valid
  if(country %in% WorldPopulation$Country) {

    # identify the country and make the years accessible individually
    populationGraphData <- WorldPopulation %>%
      filter(str_detect(Country, pattern = country)) %>%
      pivot_longer(names_to = "Year", values_to = "Population", `1950`:`2020`)

    plot <- ggplot(populationGraphData, aes(x = Year, y = Population)) +
      geom_point() +
      scale_x_discrete(guide = guide_axis(angle = 90)) +
      labs(y = "Population Estimate (Thousands)") +
      labs(title = country)
  }
  else {

    stop("The input is not a valid country or a UN member nation")
  }
}
