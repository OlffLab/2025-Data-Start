# --------------------------HEADER --------------------------
# title: 02-Explore-Data.R
# project: 
# author: 
# date: 
# description: 
# input databases: 

#--------------------------01 Set up the environment -----------
# use source to run the setup script
source("scripts/01-Setup.R")
# authenticate googlesheets4 package for reading from google drive
gsheets_auth() # 
# to always automatically authenticate your project for a particular account, 
# add a file .Renviron to the
# root of your R project with the following line: 
# GS_EMAIL=your.name@rug.nl  

#--------------------------02 to data from a Google Sheets Database (all sheets)-----------
# this uses the function read_gsdb() defined in 01-Setup.R
# this function uses the googlesheets4 package to read data from a Google Sheets database

# the database is identified by its URL or its key 
# you can find the key in the URL of your Google Sheets database
# e.g. for the URL https://docs.google.com/spreadsheets/d/1aBcD_efGhIJKlmnopQRstuVWXYZ1234567890/edit#gid
# the key is 1aBcD_efGhIJKlmnopQRstuVWXYZ1234567890
# if you want to read only some sheets, provide a character vector of sheet names
# e.g. sheets <- c("Sheet1", "Sheet2")
# if you want to load  sheet as a separate dataframe in your global environment,
# instead of as a list of dataframes,
# set separate = TRUE
# e.g. read_gsdb(database, separate = TRUE)


#---------------------------03 Example usages----------------------------------------
###### Example usages 1: read all sheets
# for the (updated) 2022_SerengetiSpecies Database with this url
browseURL("https://docs.google.com/spreadsheets/d/1DLWG_h1bBWi7Gf5zJGn6wdQx1x2o69YiFx5lh7Uuqwc")
# the key is 1DLWG_h1bBWi7Gf5zJGn6wdQx1x2o69YiFx5lh7Uuqwc
# you can use either the full URL or just the key to read the database
# here we use the key
SerengetiSpeciesDB <- read_gsdb("1DLWG_h1bBWi7Gf5zJGn6wdQx1x2o69YiFx5lh7Uuqwc")
# the different sheets in the database are now tibbles in the list SerengetiSpeciesDB
# for example the tibble DimBirdSpecies, you can access as 
SerengetiSpeciesDB$DimBirdSpecies
# while the plant species list is 
SerengetiSpeciesDB$DimPlantSpecies
# this way you keep the different tables that come from the same database together. 
# the list is a full duplicate of your online database but in R 

##### Example usages 2):
# alternatively you can also read one or more specific sheets from the databadse into your global environment
# if you  need only a subset of tables from that database
read_gsdb("https://docs.google.com/spreadsheets/d/1DLWG_h1bBWi7Gf5zJGn6wdQx1x2o69YiFx5lh7Uuqwc", 
                          sheets = c("DimMammalSpecies","DimBirdSpecies"), separate=TRUE)
# the two tables are now available as tibbles DimMammalSpecies and DimBirdSpecies in your global environment
# similarly to as when we read them with read_csv("published_link_to_csv")
DimMammalSpecies
DimBirdSpecies

#--------------------------- how to read a large csv file directly from its link------------------------
# for example when the file is so big that it does not fit in a googlesheets file
# get the file ide from the shared link to the file in google drive 
# in google drive rightclick, share, copy link
# if the link is eg 
# https://drive.google.com/file/d/18TRynGulu8xVjnPhNbKidqwmqfCHCt0L/view?usp=drive_link
# then the file id is 
file_id <- "18TRynGulu8xVjnPhNbKidqwmqfCHCt0L"
# load reuired package
library(googledrive)
# download to a temp location
tmp <- tempfile(fileext = ".csv")
googledrive::drive_download(googledrive::as_id(file_id), path = tmp, overwrite = TRUE)
fishdata <- read_csv(tmp)
