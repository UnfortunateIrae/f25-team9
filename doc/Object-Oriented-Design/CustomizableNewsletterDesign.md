# CustomizableNewsletter - Software Design 

Version 1  
Prepared by James Kerrigan and Namrata Karki\
CustimizableNewsletter\
Oct 20, 2025

Table of Contents
=================
* [Revision History](#revision-history)
* 1 [Product Overview](#1-product-overview)
* 2 [Use Cases](#2-use-cases)
  * 2.1 [Use Case Model](#21-use-case-model)
  * 2.2 [Use Case Descriptions](#22-use-case-descriptions)
    * 2.2.1 [Actor: Writer](#221-actor-Writer)
    * 2.2.2 [Actor: Customer](#222-actor-customer) 
* 3 [UML Class Diagram](#3-uml-class-diagram)
* 4 [Database Schema](#4-database-schema)

## Revision History
| Name | Date    | Reason For Changes  | Version   |
| ---- | ------- | ------------------- | --------- |
|  JK  |10/20    | Producer Cases      |    1.1    |
|      |         |                     |           |
|      |         |                     |           |

## 1. Product Overview
CustomizableNewsletter is an easy to use, web-based application that will allow for people to quickly choose which topics they'd like to hear more about on the news. What's more is that the articles they've indicated inerest in will be delivered directly
to their email inbox, with no further interaction!

## 2. Use Cases
### 2.1 Use Case Model
![Use Case Model](https://github.com/UnfortunateIrae/f25-team9/tree/main/doc/Object-Oriented-Design/Use%20Cases)

### 2.2 Use Case Descriptions

#### 2.2.1 Actor: Writer
##### 2.2.1.1 Sign Up
A Writer can sign up to create their profile with their name, email, password, and phone number. Emails must be unique.
##### 2.2.1.2 Log In
A Writer shall be able to sign in using their registred email and password. After logging in, the Writer shall be directed their dashboard where they see an overview of their topic, articles and stats.
##### 2.2.1.3 Update Profile
A Writer shall be to modify their profile by going to their profile page. They can change their email, password, and topic.
##### 2.2.1.4 Create Article
The Writer shall be able to create a new article. They would provide an article title, and description. This article will be created to be associated with only this Writer and their topic.
##### 2.2.1.5 Post Articles
A Writer will be able to post their article to their topic.
##### 2.2.1.6 Edit Article
A Writer can edit their article after it's been posted.
##### 2.2.1.7 View Statistics
A Writer will be able to view several statistics such as total subscribers, and average ratings.
##### 2.2.1.8 Reply to reviews
A Writer shall be able to reply to reviews made about their articles/topics.

#### 2.2.2 Actor: Customer
##### 2.2.2.1 Sign Up
A customer can sign up to create their profile with their name, email, password, and address. Emails must be unique.
##### 2.2.2.2 Log In
A customer shall be able to sign in using their registred email and password. After logging in, the customer shall be directed their dashboard where they see an overview of their subscriptions.
##### 2.2.2.3 Browse Produce Boxes
A customer shall be able to view available produce boxes. They can do this from the home page or using a search function. They can also filter boxes by name, descriptions, or farm. They will also be able to select one box and view more details.
##### 2.2.1.4 Subscribe to Produce Box
Upon selecting a box, a customer shall be able to subscribe for the box using a one-click action. This box will then appear on their dashboard, and they will be able to ammend the subscription.
##### 2.2.1.5 Review Produce Box
A customer may write a review for a box they subscribed to. They will be able to rate the box based on freshness and delivery.

## 3. UML Class Diagram
![UML Class Diagram](https://github.com/UnfortunateIrae/f25-team9/blob/b7052b9763d7633985e1ae27d4f2c525f81d800b/doc/Object-Oriented-Design/UML%20Diagram/UML%20Diagram.png)
## 4. Database Schema
![UML Class Diagram](https://github.com/csc340-uncg/f25-team0/blob/main/doc/Object-Oriented-Design/schema.png)