# Architecture Design



<!--
<img src="./assets/images/clean.jpeg" width="800">
<img src="./assets/images/viper.png" width="800">-->


## Introduction

This architecture is based on the Clean Architecture by Uncle Bob. The main focus of the architecture is separation of concerns and scalability. It consists of three main modules: Domain, App and Data.

## The Dependency Rule

<div class="note info"><p>Source code dependencies only point inwards. This means inward modules are neither aware of nor dependent on outer modules. However, outer modules are both aware of and dependent on inner modules. Outer modules represent the mechanisms by which the business rules and policies (inner modules) operate. The more you move inward, the more abstraction is present. The outer you move the more concrete implementations are present. Inner modules are not aware of any classes, functions, names, libraries, etc.. present in the outer modules. They simply represent rules and are completely independent from the implementations.</p></div>



## Domain
