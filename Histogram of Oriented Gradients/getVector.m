function [vector] = getVector(dS,dTheta)

[row,col] = size(dTheta);

vector = zeros(1,9);

for i=1:row
    for j=1:col
        if(dTheta(i,j) < 0)
            angle = dTheta(i,j) + 180;
        else
            angle = dTheta(i,j);
        end
        
        if angle>10 && angle<=30
            vector(1)=vector(1)+ dS(i,j)*(30-angle)/20;
            vector(2)=vector(2)+ dS(i,j)*(angle-10)/20;
        elseif angle>30 && angle<=50
            vector(2)=vector(2)+ dS(i,j)*(50-angle)/20;                 
            vector(3)=vector(3)+ dS(i,j)*(angle-30)/20;
        elseif angle>50 && angle<=70
            vector(3)=vector(3)+ dS(i,j)*(70-angle)/20;
            vector(4)=vector(4)+ dS(i,j)*(angle-50)/20;
        elseif angle>70 && angle<=90
            vector(4)=vector(4)+ dS(i,j)*(90-angle)/20;
            vector(5)=vector(5)+ dS(i,j)*(angle-70)/20;
        elseif angle>90 && angle<=110
            vector(5)=vector(5)+ dS(i,j)*(110-angle)/20;
            vector(6)=vector(6)+ dS(i,j)*(angle-90)/20;
        elseif angle>110 && angle<=130
            vector(6)=vector(6)+ dS(i,j)*(130-angle)/20;
            vector(7)=vector(7)+ dS(i,j)*(angle-110)/20;
        elseif angle>130 && angle<=150
            vector(7)=vector(7)+ dS(i,j)*(150-angle)/20;
            vector(8)=vector(8)+ dS(i,j)*(angle-130)/20;
        elseif angle>150 && angle<=170
            vector(8)=vector(8)+ dS(i,j)*(170-angle)/20;
            vector(9)=vector(9)+ dS(i,j)*(angle-150)/20;
        elseif angle>=0 && angle<=10
            vector(1)=vector(1)+ dS(i,j)*(angle+10)/20;
            vector(9)=vector(9)+ dS(i,j)*(10-angle)/20;
        elseif angle>170 && angle<=180
            vector(9)=vector(9)+ dS(i,j)*(190-angle)/20;
            vector(1)=vector(1)+ dS(i,j)*(angle-170)/20;
        end
    end
end

if(sum(vector)==0)
    vector(4) = 1;
    vector(5) = 1;
end



% normalise the vector
vector = vector / sqrt(norm(vector)^2 + 0.0001);

% References
% ----------
% Sanyam Garg (2021). Histogram of Oriented Gradients (HOG) code using Matlab
% (https://www.mathworks.com/matlabcentral/fileexchange/46408-histogram-of-oriented-gradients-hog-code-using-matlab),
% MATLAB Central File Exchange. Retrieved June 15, 2021.

end