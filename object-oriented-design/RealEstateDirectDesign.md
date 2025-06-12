# Real Estate Direct - Software Design 

Version 1  
Prepared by Robert Grooms\
Real Estate Direct\
June 12, 2025

Table of Contents
=================
* [Revision History](#revision-history)
* 1 [Product Overview](#1-product-overview)
* 2 [Use Cases](#2-use-cases)
  * 2.1 [Use Case Model](#21-use-case-model)
  * 2.2 [Use Case Descriptions](#22-use-case-descriptions)
    * 2.2.1 [Actor: Buyer](#221-actor-buyer)
    * 2.2.2 [Actor: Seller](#222-actor-seller) 
* 3 [UML Class Diagram](#3-uml-class-diagram)
* 4 [Database Schema](#4-database-schema)

## Revision History
| Name | Date    | Reason For Changes  | Version   |
| ---- | ------- | ------------------- | --------- |
|  Al  | 6/12    | Initial Design      |    1      |
|      |         |                     |           |
|      |         |                     |           |

## 1. Product Overview
Real Estate Direct is a simple, comprehensive, easy to use web app with the goal of providing the ability for real estate sellers to list their property for sale. Buyers can view property listings and make offers.  Sellers can then accept, reject or counter the offers.

## 2. Use Cases
### 2.1 Use Case Model
![Use Case Model](https://github.com/rwgrooms/CSC340-Group2/blob/main/object-oriented-design/CS340-UML.jpg)

### 2.2 Use Case Descriptions

#### 2.2.1 Actor: Buyer
##### 2.2.1.1 Sign Up
A buyer can sign up to create their profile with their name, email, password, and bio. Emails must be unique.
##### 2.2.1.2 Log In
A buyer shall be able to sign in using their registred email and password. After logging in, the buyer shall be directed to their dashboard where they can browse properties and make offers.
##### 2.2.1.3 Update Profile
A buyer shall be to modify their profile by going to their profile page. They can change their email, password, and biography.
##### 2.2.1.4 View Properties
The buyer shall be able to view property listings. 
##### 2.2.1.5 Make Offers/Counter Offers
A buyer shall be able to make offers on real estate and counter offers.

#### 2.2.2 Actor: Seller
##### 2.2.2.1 Sign Up
A seller can sign up to create their profile with their name, email, password, and bio. Emails must be unique.
##### 2.2.2.2 Log In
A seller shall be able to sign in using their registred email and password. After logging in, the buyer shall be directed to their dashboard where they can browse properties and make offers.
##### 2.2.2.3 List Properties
A seller shall be able to list properties for sale.
##### 2.2.1.4 Accept, Reject or Counter offers
A seller can accept, reject or counter offers received from a buyer.

## 3. UML Class Diagram
![UML Class Diagram](https://github.com/rwgrooms/CSC340-Group2/blob/main/object-oriented-design/CS340-UML.jpg)
## 4. Database Schema
![UML Class Diagram](https://github.com/rwgrooms/CSC340-Group2/blob/main/object-oriented-design/DB-Diagram.jpg)

