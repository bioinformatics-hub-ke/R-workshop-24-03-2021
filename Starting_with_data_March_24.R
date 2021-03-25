# ===== March 24th 2021 =============================================
# ===== Starting with data ==========================================
# ===================================================================


# ===== first , set your working directory to the working directory we created previously

getwd()


setwd("C:/Users/BWaweru/OneDrive - CGIAR/Documents/BecA-ILRI/tutorilas_and_pipeline/Data_Capentry_Files_23_24_March_2021/data-carpentry/")

# ===== download the data we will use the workshop
# ===== specify the url correctly and the give the name your file will be called after download

download.file(url = "https://github.com/bioinformatics-hub-ke/R-workshop-24-03-2021/raw/main/portal_data_joined.csv", destfile = "./data_raw/portal_data_joined.csv")

# ===== Reading data into R 

# ===== we use the package we downloaded, hence we have to load them into our R session

library(tidyverse) # OR dplyr if that is what you have

# ===== we use the function read_csv(), to read the data and save it in an object called surveys

surveys <- read_csv("./data_raw/portal_data_joined.csv")

# look at the content of the loaded data, the first few lines

head(surveys)

# specify the first 50 rows

head(surveys, n=50) 

print(surveys, n = 50)

# subset just the first 100 rows for testing computations

surveys_sample <- head(surveys, 100)

# ===================================================================
# ===== Dataframes ==================================================
# ===================================================================

# data structure for most tabular data,
# columns are vectors with same length
# each column must contain the same type of data

# look at the structure of a dataset with str


str(surveys)

# further inspect your data set with more functions

# Size
dim(surveys)

nrow(surveys)
ncol(surveys)

# Content
head(surveys)
tail(surveys)

# Names
names(surveys)
colnames(surveys)
rownames(surveys)

# Summary
str(surveys)
summary(surveys)

# ===== Challenge

#Based on the output of str(surveys), can you answer the following questions?
  
  #What is the class of the object surveys?
  #How many rows and how many columns are in this object?


# ===== Indexing and Subsetting data frames =========================
# ===================================================================

# first element in the first column of the data frame (as a vector)
surveys[1, 1]   
# first element in the 6th column (as a vector)
surveys[1, 6]   
# first column of the data frame (as a vector)
surveys[, 1]    
# first column of the data frame (as a data.frame)
surveys[1]      
# first three rows of the 6th column (as a vector)
surveys[1:3, 6] 
# the 3rd row of the data frame (as a data.frame)
surveys[3, ]    
# equivalent to head_surveys <- head(surveys)
head_surveys <- surveys[1:6, ] 

# you can also subset by excluding indices

surveys[, -1]         # The whole data frame, except the first column
surveys[-(7:34786), ] # Equivalent to head(surveys)

# or by calling their column names

surveys["species_id"]       # Result is a data.frame
surveys[, "species_id"]     # Result is a vector
surveys[["species_id"]]     # Result is a vector
surveys$species_id          # Result is a vector

# ===== Challenge
#Create a data.frame (surveys_200) containing only the data in row 200 of the surveys dataset.

#Notice how nrow() gave you the number of rows in a data.frame?
  
 # Use that number to pull out just that last row in the data frame.
#Compare that with what you see as the last row using tail() to make sure it's meeting expectations.
#Pull out that last row using nrow() instead of the row number.
#Create a new data frame (surveys_last) from that last row.
#Use nrow() to extract the row that is in the middle of the data frame. Store the content of this row in an object named surveys_middle.

#Combine nrow() with the - notation above to reproduce the behavior of head(surveys), keeping just the first through 6th rows of the surveys dataset.

# ===== Factors =====================================================

# we can convert a column to a factor using:

surveys$sex <- factor(surveys$sex)

# check that it worked

summary(surveys$sex)

# By default, R always sorts levels in alphabetical order

levels(surveys$sex) #F comes before M

# check the number of levels

nlevels(surveys$sex)

# ===== Challenge
#Change the columns taxa and genus in the surveys data frame into a factor.

#Using the functions you learned before, can you find out...

#How many rabbits were observed?
#How many different genera are in the genus column?

# ===== converting factors ==========================================

# a vector of levels 

sex <- factor(c("male", "female", "female", "male"))
sex # current order

# reorder the levels

sex <- factor(sex, levels = c("male", "female"))
sex

# If you need to convert a factor to a character vector, you use as.character(x)

as.character(sex)


# ===== Renaming factors ============================================
# when data is stored as a factor we can plot to get a quick glance at the number of observations

plot(surveys$sex)

# but we have 1700 NA's, sex hasnt been recorded
# to show them in the plot we can turn the missing values into a factor

# first subset the sex data

sex <- surveys$sex
levels(sex)
# add NA as level

sex <- addNA(sex)
levels(sex)

# by using indices , we can remanem the 3rd object of the leves i.e NA to more useful/informative names

levels(sex)[3] <- "undetermined"

levels(sex)

# now plotting the data again

plot(sex)


# formatting dates ==================================================
library(lubridate)

my_date <- ymd("2015-01-01")
str(my_date)

# sep indicates the character to use to separate each component
my_date <- ymd(paste("2015", "1", "1", sep = "-")) 
str(my_date)

paste(surveys$year, surveys$month, surveys$day, sep = "-")


ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))


surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))

summary(surveys$date)
