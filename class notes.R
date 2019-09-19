getwd()
setwd("./Desktop/coursera jhu/Getting and Cleaning Data")

## set working directory up a level: setwd("../")

## checking for and creating directories
# file.exsits("directoryName") will check to see if the directory exists
# dir.create("directoryName") will create a directory if it doesn't exist

if (!file.exists("data")) {
        dir.create("data")
}

## 1. getting data from the internet: download.file()

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
list.files("./data")

dateDownloaded <- date()
dateDownloaded


## 2. Reading local files
cameraData <- read.table("./data/cameras.csv", sep = ",", header = TRUE) # most common
head(cameraData)
read.csv() # sets sep = "," and header = TRUE
read.csv2()

## In the instructer's experience, the biggest trouble with reading flat files 
## are quotation marks ' or " placed in data values, setting quote = "" often
## resolves these.


## 3. Reading Excel files
library(readxl)
# or 
# install.packages("openxlsx")
# library(openxlsx)
if (!file.exists("data")) {
        dir.create("data")
}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD&bom=true&format=true"
download.file(fileUrl, destfile = "./data/cameras.cxlsx", method = "curl")
list.files("./data")
dateDownloaded <- date()

## 4. Reading XML
# Extensible markup language
# Frequently used to store structured data
# Particularly widely used in internet applications
# Extracting XML is the basis for most web scraping
# Components: 1. markup - labels that give the text structure;
#             2. Content- the actual text of the document.

library(XML)
fileUrl <- "simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal =TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

rootNode[[1]]
rootNode[[1]][[1]]

xmlSApply(rootNode, xmlValue)

# XPath
xpathSApply(rootNode, "//name", xmlValue)
# [1] "Belgian Waffles"             "Strawberry Belgian Waffles"  "Berry-Berry Belgian Waffles" "French Toast"               
# [5] "Homestyle Breakfast" 

xpathSApply(rootNode, "//price", xmlValue)
# [1] "$5.95" "$7.95" "$8.95" "$4.50" "$6.95"


# Extract content by attributes
fileUrl <- "view-source_https___www.espn.com_nfl_team___name_bal_baltimore-ravens.html"
doc <- htmlTreeParse(fileUrl, useInternal = TRUE)
scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)
scores
teams


## 5. Reading JSON

library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login

# Writing data frames to JSON
myjson <- toJSON(iris, pretty = TRUE)
cat(myjson)
# Convert back to JSON
iris2 <- fromJSON(myjson)
head(iris2)


## 6. The data.table package
# faster and more memory efficient
