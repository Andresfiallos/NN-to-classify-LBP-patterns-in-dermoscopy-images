%% Extracción de características mediante operador LBP
 
% En este apartado se utilizará la información de los tres canales RGB para
% extraer sus características de textura mediante el operador LBP. Una vez
% extraída esta información esta es almacenada para la creación
% de una base de datos con los datos del operador LBP.
 
%% Preparación del programa
 
clc
clear
close all
 
%% Carga de información extraída de los distintos canales RGB
 
load ('Info_RGB.mat');  
 
%% Extracción de características mediante operador LBP
 
% Para la extracción de datos se ha reutilizado el código creado por Daniel
% Quero. Este ha sido aplicado para cada uno de los canales RGB.
 
[ DataLBP_R , ImageLBP_R] = getLBP(R_G_D);                       % Canal R
[ DataLBP_G , ImageLBP_G] = getLBP(G_G_D);                      % Canal G
[ DataLBP_B , ImageLBP_B] = getLBP(B_G_D);                       % Canal B
 
% Comparativa de las distintas imágenes LBP obtenidas
 
figure
 
subplot(2,3,1) , imshow(R_G)                                                    % Imagen canal R
hold on;
title ('Canal R en escala de grises')
hold off
 
subplot(2,3,2) , imshow(G_G)                                                    % Imagen canal G
hold on;
title ('Canal G en escala de grises')
hold off
 
subplot(2,3,3) , imshow(B_G)                                                    % Imagen canal B
hold on;
title ('Canal B en escala de grises')
hold off
 
subplot(2,3,4) , imshow(ImageLBP_R)                                       % Imagen canal R
hold on;
title ('Imagen LBP - Canal R')
hold off
 
subplot(2,3,5) , imshow(ImageLBP_G)                                       % Imagen canal G
hold on;
title ('Imagen LBP - Canal G')
hold off
 
subplot(2,3,6) , imshow(ImageLBP_B)                                       % Imagen canal B
hold on;
title ('Imagen LBP - Canal B')
hold off
 
%% Concatenación de datos y creación de nueva base de datos
 
DataLBP = cat(2, DataLBP_R, DataLBP_G, DataLBP_B)';           % Concatena datos LBP de 3 canales RGB en una columna 
 
IMD_41 = DataLBP;                                                                       % Define el nombre de columna de datos para base de datos
 
load ('Base_LBP.mat');                                                                  % Carga la base de datos
 
prompt = "Quieres guardar los datos? (1 si - 0 no) ";                  % Pregunta si se desean almacenar los datos
x = input(prompt);                                                                          
 
if x == 1
    
y = isempty(Base_LBP);                                                                 % Define si es el primer elemento de la base de datos
 
if y == 1                                                                                           % Proceso para el primer elemento de la base de datos
    
    Base_LBP = table(IMD_41);
    
elseif y == 0                                                                                   % Proceso si ya existen elementos en la base de datos
    
    Base_LBP = horzcat(Base_LBP , table(IMD_41));
    
end
 
 save Base_LBP Base_LBP                                                          % Guarda el archivo de la nueva base de datos
 
else 
    
    % Indica que los datos no han sido almacenados 
    disp (" ")
    disp ("Datos no guardados en la base de datos de caracteristicas LBP.")          
    
end
 
%% Función creada por Daniel Quero
 
function [ DataLBP , Image_lbp] = getLBP(I_G)
grayImage = I_G;
% Get the dimensions of the image.  numberOfColorBands should be = 1.
[rows , columns , ~] = size(grayImage);
% Preallocate/instantiate array for the local binary pattern.
localBinaryPatternImage1 = zeros(size(grayImage), 'uint8');
localBinaryPatternImage2 = zeros(size(grayImage), 'uint8');
localBinaryPatternImage3 = zeros(size(grayImage), 'uint8');
localBinaryPatternImage4 = zeros(size(grayImage), 'uint8');
localBinaryPatternImage5 = zeros(size(grayImage), 'uint8');
localBinaryPatternImage6 = zeros(size(grayImage), 'uint8');
localBinaryPatternImage7 = zeros(size(grayImage), 'uint8');
localBinaryPatternImage8 = zeros(size(grayImage), 'uint8');
 
