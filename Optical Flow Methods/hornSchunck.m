clc
clear
close all;

vidReader = VideoReader('visiontraffic.avi','CurrentTime',15);

fx1 = [-1,0,1;-1,0,1;-1,0,1];
fx2 = [-1,0,1;-1,0,1;-1,0,1];

fy1 = [-1,-1,-1;0,0,0;1,1,1];
fy2 = [-1,-1,-1;0,0,0;1,1,1];

ft1 = -1*ones(3);
ft2 = ones(3);
avg = [1/12 1/6 1/12;1/6 0 1/6;1/12 1/6 1/12];
iterations = 3;
L = 1;

figure
for f=320:vidReader.NumFrames

    frameRGB1 = imresize(read(vidReader,f),0.5);
    frameRGB2 = imresize(read(vidReader,f+1),0.5);
    frame1 = im2gray(frameRGB1);
    frame2 = im2gray(frameRGB2);
    diff = frame2 - frame1;
    
    u = zeros(size(frame1));
    v = zeros(size(frame1));
    disp(f);
    disp(mean(diff(:)))
    if(mean(diff(:)) >= 0.75)
    
        fx = 0.5*(convolution2D(frame1,fx1) + convolution2D(frame2,fx2));
        fy = 0.5*(convolution2D(frame1,fy1) + convolution2D(frame2,fy2));
        ft = convolution2D(frame1,ft1) + convolution2D(frame2,ft2);

        for i=1:iterations
            uavg = convolution2D(u,avg);
            vavg = convolution2D(v,avg);
            P = (fx .* uavg + fy .* vavg + ft);
            D = (fy.^2 + fx.^2 + L);

            u = uavg - fx.*(P./D);
            v = vavg - fy.*(P./D);
        end
        

        thresh = 0.5;
        u(abs(u)<=thresh) = 0;
        v(abs(v)<=thresh) = 0;

        rSize = 20;
        for i=1:size(u,1)
            for j=1:size(u,2)
                if floor(i/rSize)~=i/rSize || floor(j/rSize)~=j/rSize
                    u(i,j)=0;
                    v(i,j)=0;
                end
            end
        end
    end
    
    imshow(frameRGB1);hold on;
    quiver(u, -v, 40, 'color', 'b', 'linewidth', 2);
    hold off;
    
end

