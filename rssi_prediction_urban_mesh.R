###################################################################################################################
#######################################   PACKAGES AND FOLDER   ###################################################
###################################################################################################################
library(tidyverse) #Used for data manipulation and plotting
library(Metrics) #Used for calculating error measures
library(caret) #Used for model training and cross-validation
library(randomForest) #Used for training the random forest model
library(e1071) #Used for tuning and training the SVR model

#Get data
dados_reg <- read_delim("dataset-rssi-urban.csv", delim = ";")

#Remove ID columns
dados_reg <- dados_reg[,c(-1,-2)]


###################################################################################################################
###################################   TUNING   ####################################################################
###################################################################################################################

#Tune RF com grid search
control <- trainControl(method="cv", number=10, search="grid")
set.seed(123)
tunegrid <- expand.grid(.mtry = c(1:9))
rf_gridsearch <- train(rssi ~ ., data = dados_reg, method = "rf", metric = "RMSE", tuneGrid = tunegrid, trControl = control)
print(rf_gridsearch)
plot(rf_gridsearch)


#RF tunned
model_rf <- randomForest(rssi ~ ., data = dados_reg, importance = TRUE, mtry = 4)
model_rf

#View results
summary(model_rf)
importance(model_rf)
varImpPlot(model_rf)

#plot RF importance
imp <- importance(model_rf) %>% as.data.frame() %>% arrange(IncNodePurity)
imp <- imp[order(imp$IncNodePurity, decreasing = T),]
imp
ggplot(imp, aes(x = rownames(imp), y = IncNodePurity)) + geom_bar(stat = "identity")



#Tune SVR
control <- e1071::tune.control(sampling="cross", cross=10)
parametros_svr <- list(epsilon = seq(0,1,0.1), 
                       cost = 2^(0:9),
                       kernel = c("radial","sigmoid") )

model_svr <- tune(svm, rssi ~ ., data = dados_reg, ranges = parametros_svr, tunecontrol = control)
print(model_svr)



###################################################################################################################
################################################  CROSS-VALIDATION   ##############################################
###################################################################################################################

#Error measures table
resultados <- data.frame(modelo = "", cv = 0, cor = 0, rmse = 0, mape = 0)
resultados <- resultados[-1,]


# Cross-validation
k_cv = 10
dados_folds <- createFolds(rownames(dados_reg), k = k_cv, list = T, returnTrain = F)


#Predict values start
predicao <- data.frame(rssi = 0, rf = 0, svr = 0)
predicao <- predicao[-1,]



for (i in 1:k_cv) {  

  #Select dataset
  dados_reg_ml <- dados_reg
  test_index <- dados_folds[i]
  
  #Fold validation
  test_index <- as.data.frame(test_index)
  test_index <- test_index[,1]
  
  #Train and validation
  treinamento <- dados_reg_ml[-test_index,]
  validacao <- dados_reg_ml[test_index,]
  
  #Features and target
  #train
  atributos_treino <- treinamento[,-10]
  saida_treino <- treinamento$rssi
  #validation
  atributos_validacao <- validacao[,-10] 
  saida_validacao <- validacao$rssi
 
  ##ML models
  #Random Forest
  pred_rf <- randomForest(atributos_treino, saida_treino, mtry = 4)
  prx_rf <- predict(pred_rf,atributos_validacao)
  
  resultados <- resultados %>% add_row(modelo = "rf", cv = i,
                                       cor = cor(saida_validacao, prx_rf),
                                       rmse = rmse(saida_validacao, prx_rf),
                                       mape = mape(saida_validacao, prx_rf))
  
  #SVR
  pred_svr <- svm(atributos_treino, saida_treino, epsilon = 0.5, cost = 128, kernel = "radial")
  prx_svr <- predict(pred_svr, atributos_validacao)
  
  resultados <- resultados %>% add_row(modelo = "svr", cv = i,
                                       cor = cor(saida_validacao, prx_svr),
                                       rmse = rmse(saida_validacao, prx_svr),
                                       mape = mape(saida_validacao, prx_svr))
  
  #predicted values
  predicao <- rbind(predicao, data.frame(rssi = saida_validacao, rf = prx_rf, svr = prx_svr))

}

#sort results
resultados <- resultados %>% arrange(modelo, cv)

#results average
resultados_media <- resultados %>% group_by(modelo) %>% 
  summarise(cor = mean(cor), rmse = mean(rmse), mape = mean(mape))


head(resultados_media)
head(resultados)
head(predicao)
