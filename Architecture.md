# Project Architecture Design

<img src="./assets/images/clean.jpeg" width="800">

## Introduction

This architecture is based on the Clean Architecture by Uncle Bob. The main focus of the architecture is separation of concerns and scalability. It consists of three main modules: Domain, App and Data.

<img src="./assets/images/viper.png" width="800">

## The Dependency Rule

**Source code dependencies only point inwards.** This means inward modules are neither aware of nor dependent on outer modules. However, outer modules are both aware of and dependent on inner modules. Outer modules represent the mechanisms by which the business rules and policies (inner modules) operate. The more you move inward, the more abstraction is present. The outer you move the more concrete implementations are present. Inner modules are not aware of any classes, functions, names, libraries, etc.. present in the outer modules. They simply represent rules and are completely independent from the implementations.

## Domain

The Domain module defines the business logic of the application. It is a module that is independent from the development platform i.e. it is written purely in the swift, also allows for easy migration between platforms, such as MacOS or iPadOS.


### Contents of Domain

Domain is made up of several things:

- Entity
    - Enterprise-wide business rules
    - Business objects of the application
    - Used application-wide
    - Least likely to change when something in the application changes
- Interactors (Usecases)
    - Application-specific business rules
    - Orchestrate the flow of data throughout the app
    - Should not be affected by any UI changes whatsoever
    - Might change if the functionality and flow of application change
- Repositories
    - Protocols that define the expected functionality of outer layers
    - Passed to interactor from outer layers

Domain represents the inner-most layer. Therefore, it the most abstract layer in the architecture.


## App