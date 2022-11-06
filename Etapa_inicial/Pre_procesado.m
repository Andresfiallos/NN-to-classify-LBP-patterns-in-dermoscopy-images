%% Pre-Procesado
 
% En este apartado se preparan las imágenes dermatoscópicas para su
% posterior procesamiento y extracción de información.
 
%% Preparación del programa
 
clc
clear
close all
 
%% Importar de imágenes medicas en formato *.bmp
 
[filename,pathname] = uigetfile({'*.bmp'});
I = imread(fullfile(pathname, filename));                   % Importar de imagen médica a ser utilizada
 
%% Recortar imagen medica 
 
% Se recorta la imagen médica para eliminar los bordes negros presentes
% debido al dermatoscopio utilizado.
 
ventana = [80 14 590 550];                                     % Vector con valores que definen la ventana 
Icrp = imcrop(I,ventana);                                          % Imagen recortada que será utilizada
 
% Comparativa de Imagen original con Imagen recortada
 
figure
subplot(2,2,1) , imshow(I);                                         % Imagen original
hold on;
title ('Imagen Original')
hold off
 
subplot(2,2,2) , histogram(I);                                     % Histograma de imagen original 
hold on;
title ('Histograma de Imagen Original')
ylabel('Número de Pixeles')
xlabel('Valor de los pixeles')
grid on, grid minor
hold off
 
subplot(2,2,3) , imshow(Icrp);                                   % Imagen recortada
hold on;
title ('Imagen Recortada')
hold off
 
subplot(2,2,4) , histogram(Icrp);                               % Histograma de imagen recortada
hold on;
title ('Histograma de Imagen Recortada')
ylabel('Número de Pixeles')
xlabel('Valor de los pixeles')
grid on, grid minor
hold off
 
%% Extracción de información de los tres canales RGB
 
% En esta sección se extrae la información de cada uno de los canales RGB y
% se la almacena para poder utilizarla posteriormente.
 
Img = Icrp;                                                                 % Definir imagen recortada como Img
 
% Extraer datos de canal Red (Rojo)
R = Img;                                                                     % Definir variable canal R
R(:,:,2) = 0; R(:,:,3) = 0;                                            % Eliminar información de canales G y B
R_G = rgb2gray(R);                                                  % Transformar a escala de Grises
R_G_D = im2double(R_G);                                      % Transformación de formato Imagen a numérico de doble precisión
 
% Extraer datos de canal Green (Verde)
G = Img;                                                                    % Definir variable canal G                                                                     
G(:,:,1) = 0; G(:,:,3) = 0;                                            % Eliminar información de canales R y B  
G_G = rgb2gray(G);                                                  % Transformar a escala de Grises
G_G_D = im2double(G_G);                                      % Transformación de formato Imagen a numérico de doble precisión
 
% Extraer datos de canal Blue (Azul)
B = Img;                                                                    % Definir variable canal B                                                            
B(:,:,1) = 0; B(:,:,2) = 0;                                            % Eliminar información de canales R y G
B_G = rgb2gray(B);                                                  % Transformar a escala de Grises
B_G_D = im2double(B_G);                                      % Transformación de formato Imagen a numérico de doble precisión
 
% Comparativa de datos de los diferentes canales RGB
 
figure
subplot(2,3,1) , imshow(R);                                     % Graficar canal R    
hold on;
title ('Canal R')
hold off
 
subplot(2,3,2) , imshow(G);                                     % Graficar canal G    
hold on;
title ('Canal G')
hold off
 
subplot(2,3,3) , imshow(B);                                     % Graficar canal B    
hold on;
title ('Canal B')
hold off
 
subplot(2,3,4) , imshow(R_G);                                  % Graficar canal R en escala de grises    
hold on;
title ('Canal R - escala de grises')
hold off
 
subplot(2,3,5) , imshow(G_G);                                  % Graficar canal G en escala de grises    
hold on;
title ('Canal G - escala de grises')
hold off
 
subplot(2,3,6) , imshow(B_G);                                  % Graficar canal B en escala de grises    
hold on;
title ('Canal B - escala de grises')
hold off

%% Almacenar informacion relevante

save Info_RGB R G B R_G G_G B_G R_G_D G_G_D B_G_D

