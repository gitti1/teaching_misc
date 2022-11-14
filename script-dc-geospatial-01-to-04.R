# Intro to R for Geospatial Data #

#### 1 Intro to RStudio ####

# How RStudio is organised
# panels: editor, console, environment/history/etc., files/plots/packages/help/etc.

# Workflow within RStudio

# Create R file or open shared script 
# To run code:
# #1 run segments via Run button
# #2 select "Run lines" from "Code" menu
# #3 hit Ctrl+Enter in Windows, Ctrl+Return in Linux, or  ⌘+Return on OS X.

# Intro to R
# most of your time will be spend on the interactive console
# Ctrl+1 move cursor from console to editor, Ctrl+2 from editor to console

# Using R as a calculator
1 + 100
1 + 

# cancel commands
# use Ctrl+c instead of Esc 

#   Parentheses: (, )
#   Exponents: ^ or **
#   Divide: /
#   Multiply: *
#   Add: +
#   Subtract: -

3 + 5 * 2^2   
2e-4  # shorthand for 2 * 10^(-4)
2e3

# Things to use
# - autocompletion
# - ? for looking up a help page 
?sum

# Comparing things
1 == 1 # equality
1 != 2 # inequality
1 < 2 # less than
1 <= 1 # less than or equal to
# Comparing numbers - do not use == to compare two numbers unless they are integers
# use all.equal instead (a decimal approximation is stored)
all.equal(1/4, 0.25)

# Variables and assignment 
# via assignment operator "<-" ("=" also works but not recommended)
x <- 1/40
x
log(x)
x <- 100 
x <- x + 1

# Challenge 1 
# What will be the value of each variable after each statement in the following program?
mass <- 47.5
age <- 122
mass <- mass * 2.3
age <- age - 20

# Challenge 2
# Run the code from the previous challenge, and write a command to compare 
# mass to age. Is mass larger than age?


# Variable names
# Variable names can contain letters, numbers, underscores and periods. 
# They cannot start with a number nor contain spaces at all. 
# Conventions for long variable names, e.g.:
# - periods.between.words
# - underscores_between_words
# - camelCaseToSeparateWords
# Whatever you use, be consistent!

# Challenge 3
# Which of the following are valid R variable names?
min_height
max.height
_age
.mass
MaxLength
min-length
2widths
celsius2kelvin

# Installing packages
# #1 Via menu Tools > Install Packages 
# #2 via install.packages() function
install.packages("dplyr")
# or install the whole tidyverse
install.packages("tidyverse") # includes dplyr, ggplot2

# Challenge 4
# What code would we use to install the ggplot2 package?


# Loading an R package
library(dplyr)
# or library(tidyverse)

# Challenge 5
# Which of the following could we use to load the ggplot2 package? 
# (Select all that apply.)
# a) install.packages(“ggplot2”) 
# b) library(“ggplot2”) 
# c) library(ggplot2) 
# d) library(ggplo2)

################################################################################

#### 2 Project Management with RStudio ####

# Challenge: Creating a self-contained project

# We’re going to create a new project in RStudio:
#   
# Click the “File” menu button, then “New Project”.
# Click “New Directory”.
# Click “New Project”.
# Type in “r-geospatial” as the name of the directory.
# Click the “Create Project” button.

# session info
sessionInfo()
# working directory
getwd()

# create a new directory
# via Files tab or via the function dir.create()
dir.create("data")

# Good practices
# - Treat data as read only 
# - Store scripts in separate folder
# - Store processed data in a separate folder than the original data
# - Treat generated output as disposable
# - Keep related data together
# - Keep a consistent naming scheme

# Tips
# 1. Put each project in its own directory, which is named after the project.
# 2. Put text documents associated with the project in the doc directory.
# 3. Put raw data and metadata in the data directory, and files 
# generated during cleanup and analysis in a results directory.
# 4. Put source for the project’s scripts and programs in the src directory, 
# and programs brought in from elsewhere or compiled locally in the bin directory.
# 5. Name all files to reflect their content or function.

# Create data folder and download data
# https://datacarpentry.org/r-intro-geospatial/02-project-intro/index.html



