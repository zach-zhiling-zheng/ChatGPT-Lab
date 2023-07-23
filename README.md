# ChatGPT-Lab

This repository contains the code for the **ChatGPT-Lab** project, which is used to optimize experimental conditions and automate reaction mixture preparation in a lab setting. This project makes use of machine learning and robotic process automation technologies.

## Files

The repository contains the following main files:

- `Atlas`: This Jupyter notebook is an auxiliary script that generates new prompts based on past interactions with the AI project manager, Atlas. 

- `Curie`: This script contains the Bayesian optimization of experimental conditions. 

- `Deng`: This script contains an Opentron protocol for automated preparation of reaction mixtures.

- `Edison`: This script contains an code to generate 3D printing models.

- `3dprint_6_tuberack_35000ul.json` and `3dprint_8_tuberack_20000ul.json`: These files are JSON configurations for 3D printed tube racks that hold vials of different volumes.

- `Tuberack.scad` and `Vial_Plate.scad`: These are OpenSCAD scripts used to generate 3D models for the custom vial holders used in this project. The code includes parameters for customizing the dimensions, including plate thickness, post thickness, post height, tube radius, hole depth, and plate length.

- `test_3dprint_6_tuberack_35000ul.py` and `test_3dprint_8_tuberack_20000ul.py`: These are test scripts for the 3D printed tube racks, which is required by Opentron sofeware or API.



## Usage

### Atlas_Prompt_Generator.ipynb

The script reads the past task suggestions made by Atlas, the task selected by the chemist, and the chemist's feedback to generate a new prompt. It extracts this information using regular expressions and formulates a new prompt using a predefined template. The extracted information and the new prompt are stored in a pandas DataFrame for easy access and manipulation. This script serves to create a more personalized and interactive experience for the chemist by dynamically generating the next step in the interaction based on the chemist's previous decisions and feedback.

### Curie_BORF.ipynb

Before running this script, ensure that the initial dataset is available in CSV format. After the script suggests experimental conditions, perform the experiments and manually enter the crystallinity scores to the .csv file. Subsequently, run the update function in the script.

### Deng_code_Robot.py

This script is a protocol for Opentron and can be uploaded directly to the Opentron app. Please ensure that the labware and pipette setup matches the specifications in the script.

### Edison_Tuberack.scad and Edison_Vial_Plate.scad

Please download OpenSCAD and run the code. Adjust the paramters according to the comments. Use F6 to generate the stl file.

## Dependencies

### Atlas_Prompt_Generator.ipynb

- pandas
- re (Python's built-in regular expression module)

### Curie_BORF.ipynb

- scikit-learn==1.0
- scikit-optimize==0.9.0
- scipy==1.10.1
- pandas
- numpy

**NOTE:** Due to syntax incompatibility between the installed scikit-learn and scikit-optimize, the source code of the scikit-optimize package needs to be modified prior to running this script.

After installing the scikit-optimize package, navigate to `Installation Directory/skopt/learning/forest.py`.

In line 243, correct to `self.criterion != “squared_error”` (inside the predict function of class RandomForestRegressor).

### Deng_code_Robot.py

- Opentron's python API

### Tuberack.scad and Vial_Plate.scad

- OpenSCAD
