# Received Signal Strength Indicator Prediction for Mesh Networks in a Real Urban Environment Using Machine Learning

Source code for RSSI prediction using machine learning. This code includes training and validation with k-fold cross-validation using Random Forest and Support Vector Regression.

## Cite

To cite the contents of this repository, please cite this paper and this repo.

M. Jeske and B. Sansó and D. Aloise and M. C. V. Nascimento (2024) Received Signal Strength Indicator Prediction for Mesh Networks in a Real Urban Environment Using Machine Learning. Submitted to IEEE Access.

M. Jeske and B. Sansó and D. Aloise and M. C. V. Nascimento (2024) Received Signal Strength Indicator Prediction for Mesh Networks in a Real Urban Environment Using Machine Learning.(https://github.com/marlonjeske/rssi_prediction_urban_mesh).


## Data

To use this code, the only input needed is a CSV file, "dataset-rssi-urban.csv", which contains:

- node_tx: Tx ID
- node_rx: Rx ID
- distance: Distance from Tx to Rx in meters
- fresnel_obstruction: The percentage of obstruction in the first Fresnel zone
- altitude_tx: Tx altitude in meters
- altitude_rx: Rx altitude in meters
- terrain_min: minimum terrain altitude between Tx and Rx
- terrain_max: maximum terrain altitude between Tx and Rx
- terrain_mean: mean terrain altitude between Tx and Rx
- terrain_median: median terrain altitude between Tx and Rx
- terrain_sd: standard deviation of terrain altitude between Tx and Rx
- rssi: the received signal strength indicator in dBm (TARGET VARIABLE)


## To run the R code

1. **Prepare Your Data**: Ensure you have a CSV file with the required columns as described above. This file should be ready and saved on your computer.

2. **Open RStudio**: Launch RStudio on your computer. Open the R file "rssi_prediction_urban_mesh.R"

3. **Set Your Working Directory**: In RStudio, set your working directory to the folder where your CSV file is located. You can do this by clicking on the `Session` menu, selecting `Set Working Directory`, and then `Choose Directory...`. Navigate to the folder containing your CSV file and select it.

4. **Install Required Packages**: Ensure you have the necessary packages installed by running:
    ```R
    install.packages(c("tidyverse", "Metrics", "caret", "randomForest", "e1071"))
    ```
    
5. **Load Your Data**: If needed, update line 11 in the code to load your CSV file:
    ```R
    dados_reg <- read_delim("dataset-rssi-urban.csv", delim = ";")
    ```
6. **Run the R Code**: On the RStudio, click on the `Code` menu, then `Run Region`, and click on `Run All`. Or press `Ctrl + Alt + R`.

7. **View Results**: Check the console pane (bottom-left) to see the output.

