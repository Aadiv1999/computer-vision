function [nms] = nonMaximaSuppressionCanny(dS, dTheta)

[row,col] = size(dS);
nms = zeros(row,col);

for i=2:row-1 
    for j=2:col-1       
        if (dTheta(i,j)>=-22.5 && dTheta(i,j)<=22.5)||(dTheta(i,j)<-157.5 && dTheta(i,j)>=-180)
            if (dS(i,j) >= dS(i,j+1)) && (dS(i,j) >= dS(i,j-1))
                nms(i,j)= dS(i,j);
            else
                nms(i,j)=0;
            end
        elseif (dTheta(i,j)>=22.5 && dTheta(i,j)<=67.5)||(dTheta(i,j)<-112.5 && dTheta(i,j)>=-157.5)
            if (dS(i,j) >= dS(i+1,j+1)) && (dS(i,j) >= dS(i-1,j-1))
                nms(i,j)= dS(i,j);
            else
                nms(i,j)=0;
            end
        elseif (dTheta(i,j)>=67.5 && dTheta(i,j)<=112.5)||(dTheta(i,j)<-67.5 && dTheta(i,j)>=-112.5)
            if (dS(i,j) >= dS(i+1,j)) && (dS(i,j) >= dS(i-1,j))
                nms(i,j)= dS(i,j);
            else
                nms(i,j)=0;
            end
        elseif (dTheta(i,j)>=112.5 && dTheta(i,j)<=157.5)||(dTheta(i,j)<-22.5 && dTheta(i,j)>=-67.5)
            if (dS(i,j) >= dS(i+1,j-1)) && (dS(i,j) >= dS(i-1,j+1))
                nms(i,j)= dS(i,j);
            else
                nms(i,j)=0;
            end
        end
    end
end