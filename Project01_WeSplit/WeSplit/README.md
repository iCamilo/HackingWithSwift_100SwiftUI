# WeSplit

A simple project to calculate the check total including the tip and how to split it between the party members. \
It is a single project, but divided in multiple modules 

- `WeSplitTipCalculator` - Business Module containing the business use cases interfaces and implementations.
    - `RateTip` - Use case to tip the rate as  `Low`, `Good` or `Excellent`
    - `CalculateTip` - Use case to calculate the check totals: Tip Over Total, Total plus Tip and Total per Person

- `WeSplitPresentation` - VieModel and presentation logic to manage the WeSplit interface states and interactions.

- `WeSplit-iOS` - SwiftUI project for iOS devices 

- `WeSplit-watchOS` - SwiftUI project for watchOS devices

`WeSplitTipCalculator` and `WeSplitPresentation` modules are composed together to create WeSplit apps for iOS Devices and watchOS Devices. 

## Screenshots

**iOS**

![Simulator Screen Recording - iPhone SE (3rd generation) - 2024-05-22 at 17 02 11](https://github.com/iCamilo/HackingWithSwift_100SwiftUI/assets/8431922/8785ff6e-f4fb-411b-bdf0-4503fe6db2d3)


**watchOS**

![Simulator Screen Recording - Apple Watch SE (40mm) (2nd generation) - 2024-05-22 at 17 02 52](https://github.com/iCamilo/HackingWithSwift_100SwiftUI/assets/8431922/bacac946-4295-4cf0-9dda-c341caadee61)


## Specs

### Story: Calculate Check Total on information input

```
As an user I want that the check total is recalculated when I update any of the inputs.
```

#### Acceptance Criteria 
```
GIVEN the user input the check total
      OR the total of people 
      OR the tip total
THEN the app should calculate the check totals 
```
### Use Case: Calculate Tip 

_Data_
```
- Check total: Double
- Total people: Int
- Tip Total: Int
```

_Happy Path_
```
1. Execute "Calculate Tip" with the given data 
2. System calculates the tip over total, the total plus tip and the total per person
3. System delivers result with the calculated totals
```

_Sad Path: Total People is Zero_
```
System delivers total people can't be zero error 
```

### Use Case: Rate Tip 

_Data_
```
- Tip Total: Int
```

_Happy Path_
```
1. Execute "Rate Tip" with the given data
2. System rate the tip as low if it is equal or less to 5, as good if is greater than 6 but less or equal than 20 and excellent if is greater that 20
```

## Architecture Diagram 







 

 
