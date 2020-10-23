covidcounty1<-read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")
covidcounty1<-covidcounty1[!is.na(covidcounty1$fips),]
covidcounty1$date<-as.Date(covidcounty1$date,format="%Y-%m-%d")

covidcounty1$newcases<-covidcounty1$cases- covidcounty1$cases[match(paste0(covidcounty1$date-7,"_",covidcounty1$fips),paste0(covidcounty1$date,"_",covidcounty1$fips))]
covidcounty1$newdeaths<-covidcounty1$deaths- covidcounty1$deaths[match(paste0(covidcounty1$date-7,"_",covidcounty1$fips),paste0(covidcounty1$date,"_",covidcounty1$fips))]
covidcounty1<-covidcounty1[!is.na(covidcounty1$newcases),]
View(covidcounty1)

#Calculating per capita new cases
countypop<-read.csv("https://github.com/TLydon/COVIDGeo/raw/master/CovidCounty/CountyPopulation.csv")
covidcounty1<-merge(covidcounty1,countypop,by="fips")

covidcounty1$newcasescapita<-covidcounty1$newcases/covidcounty1$population
covidcounty1$newdeathscapita<-covidcounty1$newdeaths/covidcounty1$population


county2016<-read.csv("https://raw.githubusercontent.com/tonmcg/US_County_Level_Election_Results_08-16/master/2016_US_County_Level_Presidential_Results.csv")
county2016$netdem<-county2016$per_dem-county2016$per_gop
county2016$dembin<-as.numeric(county2016$netdem>0)
