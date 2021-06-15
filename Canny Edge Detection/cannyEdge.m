clc
clear
close all

path = "C:\Users\aadiv\Documents\Projects\Computer Vision\images\lena.tif";
% path = "C:\Users\aadiv\Documents\Projects\Computer Vision\images\test2.jpg";
path = "C:\Users\aadiv\Documents\Projects\Computer Vision\images\chessboard.jpg";


img = imread(path);
[row, col, d] = size(img);

gray = rgb2gray(img);

% kernel size
n = 3;
gFilter = fspecial('Gaussian', n, 3);



S = convolution2D(gray,gFilter);
% S = gray;
ixMask = [1,0,-1; 1,0,-1; 1,0,-1];
iyMask = [1,1,1; 0,0,0; -1,-1,-1];
% figure;
% imshow(S,[]);
dSX = convolution2D(S,ixMask);
dSY = convolution2D(S,iyMask);

figure;
subplot(1,2,1);
imshow(dSX,[]);
title("Magnitudes in X");
subplot(1,2,2);
imshow(dSY,[]);
title("Magnitudes in Y");

dS = sqrt(dSX.^2 + dSY.^2);
dTheta = atan2(dSY,dSX).*180/pi;


% imshow(dS,[]);
% title("Gradient Magnitude");


% non maxima suppression
nms = nonMaximaSuppressionCanny(dS,dTheta);


% figure
% imshow(nms,[]);
% title("Non Maxima Suppression");


% get weak edges
[thresh,weakEdges,strongEdges] = getWeakEdges(nms, 5, 20);


% figure
% imshow(thresh,[]);
% title("Double Thresholding");


% get connected edges
set(0,'RecursionLimit',100000)
for i=1:length(strongEdges)
    if( (strongEdges(i,1)>1 && strongEdges(i,2)>1) &&...
        (strongEdges(i,1)<row && strongEdges(i,2)<col) )
        
        thresh = getConnectedEdges(thresh,strongEdges(i,1),strongEdges(i,2));

    end
end

hLinked = thresh;

for i=1:length(weakEdges)
    if(hLinked(weakEdges(i,1),weakEdges(i,2)) ~= 255)
        hLinked(weakEdges(i,1),weakEdges(i,2)) = 0;
    end
end

figure;
subplot(1,2,1)
imshow(img,[]);
title("Original Image");
subplot(1,2,2)
imshow(hLinked,[]);
title("Canny Edge Detector");


% uncomment to compare with the MATLAB Function
% figure
% imshow(edge(gray,'canny'));
% title("Canny");













