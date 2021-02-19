## Description of the Project
* We aim to prepare a dynamic vaccine allocation system. The application optimally prioritize the vaccine distribution across nation with a mathematical model to back it's proper functioning thus minimizing cost, duration, lives lost and several other parameters.

## Novelty of the Solution
* Despite how universal this vaccine distribution problem is, there isn’t any concrete model or system to fully optimise this process in order to flatten the rising Covid cases curve.

## Parameters Considered
* AGE/LIFE EXPECTANCY (%)
  * max(0, (avg_age - current_age) / 70) * 100

* TYPE OF CLASS (out of 100):

|   **Occupation**        | **Weightage**                                                          |
|-------------------------|------------------------------------------------------------------------|
| Frontliner                    | 100                                                          |
| Working Class                    | 80                                                          |
| Unhealthy(with Comorbidity)/old                   | 70                                                          |
| Lactating Women                    | 60                                                          |
| Rest                    | 50                                                          |

* GROWTH RATE OF Covid CASES IN NATIVE POPULATION (in %)
  * Imported from API (https://api.covid19india.org/state_district_wise.json)
* POPULATION DENSITY (factor out of 100)
  * (cur_state_density / max_pop_density) * 100
  
* Final Algorithm
  * Grade Point = Σ (3a, 3b, 3c, d) / 10
  * This grade point will lie in range [0, 100] and on this basis priority can be assigned for given range and stored as column within MySql database along with user details.
  * Now Priority will be set accordingly from database:
    1. Priority 1    =    Top 10%
    2. Priority 2    =    10 - 20%
    3. Priority 3    =    20 - 40%
    4. Priority 4    =    40 - 70%
    5. Priority 5    =     70 - 100% (Bottom 30%)
    
    
## Images 
<p align="center">
    <img src="app-preface-1.png" alt="App-Preface-Image1">
</p>


## How Program Fuctions

  * Step1: Fetch details of user
  * Step2: Feed the details into model to assign score/priority value.
  * Step3: Save the user into database with it’s assigned priority.
  * Step4: Keep the database sorted in order to get ordering of vaccination of regional population.
  * Step5: Calculate time of vaccination for each individual accordingly.
  * Video Demo link : https://youtu.be/YRikBqPfWfA
## Technologies Used

* This project is a starting point for a Flutter application.

  * A few resources to get you started if this is your first Flutter project:

    - [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
    - [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

      For help getting started with Flutter, view our
      [online documentation](https://flutter.dev/docs), which offers tutorials,
      samples, guidance on mobile development, and a full API reference.
      
* MySQL
* Flask
* Rest API