# Challenge 1
# 
# 1. Download each of the data files listed below 
# (Ctrl+S, right mouse click -> “Save as”, or File -> “Save page as”)
# nordic country data
# nordic country data (version 2)
# gapminder data
# 
# 2. Make sure the files have the following names:
# nordic-data.csv
# nordic-data-2.csv
# gapminder_data.csv
# 
# 3. Save the files in the data/ folder within your project.
# 
# We will load and inspect these data later.


# Challenge 2
# 
# We also want to move the data that we downloaded from the data page into a 
# subdirectory inside r-geospatial. If you haven’t already downloaded the data, 
# you can do so by clicking this download link.
# 
# Move the downloaded zip file to the data directory.
# Once the data have been moved, unzip all files

################################################################################

#### 3 Data Structures ####
# intro to data structures: data frame, vector, factor, list
# and basic data types: numeric, character, etc.

# Reading data into R
# in base R via read.csv for comma separated data
# read.csv2, read.delim for ; or tab as separator 
# in the tidyverse: read_csv
nordic <- read.csv("data/nordic-data.csv")
nordic_tbl <- read_csv("data/nordic-data.csv")
# compare the two - the first is a dataframe, the second a tibble, 
# a modern type of dataframe, https://tibble.tidyverse.org/

# str displays the structure of an R object
str(nordic)

# explore the dataframe
nordic$country
nordic$lifeExp

nordic$lifeExp + 2
nordic$lifeExp + nordic$country # what happens?

# Data types
# numeric, integer, complex, logical, character
class(nordic$lifeExp)

class(3.14)
class(1L) 
class(1 + 1i)
class(TRUE)
class("banana")
class(factor("banana"))

nordic_2 <- read.csv("data/nordic-data-2.csv")
class(nordic_2$lifeExp) # what happened to lifeExp? not numbers but characters!

class(nordic)


# Vectors and Type Coercion
# The function vector creates a simple vector of a given length
# and (storage) mode. 
my_vector <- vector(length = 3)
my_vector
another_vector <- vector(mode = "character", length = 3)
another_vector

# str displays the structure of an R object 
str(another_vector)
str(nordic$lifeExp)

# Discussion 1
# Why is R so opinionated about what we put in our columns of data? 
# How does this help us?

# create vectors with the combine function c()
combine_vector <- c(2, 6, 3)
# examples for coercion 
quiz_vector <- c(2, 6, '3')
coercion_vector <- c('a', TRUE)

# The coercion rules go: 
# logical -> integer -> numeric -> complex -> character

character_vector_example <- c('0', '2', '4')
character_coerced_to_numeric <- as.numeric(character_vector_example)
numeric_coerced_to_logical <- as.logical(character_coerced_to_numeric)


# Challenge 1
# 
# Given what you now know about type conversion, look at the class 
# of data in nordic_2$lifeExp and compare it with nordic$lifeExp. 
# Why are these columns different classes?

# append vectors
vector <- c("a", "b")
vector_combined <- c(vector, "dc")
my_series <- 1:10 
# or use seq()
sequence_example <- seq(10)
seq(1, 10, by = 0.1)
# head, tail, length
head(sequence_example)

# Adding names to elements in a vector
my_example <- 5:8
names(my_example) <- c("a", "b", "c", "d")


# Challenge 2
# 
# Start by making a vector with the numbers 1 through 26. 
# Multiply the vector by 2, and give the resulting vector names 
# A through Z (hint: there is a built in vector called LETTERS)


# Factors
nordic_countries <- c('Norway', 'Finland', 'Denmark', 'Iceland', 'Sweden')
nordic_countries
str(nordic_countries)
categories <- factor(nordic_countries)
str(categories)

# Challenge
# Can you guess why these numbers are used to represent these countries?


# Challenge 3
# Is there a factor in our nordic data frame? what is its name? 
# Try using ?read.csv to figure out how to keep text columns as 
# character vectors instead of factors; then write a command or 
# two to show that the factor in nordic is actually a character 
# vector when loaded in this way.


# specify via read function if a column should be read as a particular type
read.csv(file, stringsAsFactors = TRUE) 

# read_csv(file) # by default not read as factors
# nordic_factor <- read_csv("data/nordic-data.csv", col_types = "fdd") # f = factor, d = double 

# Specifying the order of factor levels 
mydata <- c("case", "control", "control", "case")
factor_ordering_example <- factor(mydata, levels = c("control", "case"))
str(factor_ordering_example)


