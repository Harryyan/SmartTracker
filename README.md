# SmartTracker

[![Swift](https://img.shields.io/badge/Swift-5.5-orange?style=flat-square)](https://img.shields.io/badge/Swift-5.5-Orange?style=flat-square)
[![Platforms](https://img.shields.io/badge/Platforms-iOS_iPadOS-yellowgreen?style=flat-square)](https://img.shields.io/badge/Platforms-iOS_iPadOS-Green?style=flat-square)
[![Xcode](https://img.shields.io/badge/Xcode-13 Beta 5-blue?style=flat-square)](https://img.shields.io/badge/Platforms-iOS_iPadOS-Green?style=flat-square)

#### ⚠️ To run this project, please use lastest Xcode 13 Beta 5 (Beta 4 is also OK) ⚠️

## Contents

- [Requirements](#requirements)
- [Features](#features)
- 
## Requirements

- iOS 15.0
- Xcode 13 Beta 5
- Swfit 5.5
- Mac OS (Monterey) - Optional

## Features

- Display pre-defined categories with **budget** and current **total expense** in current month
- Highlight category if total expense of it exceed its budget
- Display transaction list with local currency(NZD)
- Support Add / Edit Transaction on title, amount, currency, category, date and time.
- Support deleting one transaction
- Fetch latest *USDNZD* rate from [Currency Layer]( https://currencylayer.com)
- Support ** Datalayer** to save app data to the local database (CoreData)

### Display Categories

<img src="./assets/images/categories.png" width="200">

### Highlight category when expense over budget

Each category has monthly budget, if the current expense of it exceeds this value, the total expense text will be highlighted in red, like below screenshot:

<img src="./assets/images/highlight.png" width="200">

### Display Transactions

Transaction list shows all transactions with title, category, amount in NZD and occurOn date. All transaction records with USD currency will be converted to NZD automatically on this page.

<img src="./assets/images/transactions.png" width="200">

### Add / Edit Transaction

User can click "+" button(top right) to add a new transaction or tap on existing transaction to edit it.

<img src="./assets/images/edit.png" width="200">

### Delete Transaction

User can delete one transaction by swipe item to left.

<img src="./assets/images/delete.png" width="200">

### Fetch latest currency rate

*Datalayer* is responsible for fetching lastest USD to NZD currency rate and save it in @AppStorage.

### DataLayer

This is for keeping user's transaction records into local database by using CoreData with *Repository Pattern*