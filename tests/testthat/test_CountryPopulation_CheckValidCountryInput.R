test_that("Check for a valid country input", {

  expect_error(CountryPopulation("Camelot"))
  expect_error(CountryPopulation("Asgarnia"))
})
