function plotVectors(org, vector)

count = 1;

for i=0:20:160
    rotMatrix = [cosd(i),-sind(i);sind(i),cosd(i)];
    
%     point1 = [vector(count)+vector(2*count)+vector(3*count)+vector(4*count);0];
    point1 = [vector(count);0];
    point2 = [-vector(count);0];
%     point2 = [-(vector(count)+vector(2*count)+vector(3*count)+vector(4*count));0];
    count = count + 1;
    
    point1 = rotMatrix * point1;
    point2 = rotMatrix * point2;
    
    plot([point2(1),point1(1)]+org(1),[point2(2),point1(2)]+org(2),'Color',[1,1,1]);hold on;

end