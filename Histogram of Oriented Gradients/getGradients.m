function [dSX,dSY,dS,dTheta] = getGradients(temp)

temp = im2double(temp);
ixMask = [1,0,-1; 1,0,-1; 1,0,-1];
iyMask = [1,1,1; 0,0,0; -1,-1,-1];
% ixMask = [1,0,-1];
% iyMask = [1; 0; -1];

dSX = convolution2D(temp,ixMask);
dSY = convolution2D(temp,iyMask);

% dSX = conv2(temp,ixMask,'same');
% dSY = conv2(temp,iyMask,'same');


% handle boundary conditions (forward difference)
dSX(:,1)   = temp(:,2)   - temp(:,1);
dSX(:,end) = temp(:,end) - temp(:,end-1);
dSY(1,:)   = temp(2,:)   - temp(1,:);
dSY(end,:) = temp(end,:) - temp(end-1,:);


dS = sqrt(dSX.^2 + dSY.^2);
dTheta = atan2(dSY,dSX).* 180/pi; % in degrees

end