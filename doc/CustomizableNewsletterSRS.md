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
This section specifies the software product's requirements. Specify all of the software requirements to a level of detail sufficient to enable designers to design a software system to satisfy those requirements, and to enable testers to test that the software system satisfies those requirements.

The specific requirements should:
* Be uniquely identifiable.
* State the subject of the requirement (e.g., system, software, etc.) and what shall be done.
* Optionally state the conditions and constraints, if any.
* Describe every input (stimulus) into the software system, every output (response) from the software system, and all functions performed by the software system in response to an input or in support of an output.
* Be verifiable (e.g., the requirement realization can be proven to the customer's satisfaction)
* Conform to agreed upon syntax, keywords, and terms.

#### 3.1.1 User interfaces
Define the software components for which a user interface is needed. Describe the logical characteristics of each interface between the software product and the users. This may include sample screen images, any GUI standards or product family style guides that are to be followed, screen layout constraints, standard buttons and functions (e.g., help) that will appear on every screen, keyboard shortcuts, error message display standards, and so on. Details of the user interface design should be documented in a separate user interface specification.

Could be further divided into Usability and Convenience requirements.

#### 3.1.2 Hardware interfaces
Describe the logical and physical characteristics of each interface between the software product and the hardware components of the system. This may include the supported device types, the nature of the data and control interactions between the software and the hardware, and communication protocols to be used.

#### 3.1.3 Software interfaces
Describe the connections between this product and other specific software components (name and version), including databases, operating systems, tools, libraries, and integrated commercial components. Identify the data items or messages coming into the system and going out and describe the purpose of each. Describe the services needed and the nature of communications. Refer to documents that describe detailed application programming interface protocols. Identify data that will be shared across software components. If the data sharing mechanism must be implemented in a specific way (for example, use of a global data area in a multitasking operating system), specify this as an implementation constraint.

### 3.2 Non Functional Requirements 

#### 3.2.1 Performance
If there are performance requirements for the product under various circumstances, state them here and explain their rationale, to help the developers understand the intent and make suitable design choices. Specify the timing relationships for real time systems. Make such requirements as specific as possible. You may need to state performance requirements for individual functional requirements or features.

#### 3.2.2 Security
Specify any requirements regarding security or privacy issues surrounding use of the product or protection of the data used or created by the product. Define any user identity authentication requirements. Refer to any external policies or regulations containing security issues that affect the product. Define any security or privacy certifications that must be satisfied.

#### 3.2.3 Reliability
Specify the factors required to establish the required reliability of the software system at time of delivery.

#### 3.2.4 Availability
Specify the factors required to guarantee a defined availability level for the entire system such as checkpoint, recovery, and restart.

#### 3.2.5 Compliance
Specify the requirements derived from existing standards or regulations

#### 3.2.6 Cost
Specify monetary cost of the software product.

#### 3.2.7 Deadline
Specify schedule for delivery of the software product.
