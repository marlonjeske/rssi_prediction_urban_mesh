# RSSI PREDICTION FOR URBAN MESH NETWORKS

Train and validate with k-fold cross-validation using Random Forest and Support Vector Regression

To use this code, the only input needed is "data-rssi-urban.csv," which contains:

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
