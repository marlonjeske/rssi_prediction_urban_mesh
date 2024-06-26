# Received Signal Strength Indicator Prediction for Mesh Networks in a Real Urban Environment Using Machine Learning

To cite the contents of this repository, please cite this the paper and this repo.
Below is the BibTex for citing this snapshot of the repository.

@misc{Jeskeetal2024,
  author =        {M. Jeske and B. Sansó and D. Aloise and M. C. V. Nascimento},
  title =         {Received Signal Strength Indicator Prediction for Mesh Networks in a Real Urban Environment Using Machine Learning},
  year =          {2024},
  url =           {https://github.com/marlonjeske/rssi_prediction_urban_mesh},
  note =          {Submitted to IEEE Access},
}  

# Description

Train and validate with k-fold cross-validation using Random Forest and Support Vector Regression

To use this code, the only input needed is "random_dataset-rssi-urban.csv" which contains:

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
