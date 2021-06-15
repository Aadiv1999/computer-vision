clc
close all;

path = "C:\Users\aadiv\Documents\Projects\Computer Vision\images\test2.jpg";


img = imread(path);
img = imresize(img,[128,64]);

gray = rgb2gray(img);
[row,col] = size(gray);


[dSX,dSY,dS,dTheta] = getGradients(gray);



rowNum = 1;
colNum = 1;
vector = {};

for i=1:8:row
    colNum = 1;
    for j=1:8:col
        dSTemp = dS([i:i+7],[j:j+7]);
        dThetaTemp = dTheta([i:i+7],[j:j+7]);
%         [dSX,dSY,dS,dTheta] = getGradients(temp);
        vector{rowNum,colNum} = getVector(dSTemp,dThetaTemp);
        colNum = colNum + 1;
    end
    rowNum = rowNum + 1;
end

hogVector = [];

for i=1:15
    for j=1:7
        tempVector = [vector{i,j},vector{i,j+1},...
                        vector{i+1,j},vector{i+1,j+1}];
        tempVector = tempVector / sqrt(norm(tempVector)^2 + 0.0001);
        hogVector = [hogVector,tempVector];
    end
end


hogVector = hogVector / sqrt(norm(hogVector)^2 + 0.0001);

thresh = 0.018;
for i=1:length(hogVector)
    hogVector(i) = min(hogVector(i),thresh);
end

hogVector = hogVector / sqrt(norm(hogVector)^2 + 0.0001);




figure
subplot(1,2,1)
imshow(img);
title("Original (Resized) Image")
subplot(1,2,2)
imshow(zeros(row,col));hold on;


count = 1;
for i=1:8
    for j=1:16
        plotVectors([i*8-4,j*8-4],50*hogVector([(count-1)*9+1:count*9]));
        hold on;
        rowNum = rowNum + 1;
        count = count + 1;
    end
end
title("Visualisation");



