
### Load the dataset
data_dir <- "/Users/jeevarehakrishnaraj/Desktop/Springboard/Project 2/Project2"
titanic_original <- read.csv(file.path (data_dir, "titanic_original.csv" ), header = TRUE)

colnames(titanic_original)
titanic_original$embarked


# Port of embarkation filled with S
titanic_original$embarked <- as.character(titanic_original$embarked)
embarkedwithS <- titanic_original %>% mutate(embarked = ifelse(embarked == '','S',embarked))  
embarkedwithS$embarked

# Missing age filed with Mean Age
Original_Age <- filter(embarkedwithS, age != '')
Original_Age_mean <- mean(Original_Age$age)
Filled_MeanAge <- embarkedwithS %>%  mutate(age = ifelse(is.na(age), Original_Age_mean,age))
Filled_MeanAge$age

# Missing passenger with None
Empty_boat <- Filled_MeanAge %>% mutate(boat = ifelse(boat == '', 'None',boat))
Empty_boat$boat

# Assign has_cabin_number 1 if there is a cabin number and 0 otherwise.
Cabin_Number <- Empty_boat %>% mutate(has_cabin_number = ifelse(cabin == '',0,1))
Cabin_Number$has_cabin_number

#Export the refined dataset
write.csv(Cabin_Number$has_cabin_number,file.path(data_dir,"titanic_clean.csv"))
