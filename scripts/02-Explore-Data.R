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
# for the (updated) 2022_SerengetiSpecies Database:
# read the whole database into a list of dataframes
SerengetiSpeciesDB <- read_gsdb("https://docs.google.com/spreadsheets/d/1DLWG_h1bBWi7Gf5zJGn6wdQx1x2o69YiFx5lh7Uuqwc")
# the different sheets in the database are now tibbles in the list SerengetiSpeciesDB
# for example the tibble DimBirdSpecies, you can access as 
SerengetiSpeciesDB$DimBirdSpecies

##### Example usages 2):
# alternatively you can also read a specific sheet into your global environment
# that then becomes a dataframe
DimMammalSpecies <- read_gsdb("https://docs.google.com/spreadsheets/d/1DLWG_h1bBWi7Gf5zJGn6wdQx1x2o69YiFx5lh7Uuqwc", 
                          sheets = "DimMammalSpecies")
# now DimMammalSpecies is a dataframe in your global environment
# similarly as we would read it before from the published link with read_csv()