for row = 2 : rows - 1
    for col = 2 : columns - 1
        centerPixel = grayImage(row, col);
        pixel7=grayImage(row-1, col-1) > centerPixel;
        pixel6=grayImage(row-1, col) > centerPixel;
        pixel5=grayImage(row-1, col+1) > centerPixel;
        pixel4=grayImage(row, col+1) > centerPixel;
        pixel3=grayImage(row+1, col+1) > centerPixel;
        pixel2=grayImage(row+1, col) > centerPixel;
        pixel1=grayImage(row+1, col-1) > centerPixel;
        pixel0=grayImage(row, col-1) > centerPixel;
        
        % Create LBP image with the starting, LSB pixel in the upper left.
        eightBitNumber = uint8(...
            pixel7 * 2^7 + pixel6 * 2^6 + ...
            pixel5 * 2^5 + pixel4 * 2^4 + ...
            pixel3 * 2^3 + pixel2 * 2^2 + ...
            pixel1 * 2 + pixel0);
        % Or you can use the built-in function bwpack(), which is somewhat simpler but a lot slower.
        %       eightBitNumber = uint8(bwpack([pixel0; pixel1; pixel2; pixel3; pixel4; pixel5; pixel6; pixel7]));
        localBinaryPatternImage1(row, col) = eightBitNumber;
        
        % Create LBP image with the starting, LSB pixel in the upper middle.
        eightBitNumber = uint8(...
            pixel6 * 2^7 + pixel5 * 2^6 + ...
            pixel5 * 2^4 + pixel3 * 2^4 + ...
            pixel3 * 2^2 + pixel1 * 2^2 + ...
            pixel0 * 2 + pixel7);
        % Or you can use the built-in function bwpack(), which is somewhat simpler but a lot slower.
        %       eightBitNumber = uint8(bwpack([pixel0; pixel1; pixel2; pixel3; pixel4; pixel5; pixel6; pixel7]));
        localBinaryPatternImage2(row, col) = eightBitNumber;
        
        % Create LBP image with the starting, LSB pixel in the upper right.
        eightBitNumber = uint8(...
            pixel5 * 2^7 + pixel4 * 2^6 + ...
            pixel3 * 2^5 + pixel2 * 2^4 + ...
            pixel1 * 2^3 + pixel0 * 2^2 + ...
            pixel7 * 2 + pixel6);
        % Or you can use the built-in function bwpack(), which is somewhat simpler but a lot slower.
        %       eightBitNumber = uint8(bwpack([pixel0; pixel1; pixel2; pixel3; pixel4; pixel5; pixel6; pixel7]));
        localBinaryPatternImage3(row, col) = eightBitNumber;
        
        % Create LBP image with the starting, LSB pixel in the center right.
        eightBitNumber = uint8(...
            pixel4 * 2^7 + pixel3 * 2^6 + ...
            pixel2 * 2^5 + pixel1 * 2^4 + ...
            pixel0 * 2^3 + pixel7 * 2^2 + ...
            pixel6 * 2 + pixel5);
        % Or you can use the built-in function bwpack(), which is somewhat simpler but a lot slower.
        %       eightBitNumber = uint8(bwpack([pixel0; pixel1; pixel2; pixel3; pixel4; pixel5; pixel6; pixel7]));
        localBinaryPatternImage4(row, col) = eightBitNumber;
        
        % Create LBP image with the starting, LSB pixel in the lower right.
        eightBitNumber = uint8(...
            pixel3 * 2^7 + pixel2 * 2^6 + ...
            pixel1 * 2^5 + pixel0 * 2^4 + ...
            pixel7 * 2^3 + pixel6 * 2^2 + ...
            pixel5 * 2 + pixel0);
        % Or you can use the built-in function bwpack(), which is somewhat simpler but a lot slower.
        %       eightBitNumber = uint8(bwpack([pixel0; pixel1; pixel2; pixel3; pixel4; pixel5; pixel6; pixel7]));
        localBinaryPatternImage5(row, col) = eightBitNumber;
        
        % Create LBP image with the starting, LSB pixel in the lower center.
        eightBitNumber = uint8(...
            pixel2 * 2^7 + pixel1 * 2^6 + ...
            pixel0 * 2^5 + pixel7 * 2^4 + ...
            pixel6 * 2^3 + pixel5 * 2^2 + ...
            pixel4 * 2 + pixel3);
        % Or you can use the built-in function bwpack(), which is somewhat simpler but a lot slower.
        %       eightBitNumber = uint8(bwpack([pixel0; pixel1; pixel2; pixel3; pixel4; pixel5; pixel6; pixel7]));
        localBinaryPatternImage6(row, col) = eightBitNumber;
        
        % Create LBP image with the starting, LSB pixel in the lower left.
        eightBitNumber = uint8(...
            pixel1 * 2^7 + pixel0 * 2^6 + ...
            pixel7 * 2^5 + pixel6 * 2^4 + ...
            pixel5 * 2^3 + pixel4 * 2^2 + ...
            pixel3 * 2 + pixel2);
        % Or you can use the built-in function bwpack(), which is somewhat simpler but a lot slower.
        %       eightBitNumber = uint8(bwpack([pixel0; pixel1; pixel2; pixel3; pixel4; pixel5; pixel6; pixel7]));
        localBinaryPatternImage7(row, col) = eightBitNumber;
        
        % Create LBP image with the starting, LSB pixel in the center left.
        eightBitNumber = uint8(...
            pixel0 * 2^7 + pixel7 * 2^6 + ...
            pixel6 * 2^5 + pixel5 * 2^4 + ...
            pixel4 * 2^3 + pixel3 * 2^2 + ...
            pixel2 * 2 + pixel1);
        % Or you can use the built-in function bwpack(), which is somewhat simpler but a lot slower.
        %       eightBitNumber = uint8(bwpack([pixel0; pixel1; pixel2; pixel3; pixel4; pixel5; pixel6; pixel7]));
        localBinaryPatternImage8(row, col) = eightBitNumber;
        
    end
end
 
% Outer layer of pixels will be zero because they didn't have 8 neighbors.
% So, to avoid a huge spike in the histogram at zero, replace the outer layer of pixels with the next closest layer.
localBinaryPatternImage1(1, :) = localBinaryPatternImage1(2, :);
localBinaryPatternImage1(end, :) = localBinaryPatternImage1(end-1, :);
localBinaryPatternImage1(:, 1) = localBinaryPatternImage1(:, 2);
localBinaryPatternImage1(:, end) = localBinaryPatternImage1(:, end-1);
 
%*****Devuelvo Valores LBP*******
Image_lbp = localBinaryPatternImage1;
DataLBP= extractLBPFeatures(I_G,'NumNeighbors',8,'Radius',2);
 
end
