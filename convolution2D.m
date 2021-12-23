function [outImage] = convolution2D(input, kernel)

% kernel must be a matrix with odd dimensions
% zero padding will be done after which the edge values are calculated

[rm, cm] = size(kernel);


padCol = floor(cm/2);
padRow = floor(rm/2);
input = padarray(input,[padRow,padCol],'both');

[row, column] = size(input);
outImage = zeros(row,column);

for i=padRow+1:row-padRow
    for j=padCol+1:column-padCol
        for k= -padRow:1:padRow
            for g=-padCol:1:padCol
                
                outImage(i,j) = outImage(i,j)+kernel(padRow+1+k,padCol+1+g)*input(i+k,j+g);
                
            end
        end
    end

end

outImage = outImage([padRow+1:row-padRow],...
    [padCol+1:column-padCol]);









