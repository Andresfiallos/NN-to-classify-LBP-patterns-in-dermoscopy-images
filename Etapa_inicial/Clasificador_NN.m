%% Clasificador mediante red neuronal

% En este apartado se utilizara la base de datos de caracteristicas LBP
% previamente generada para entrenar el clasificador y validarlo. Los datos
% obtenidos seran submuestreados en dos sets (entrenamiento y validacion).

%% Preparación del programa

clear
clc
close all

%% Carga de Base de datos

% La base de datos generada cuenta con un set de datos de 180 observaciones
% destinadas para entrenamiento y 20 observaciones para validacion del
% modelo entrenado. Estos sets de datos se han generado de acuerdo al
% metodo de submuestreo del metodo de validacion K-Fold, para k = 10. La
% base cuenta con 177 caracteristicas LBP y 3 caracteristicas que
% determinan el diagnostico de cada una de las imagenes. 

load ('Base_LBP_Modelo.mat')

%% Definir datos que seran usados para entrenamiento de la red neuronal

% Datos de Entrenamiento

Inputs = table2array(Base_train(1:177,:));                                           % Extraccion de caracteristicas LBP
Targets = table2array(Base_train(178:180,:));                                    % Extraccion del diagnostico de cada Imagen

% Datos de Validacion

Val = table2array(Base_test(1:177,:));                                             % Extraccion de caracteristicas LBP para validacion                 
Target_val = table2array(Base_test(178:180,:));                            % Extraccion del diagnostico para generar matriz de confusion

% Datos totales

Val_tot = table2array(Base_LBP_total(1:177,:));                                             % Extraccion de caracteristicas LBP de todas las observaciones
Target_val_tot = table2array(Base_LBP_total(178:180,:));                            % Extraccion del diagnostico para generar matriz de confusion

%% Definicion de parametros de la red neuronal

hiddenLayerSize = [150 150 150];                                                   % Se define el numero de capas ocultas y neuronas presentes en cada una    
net = patternnet(hiddenLayerSize);                                                  % Red neuronal con 3 capas ocultas con 150 neuronas cada una

% Las redes neuronales utilizan por defecto una division de datos para
% utilizaros en validacion y prueba. Sin embago debido que generan los
% grupos de manera random hemos realizado la division previamente

net.divideParam.trainRatio = 100/100;                            % Se usara el 100% de los datos previamente definidos Inputs
net.divideParam.valRatio = 0/100;                                   % No se usa la herramienta de division de datos para validacion
net.divideParam.testRatio = 0/100;                                  % No se usa la herramienta de division de datos para prueba

[net,tr] = train(net,Inputs, Targets);                                   % Se entrena la red neuronal

%% Validacion de modelo entrenado con datos de validacion

Output_val = net(Val);                                                      % Se pide al modelo la clasificacion de los datos destinados para validacion
figure
plotconfusion(Target_val,Output_val)                             % Se genera la matriz de confusion de acuerdo al resultado obtenido

%% Se prueba el modelo con los datos de todas las observaciones

Output_val_tot = net(Val_tot);                                                      % Se pide al modelo la clasificacion de los datos destinados para validacion
figure
plotconfusion(Target_val_tot,Output_val_tot)                             % Se genera la matriz de confusion de acuerdo al resultado obtenido


