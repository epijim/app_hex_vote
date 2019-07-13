library(shiny)
library(DT)
library(tidyverse)

# load the metadata
  metadata <- read_csv("data/metadata.csv")

# database
  library(mongolite)

  options(mongodb = list(
    "host" = "jamessandbox-ed3jh.mongodb.net",
    "username" = "james_app",
    "password" = read_lines("data/.mongodb_pass")
  ))
  databaseName <- "shinybackend"
  collectionName <- "hextest"
  con_glue <- "mongodb+srv://%s:%s@%s/%s?retryWrites=true&w=majority"

  saveData <- function(data) {
    # Connect to the database
    db <- mongo(collection = collectionName,
                url = sprintf(
                  con_glue,
                  options()$mongodb$username,
                  options()$mongodb$password,
                  options()$mongodb$host,
                  databaseName))
    # Insert the data into the mongo collection as a data.frame
    data <- as.data.frame(data)
    db$insert(data)
  }

  loadData <- function() {
    # Connect to the database
    db <- mongo(collection = collectionName,
                url = sprintf(
                  con_glue,
                  options()$mongodb$username,
                  options()$mongodb$password,
                  options()$mongodb$host,
                  databaseName))
    # Read all the entries
    data <- db$find()
    data
  }
