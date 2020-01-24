# lacrmr

<!-- badges: start -->
<!-- badges: end -->

<a href="url"><img src="img/lacrmR.png" align="right" width="30%"></a>

Get the information from your Less Annoying Customer Relationship Management API
in a tidy data way. Useful for getting metrics, visualize your goals and 
communicate with your data science team.

## Installation

You can install the released version of lacrmr from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("lacrmr")
```

## Example

## Use

This package provides you with 4 functions. These are and will return:

- **get_pipeline_report()** = It will provide you with a dataframe containing
the data correspondant to the pipeline that you need.
- **get_account_information** = This will give you the information of your 
account. 
- **get_contact_information** = Information related to the contact you are
searching for.
- **search_contact** = If you want to make sure a contact exists on your
CRM, this function will return an statement confirming the contact.

``` r
library(lacrmr)

## Obtain the report from a specific pipeline
sales <- get_pipeline_report(user_code = 12454, api_token = 25632, pipelineid = 458742fgg2544)
```

