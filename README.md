## Title
Real Estate Connect - Bringing Buyers and Sellers Together Seamlessly
## Team Members
Robert Grooms
Rishav Patel
## Description
Search, schedule showings and make offers for real estate, avoiding realtor fees.
List properties, accept showings and await offers, avoiding realtor fees.
## App Functions
1. Customer (the buyer)
    1. Create/modify/remove customer profile
    2. Search Real Estate Listings
    3. Make an offer/counter-offer 
    4. Chat with Real Estate Bot
2. Provider (the seller)
    1. Create/modify/remove provider profile
    2. List Property
    3. View Offers
    4. Accept/Make Counter offers

## To run the project, be sure to include within application.properties
spring.application.name=RealEstateApiApplication
spring.datasource.url=*****
spring.jpa.hibernate.ddl-auto=update
spring.datasource.driver-class-name=org.postgresql.Driver
spring.jpa.show-sql=true

spring.mvc.view.prefix=/templates/
spring.mvc.view.suffix=.ftlh
spring.freemarker.template-loader-path=classpath:/templates
spring.freemarker.suffix=.ftlh
spring.freemarker.cache=false

logging.level.org.springframework.security=DEBUG
logging.level.web=DEBUG

spring.servlet.multipart.max-file-size=10MB
spring.servlet.multipart.max-request-size=20MB
openai.api.key=*****