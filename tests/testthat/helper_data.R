# Test data for mocks in testing functions

contact_information <- system.file("testdata/prueba_get_contact_information.json",
                                   package = "lacrmr")

contact_information <- jsonlite::fromJSON(contact_information)


pipeline_data <- system.file("testdata/pipeline_test_data.json",
                             package = "lacrmr")
pipeline_data <- jsonlite::fromJSON(pipeline_data)


request_test <- system.file("testdata/request_test.RDS", package = "lacrmr")
request_test <- readRDS(request_test)
