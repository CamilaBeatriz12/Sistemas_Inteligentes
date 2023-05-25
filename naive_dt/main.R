source("/Windows Sistema/Documentos/Sistemas Inteligentes/naive_dt/naive.R")

library(readr)
library(dplyr)
library(rsample)
library(tidyr)
library(ggplot2, warn.conflicts=FALSE)
library(tidymodels)
library(themis) #Recipe functions to deal with class imbalances
#2 bib novas
library(e1071)
library(caTools)


diabetes <- read_csv("/Windows Sistema/Documentos/Sistemas Inteligentes/naive_dt/diabetes.csv")
#View(diabetes)
#head(diabetes)
#dim(diabetes)

#diabetes$Outcome <- as.factor(diabetes$Outcome)

#diab_split <- initial_split(diabetes, prop = 0.8, strata = Outcome)
#diab_recipe <- recipe( Outcome ~ ., data = training(diab_split)) %>% 
#step_normalize(all_numeric_predictors())%>%
#step_smote(Outcome)

#diab_train <- diab_recipe %>% prep() %>% bake(new_data = NULL)
#diab_test <- diab_recipe %>% prep() %>% bake(testing(diab_split))

#for (h in 1:nrow(diab_test)) {
#  preds = naiveBayes(dataset = data.frame(diab_train[,-1]), sample = diab_test[h,-1])
#  if(h == 1) print(preds$possible_hyp)
#  cat(preds$answers, "\n\n")
#}

colnames(diabetes)=c('Pregnancies','Glucose','BloodPressure','SkinThickness','Insulin','BMI',
                     'DiabetesPedigreeFunction','Age','Outcome')


diabetes$Outcome = factor(diabetes$Outcome,levels = c(1,2))


divisao = sample.split(diabetes$Outcome, SplitRatio = 0.75)

base_treinamento = subset(diabetes,divisao==TRUE)
base_teste = subset(diabetes,divisao==FALSE)


classificador = naiveBayes(dataset = base_treinamento[-1], sample = base_teste$Outcome)
print(classificador)

previsao = predict(classificador,newdata = base_teste[-1])
print(previsao)