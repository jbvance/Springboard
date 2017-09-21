library(dplyr)
titanic = tbl_df(titanic3)

#fill in empty 'embarked' values with 'S'
empty_embarked <- is.na(titanic$embarked) | titanic$embarked==''
titanic[empty_embarked,]$embarked <- 'S'

#fill in empty 'age' values wtih mean of all ages in data frame
empty_age <- is.na(titanic$age) | titanic$age==''
mean_age <- mean(titanic$age,na.rm = TRUE)
titanic[empty_age,]$age <- mean_age

#fill empty values for lifeboat ('boat') column
empty_boat <- is.na(titanic$boat) | titanic$boat==''
titanic[empty_boat,]$boat <- 'NA'

#create variable to hold binary for whether a passenger had a cabin listed in the file
titanic <- mutate(titanic,has_cabin_number = ifelse(is.na(cabin), 0, 1))


#write to clean file
write.csv(titanic,file='titanic_clean.csv')
