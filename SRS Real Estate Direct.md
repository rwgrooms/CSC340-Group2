# Software Requirements Specification
## For Real Estate Direct

Version 0.1  
Prepared by Robert Grooms  
CSC340  
May 25, 2025

Table of Contents
=================
* [Revision History](#revision-history)
* 1 [Introduction](#1-introduction)
  * 1.1 [Document Purpose](#11-document-purpose)
  * 1.2 [Product Scope](#12-product-scope)
  * 1.3 [Definitions, Acronyms and Abbreviations](#13-definitions-acronyms-and-abbreviations)
  * 1.4 [References](#14-references)
  * 1.5 [Document Overview](#15-document-overview)
* 2 [Product Overview](#2-product-overview)
  * 2.1 [Product Functions](#21-product-functions)
  * 2.2 [Product Constraints](#22-product-constraints)
  * 2.3 [User Characteristics](#23-user-characteristics)
  * 2.4 [Assumptions and Dependencies](#24-assumptions-and-dependencies)
* 3 [Requirements](#3-requirements)
  * 3.1 [Functional Requirements](#31-functional-requirements)
    * 3.1.1 [User Interfaces](#311-user-interfaces)
    * 3.1.2 [Hardware Interfaces](#312-hardware-interfaces)
    * 3.1.3 [Software Interfaces](#313-software-interfaces)
  * 3.2 [Non-Functional Requirements](#32-non-functional-requirements)
    * 3.2.1 [Performance](#321-performance)
    * 3.2.2 [Security](#322-security)
    * 3.2.3 [Reliability](#323-reliability)
    * 3.2.4 [Availability](#324-availability)
    * 3.2.5 [Compliance](#325-compliance)
    * 3.2.6 [Cost](#326-cost)
    * 3.2.7 [Deadline](#327-deadline)

## Revision History
|     Name      |     Date     | Reason For Changes  | Version   |
| ------------- | ------------ | ------------------- | --------- |
| Robert Grooms | May 25, 2025 | Initial Creation    | 0.1       |
|               |              |                     |           |


## 1. Introduction

### 1.1 Document Purpose
The purpose of this Software Requirements Specification (SRS) is to describe the client-view and developer-view requirements for the Real Estate Direct application.
Client-oriented requirements describe the system from the client’s perspective. These requirements include a description of the different types of users served by the system.
Developer-oriented requirements describe the system from a software developer’s perspective. These requirements include a detailed description of functional, data, performance, and other important requirements.

### 1.2 Product Scope
The purpose of the Real Estate Direct system is to provide the ability to buy or sale real estate directly without a real estate agent. The system is based on a relational database with property listings and purchase offer/counter offer functionality. We will have a database server supporting both buyers and sellers. Above all, we hope to provide a comfortable user experience along with the best offerings available.

### 1.3 Definitions, Acronyms and Abbreviations                                                                                                                                                                          |

1.3 Definitions, Acronyms and Abbreviations
Reference	Definition
Java		A programming language originally developed by James Gosling at Sun Microsystems. We will be using this language to build Class Connect.
Postgresql	Open-source relational database management system.
SpringBoot	An open-source Java-based framework used to create a micro Service. This will be used to create and run our application.
Spring MVC	Model-View-Controller. This is the architectural pattern that will be used to implement our system.
Spring Web	Will be used to build our web application by using Spring MVC. This is one of the dependencies of our system.
API		Application Programming Interface. This will be used to interface the backend and the fronted of our application.
HTML		Hypertext Markup Language. This is the code that will be used to structure and design the web application and its content.
CSS		Cascading Style Sheets. Will be used to add styles and appearance to the web app.
JavaScript	An object-oriented computer programming language commonly used to create interactive effects within web browsers.Will be used in conjuction with HTML and CSS to make the web app.
React		A JavaScript library for building user interfaces using reusable components and a virtual DOM to efficiently update the browser view.
VS Code		An integrated development environment (IDE) for Java. This is where our system will be created.

### 1.4 References
https://spring.io/guides
https://react.dev/
https://pure-css.github.io/

### 1.5 Document Overview
Section 1 is a general introduction to the document, intended for any readers. Section 2 is focused on the product and its features. This section is for customers and business stakeholders. Section 3 specifies the requirements and constraints for the product and development process. This section is intended for all stakeholders, especially the development team.

## 2. Product Overview
Real Estate Direct provides sellers the ability to list property for sale and buyers the ability to make offers directly on those properties, avoiding the typical 6% commission that real estate agents charge.

### 2.1 Product Functions
Real Estate Direct allows sellers to list property for sale and accept, reject or counter any offers received.  Buyers can view properties, submit offers and also counter any counter offers received.

### 2.2 Product Constraints
At this point, the program will only run on a computer with Java jdk 21 installed. The full scope of the project is hopefully realized, however the team has a deadline of a few weeks, which could lead to feature cuts. The program would have a challenge scaling, as the current plan is to use a free version of a Postgresql database to store the information.
  
### 2.3 User Characteristics
Our website application does not expect our users to have any prior knowledge of a computer, apart from using a web browser. As long as users know the details of the properties they are listing or interested in buying, they should be expert level within several uses of the application.

### 2.4 Assumptions and Dependencies
We will be using Java, with our program being dependent on Spring and SpringBoot, React, and RestAPI to connect to external APIs and developed with VS Code. The application will use an external api to find nearby zipcodes that will help filter real estate within the area of interest.

## 3. Requirements

### 3.1 Functional Requirements 

* FR1:  The system must allow potential users the ability to register
* FR2:  The system will require an email
* FR3:  The system will require a minimum of a  10 character password
* FR4:  The system will validate the email (simulate)
* FR5:  The system will allow an individual to register as either a seller or buyer
* FR6:  The system will require a phone number
* FR7:  The system will allow a non-filtered view of all listings
* FR8:  The system will allow buyers to filter listings by location
* FR9:  The system will allow sellers to upload pictures
* FR10: The system will allow sellers to provide an asking price
* FR11: The system will allow sellers to provide an address
* FR12: The system will allow, as part of the listing, a minimum deposit required to make an offer
* FR13: The system will allow the buyer or seller to submit a counter offer price
* FR14: The system will allow the seller to accept an offer
* FR15: The system will allow the user to remove their profile
* FR16: The system will implement an API to allow for property searches of nearby zipcodes

#### 3.1.1 User interfaces
Web pages using HTML, CSS, Pure.CSS, React and JavaScript.

#### 3.1.2 Hardware interfaces
Devices that have web browser capabilities.

#### 3.1.3 Software interfaces
Java jdk 21
PostgreSQL 17
SpringBoot 3.4.5
React
External API for location searching

### 3.2 Non Functional Requirements 

#### 3.2.1 Performance
NFR0: The Real Estate Direct system will consume less than 100 MB of memory
NFR1: The seller will be able to list a property in less than 5 minutes.
NFR2: The buyer will be able to make an offer on a property in less than 1 minute.

#### 3.2.2 Security
NFR3: The system is going to be available only to authorized users, using their username and password.

#### 3.2.3 Reliability


#### 3.2.4 Availability
NFR4: Real Estate Direct will be available 24/7. Scheduled Maintenance should be initialized during scheduled low activity hours such as federal holidays to minimize conflict with user’s using the app.

#### 3.2.5 Compliance

#### 3.2.6 Cost
NFR5: We expect to spend zero dollars on this project.

#### 3.2.7 Deadline
NFR6: The final product must be delivered on June 18th.