# Lists 
# accepts mixed data types as input 
list_example <- list(1, "a", TRUE, c(2, 6, 7))
list_example

another_list <- list(title = "Numbers", numbers = 1:10, data = TRUE )
another_list

# compare
str(nordic)
str(another_list)

# Note that each column of a data frame is a vector
nordic[, 1] # first column
# Note that each row is an observation of different variables and itself
# a data frame.
nordic[1, ] # first row/observation
class(nordic[1, ])


# Challenge 4
# There are several subtly different ways to call variables, observations 
# and elements from data frames:
  
nordic[1]
nordic[[1]]
nordic$country
nordic["country"]
nordic[1, 1]
nordic[, 1]
nordic[1, ]

# Try out these examples and explain what is returned by each one.
# Hint: Use the function class() to examine what is returned in each case.



################################################################################

#### 4 Exploring data frames ####

# if you have not downloaded the data yet 
download.file("https://raw.githubusercontent.com/datacarpentry/r-intro-geospatial/master/_episodes_rmd/data/gapminder_data.csv",
              destfile = "data/gapminder_data.csv")

# Import gapminder data
gapminder <- read.csv("data/gapminder_data.csv")

# or directly import from the web
gapminder <- read.csv("https://raw.githubusercontent.com/datacarpentry/r-intro-geospatial/master/_episodes_rmd/data/gapminder_data.csv")

# explore the data frame
str(gapminder)
length(gapminder)
# dim, nrow, ncol, names (or colnames)
names(gapminder)
# first few values
head(gapminder)


# Challenge 1
# It’s good practice to also check the last few lines of your data and 
# some in the middle. How would you do this?
# Searching for ones specifically in the middle isn’t too hard but we 
# simply ask for a few lines at random. How would you code this?



# Challenge 2
# Read the output of str(gapminder) again; this time, use what you’ve learned 
# about factors and vectors, as well as the output of functions like colnames 
# and dim to explain what everything that str prints out for gapminder means. 
# If there are any parts you can’t interpret, discuss with your neighbors or
# use the chat!



# Adding columns and rows in data frames
# cbind, rbind 

# Add new column if life expectancy is below world average (70.5 years)
below_average <- gapminder$lifeExp < 70.5 
cbind(gapminder, below_average) 
head(cbind(gapminder, below_average))
# what happens if the new column has less entries than  
# observations in the data frame?
below_average <- c(TRUE, TRUE, TRUE, TRUE, TRUE)
head(cbind(gapminder, below_average)) # note the error

# but works if the number of rows is a multiple of the new values 
below_average <- c(TRUE, TRUE, FALSE)
head(cbind(gapminder, below_average))

# overwrite gapbinder by the new data frame
below_average <-  as.logical(gapminder$lifeExp<70.5)
gapminder <- cbind(gapminder, below_average)

# add new row
new_row <- list('Norway', 2016, 5000000, 'Nordic', 80.3, 49400.0, FALSE)
gapminder_norway <- rbind(gapminder, new_row)
tail(gapminder_norway)


# Factors
# read the data 
gapminder_factor <- read.csv("data/gapminder_data.csv", stringsAsFactors = TRUE)
str(gapminder_factor)

levels(gapminder$continent)
levels(gapminder_factor$continent)

levels(gapminder$continent) <- c(levels(gapminder$continent), "Nordic")
gapminder_norway  <- rbind(gapminder,
                           list('Norway', 2016, 5000000, 'Nordic', 80.3,49400.0, FALSE))

str(gapminder)

# transforming the variable back to a character vector
gapminder$continent <- as.character(gapminder$continent)
str(gapminder)

# Appending to a data frame
# glue data frames via rbind

gapminder <- rbind(gapminder, gapminder)
tail(gapminder, 3) # note the row names
rownames(gapminder) <- NULL
head(gapminder)


# Challenge 3
# You can create a new data frame right from within R with the following syntax:
df <- data.frame(id = c("a", "b", "c"),
                   x = 1:3,
                   y = c(TRUE, TRUE, FALSE),
                   stringsAsFactors = FALSE)

# Make a data frame that holds the following information for yourself:
# - first name
# - last name
# - lucky number

# Then use rbind to add an entry for the people sitting beside you. 
# Finally, use cbind to add a column with each person’s answer to the question, 
# “Is it time for coffee break?”




