# Software Requirements Specification
## For Customizable Newsletter

Version 0.1  
Prepared by Namrata Karki, James Kerrigan  
CSC 340
September 16, 2025


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
| Name | Date       | Reason For Changes  | Version   |
| ---- | ---------- | ------------------- | --------- |
| J.K. | 09/18/2025 | Updating SRS        | 0.1       |
|      |            |                     |           |
|      |            |                     |           |
|      |            |                     |           |

## 1. Introduction

### 1.1 Document Purpose
The purpose of this Software Requirements Specification Document (SRS) is to describe the client-side and developer-side requirements for the CustomizableNewsletter software.
Client-oriented requirements describe the system from the client’s view. These requirements include a description of the different types of users served by the system.
Developer-oriented requirements describe the system from a software developer’s view. These requirements include but aren't limited to a detailed description of functional, data, performance, ststistcal metricss.

### 1.2 Product Scope
The purpose of this software is to allow customers easy and reliable access to news that they care about, customized by them to thier preferences. This system is going to be an application downloadable by any potential client, to ensure ease of use and development.

### 1.3 Definitions, Acronyms and Abbreviations
| Reference  | Definition                                                                                                   
|------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Java       | A programming language originally developed by James Gosling at Sun Microsystems. We will be using this language to build the backend service for LocalHarvest Hub                 |
| Postgresql | Open-source relational database management system.                                                                                                                                 |
| API        | Application Programming Interface. This will be used to interface the backend and the fronted of our application.                                                                  |
| HTML       | Hypertext Markup Language. This is the code that will be used to structure and design the web application and its content.                                                         |
| CSS        | Cascading Style Sheets. Will be used to add styles and appearance to the web app.                                                                                                  |
| JavaScript | An object-oriented computer programming language commonly used to create interactive effects within web browsers.Will be used in conjuction with HTML and CSS to make the web app. |
| VS Code    | An integrated development environment (IDE) for Java. This is where our system will be created.                                                                                    |
|            |                                                                                                                                                                                    |                                                                                             |

### 1.4 References
https://www.twilio.com/docs/sendgrid/api-reference

### 1.5 Document Overview
Section 1 goes over a general idea of what can be expected of this software, along with helpful acronyms and terms that will be scattered throughout this SRS. Section two focuses on the product itself, including restraints, functions and certain assumptions we have going forward about the user and the development process as a whole. Section three focuses on the more business side of the project, including cost, time of launch, and less functional requirements.

## 2. Product Overview
CustomizableNewsletter is a executable program that will allow users to customize their news feeds with information that they actually want to see. Tehy'll be able to browse topics and read stories in each topic that can help them decide if that's a regualr piece of news they're wanting to learn more about. Writers will be able to post new stories and view how well or poorly their topic is being recieved. This system will allow for customers, writers, and sysadmin to help ensure a smooth and well managed news outlet for everyone.

### 2.1 Product Functions
CustomizableNewsletter will let Writers write and moderate their stories. They can view how their topic is performing, and respond to reviews. Users can customize their weekly email to have whatever topics suit their interst, and can also browse topics or review them.

### 2.2 Product Constraints
At this point, the program will only run on a computer with Java jdk 21 installed. The full scope of the project is hopefully realized, however the team has a deadline of about 10 weeks, which could lead to feature cuts. The program would have a challenge scaling, as the current plan is to use a free version of a Postgresql database to store the information, as well as stress-test the free version of an email-API to handle the sending of the newsletters.
  
### 2.3 User Characteristics
Our executable application does not expect our users to have any prior knowledge of a computer, apart from downloading a client. As long as users know what news topics they want to read about, they should be expert level within several uses of the application.

### 2.4 Assumptions and Dependencies
We will be using Java and developed with VS Code. The application will also use an external email API that will help customers recieve their newsletters on a regular weekly basis.

## 3. Requirements

### 3.1 Functional Requirements 

- FR0: The system will allow users to create accounts as either a customer or a writer.
   - Each account shall have a unique identifier assigned at the time of creation, customerID or writerID. 
- FR1: The system shall allow writers to create a new newsletter by providing writing the article and assigning it a topic.
- FR2: The system shall allow customers to browse through the list of newsletter either by the writer or topic.
   - The newsletters shall have a search and filter option.
- FR3: The system shall allow customers to subscribe to any topic or writer of their choosing. They can also subscribe to summary emails.
   - A customer may unsubscribe at any time if they are not longer interested in maintainging their subscription.
- FR4: Users can modify their own profiles at any time.
- FR5: The system shall allow customers to rate and review the articles.
- FR6: The system shall allow a writers to respond to a review.

#### 3.1.1 User interfaces
Website made with HTML, CSS and Javascript. API's may be used.

#### 3.1.2 Hardware interfaces
Any device that can run a website/ have a web browser.

#### 3.1.3 Software interface
VS Code 1.104.0
Java JDK 21
Twilio (Email API)
Git 2.50.1.windows.1

### 3.2 Non Functional Requirements 

#### 3.2.1 Performance

- NFR0: The new user will be able to add and manage  subscriptions in less than 1 minutes.
- NFR1: The expert user will be able to add and manage produce subscriptions in less than 30 sec.

#### 3.2.2 Security
- NFR2: The system is only available to authorized users, using their username and password.

#### 3.2.3 Reliability
- NFR3: Articles can have links to other sources to make sure the articles are reliable.

#### 3.2.4 Availability
- NFR4: The customicable newsletter web will be available 24/7. Users can reach out if they have any issue. Monthy maintainance will be scheduled to keep up with the web.

#### 3.2.5 Compliance

#### 3.2.6 Cost
- NFR5: We expect to spend zero dollars on this project.

#### 3.2.7 Deadline
- NFR6: The final product must be delivered by December 2025.
