clc
% clear
close all;

% path = "C:\Users\aadiv\Documents\Projects\Computer Vision\images\corners.jpg";
path = "C:\Users\aadiv\Documents\Projects\Computer Vision\images\corners.png";
path = "C:\Users\aadiv\Documents\Projects\Computer Vision\images\chessboard.jpg";


img = imread(path);

[row,column,d] = size(img);
columnFixed = 600;
rowNew = floor(columnFixed * (row/column));
img = imresize(img,[rowNew,columnFixed]);

gray = rgb2gray(img);
level = 0.5;
bw = imbinarize(gray,level)*255;

ixMask = [1,0,-1; 2,0,-2; 1,0,-1];
iyMask = [1,2,1; 0,0,0; -1,-2,-1];

% you dont see the complete lines coz their value becomes -ve when
% convolved with the kernel. This is taken care of while squaring

iX = convolution2D(bw, ixMask);
iY = convolution2D(bw, iyMask);

% iX = bwareaopen(iX,50)*255;
% iY = bwareaopen(iY,50)*255;

figure;
subplot(1,3,1)
imshow(bw,[]);
title("Thresholding");
subplot(1,3,2)
imshow(iX,[]);
title("X Mask");
subplot(1,3,3)
imshow(iY,[]);
title("Y Mask");

% get derivative products
iX2 = iX .* iX;
iY2 = iY .* iY;

iXY = iX .* iY;

% window 
n = 15;

[r,c] = size(gray);
k = 0.04; % harris K
thresh = 500000000; % harris thresh
gFilter = fspecial('Gaussian', n, 1);
R = 0;
wX2 = convolution2D(iX2, gFilter)*255;
wY2 = convolution2D(iY2, gFilter)*255;
wXY = convolution2D(iXY, gFilter)*255;

corners = [];

for i = 1:r
    for j=1:c
        
        mat = [wX2(i,j),wXY(i,j); wXY(i,j),wY2(i,j)];
        R = det(mat) - k*trace(mat)^2;
        if(thresh < R)
            corners = [corners;i,j];
        end
    end
end



gaussMat = [];
for i=1:n
    for j=1:n
        gaussMat = [gaussMat;i, j, gFilter(i,j)];
    end
end
figure;
[x,y] = meshgrid(1:n,1:n);

% visualise Gaussain Mask
surf(x,y,gFilter);hold on;shading interp;

figure;
subplot(1,2,1)
imshow(img);
axis on;
title("Original Image");
subplot(1,2,2)
imshow(img);hold on;
plot(corners(:,2),corners(:,1),'+','Color','r');
title("Harris Corner Detection");
axis on;

