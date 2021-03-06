function [thresh,weakEdges,strongEdges] = getWeakEdges(nms, lowThresh, highThresh)

thresh = nms;
[row,col] = size(nms);
weakEdges = [];
strongEdges = [];
for i=1:row
    for j=1:col
        if( nms(i,j) >= highThresh)
            thresh(i,j) = 255;
            strongEdges = [strongEdges;i,j];
        elseif( nms(i,j) <= lowThresh)
            thresh(i,j) = 0;
        else
            weakEdges = [weakEdges;i,j];
        end
    end
end





end