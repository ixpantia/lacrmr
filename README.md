
<!-- README.md is generated from README.Rmd. Please edit that file -->

# lacrmr <a href="url"><img src="img/lacrmR.png" align="right" width="30%"></a>

<!-- badges: start -->

<!-- badges: end -->

Get the information from your Less Annoying Customer Relationship
Management API in a tidy data way. Useful for getting metrics, visualize
your goals and communicate with your data science team.

## Installation

Rigth now we have just the development version. You can install lacrmr
from github:

``` r
#install.packages("devtools")
devtools::install_github("ixpantia/lacrmr")
```

## Example

## Use

This package provides you with 4 functions. These are and will return:

  - **get\_pipeline\_report()** = It will provide you with a dataframe
    containing the data correspondant to the pipeline that you need.
  - **get\_account\_information** = This will give you the information
    of your account.
  - **get\_contact\_information** = Information related to the contact
    you are searching for.
  - **search\_contact** = If you want to make sure a contact exists on
    your CRM, this function will return an statement confirming the
    contact.

<!-- end list -->

``` r
library(lacrmr)

## Obtain the report from a specific pipeline
sales <- get_pipeline_report(user_code = "12454", 
                             api_token = "25632",
                             pipelineid = "458742fgg2544")
```
