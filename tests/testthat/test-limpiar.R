context("limpieza")

testthat::test_that("listas son eliminadas de datos de contactos", {

  datos <- readRDS(contact_information)

  limpieza <- get_test_contact_information(datos)
  expect_true(class(limpieza) != "list")
  expect_true(ncol(limpieza) == 24)
  expect_true(nrow(limpieza) == 1)

})

