library(dplyr)
toys <-  refine_original

#convert company to lower case
toys$company <- tolower(toys$company)

#update company names
toys[grep("ph", toys$company),1] <- 'philips'
toys[grep("ips", toys$company),1] <- 'philips'
toys[grep("ak", toys$company),1] <- 'akzo'
toys[grep("unil", toys$company),1] <- 'unilever'

#Separate the product code and product number into separate columns
pcode <- toys$`Product code / number`
toys$product_code <- ''
toys$product_number <- 0
toys$product_category <- 'NA'
for (i in 1:length(pcode)){
  toys$product_code[i] <- strsplit(pcode[i],'-')[[1]][1]
  toys$product_number[i] <- strsplit(pcode[i],'-')[[1]][2]
  if(toys$product_code[i] == 'p') {
    toys$product_category[i] <- 'Smartphone'
  } else if (toys$product_code[i] == 'v'){
    toys$product_category[i] <- 'TV'
  } else if (toys$product_code[i] == 'x'){
    toys$product_category[i] <- 'Laptop'
  } else if (toys$product_code[i] == 'q'){
    toys$product_category[i] <- 'Tablet'
  }
  
}

#Add geocoding data for full_address
toys <- mutate(toys, full_address = paste(address, city, country, sep = ", "))

#Add dummy variables
toys <-  mutate(toys, company_philips = ifelse(company == 'philips', 1, 0))
toys <-  mutate(toys, company_akzo = ifelse(company == 'akzo', 1, 0))
toys <-  mutate(toys, company_van_houten = ifelse(company == 'van houten', 1, 0))
toys <-  mutate(toys, company_unilever = ifelse(company == 'unilever', 1, 0))

toys <-  mutate(toys, product_smartphone = ifelse(product_category == 'Smartphone', 1, 0))
toys <-  mutate(toys, product_tv = ifelse(product_category == 'TV', 1, 0))
toys <-  mutate(toys, product_laptop = ifelse(product_category == 'Laptop', 1, 0))
toys <-  mutate(toys, product_tablet = ifelse(product_category == 'Tablet', 1, 0))

#Write the clean data to new file
write.csv(toys, file="refine_clean.csv")