# set github return url to http://127.0.0.1:1410
# load httr lib
library(httr)
library(rjson)
library(httpuv)

# search for github endpoints
oauth_endpoints("github")


# create 
myapp <- oauth_app("github", key = "e859504a2b582d3eae0c",
                   secret = "8ed656d062b24343ea01241ce7be00d87a553b85"
)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp, cache=FALSE)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos")
stop_for_status(req)
data <- content(req)
for(i in c(1:length(data))){ 
     if(data[[i]]$name == "datasharing"){
         print(data[[i]]$created_at);
     }
}

library(sqldf)
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv', destfile = "datasspid.csv")
acs = data.frame(read.csv('datasspid.csv'))
sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select distinct AGEP from acs")

html = readLines('http://biostat.jhsph.edu/~jleek/contact.html')
nchar(html[10])
nchar(html[20])
nchar(html[30])
nchar(html[100])

data = read.fwf(file=url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"), skip=4,
                widths=c(13, 6, 4, 9, 4, 9, 4, 9, 4))