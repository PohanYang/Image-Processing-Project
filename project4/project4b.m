function project4b
clear all;
img = load('project4/project4bimg.txt');
[H W] = size(img);
inwavelet1 = zeros(H,W);
for i=0:H/8-1
    for j=0:W/4-1
        inwavelet1(2*i+1,j+1) = (2*img(i+1,j+1)+img(floor(H/8)+i+1, j+1))/2;
        inwavelet1(2*i+2,j+1) = (2*img(i+1,j+1)-img(floor(H/8)+i+1, j+1))/2;
    end
end
img(1:floor(H/4),1:floor(W/4)) = inwavelet1(1:floor(H/4),1:floor(W/4));
for i=0:W/4-1
    for j=0:H/8-1
        inwavelet1(i+1,2*j+1) = (2*img(i+1,j+1)+img(i+1, floor(W/8)+j+1))/2;
        inwavelet1(i+1,2*j+2) = (2*img(i+1,j+1)-img(i+1, floor(W/8)+j+1))/2;
    end
end
img(1:H/4,1:W/4) = inwavelet1(1:H/4,1:W/4);

for i=0:H/4-1
    for j=0:W/2-1
        inwavelet1(2*i+1,j+1) = (2*img(i+1,j+1)+img(floor(H/4)+i+1, j+1))/2;
        inwavelet1(2*i+2,j+1) = (2*img(i+1,j+1)-img(floor(H/4)+i+1, j+1))/2;
    end
end
img(1:floor(H/2),1:floor(W/2)) = inwavelet1(1:floor(H/2),1:floor(W/2));
for i=0:W/2-1
    for j=0:floor(H/4)-1
        inwavelet1(i+1,2*j+1) = (2*img(i+1,j+1)+img(i+1, floor(W/4)+j+1))/2;
        inwavelet1(i+1,2*j+2) = (2*img(i+1,j+1)-img(i+1, floor(W/4)+j+1))/2;
    end
end
img(1:floor(H/2),1:floor(W/2)) = inwavelet1(1:floor(H/2),1:floor(W/2));

for i=0:H/2-1
    for j=0:W-1
        inwavelet1(2*i+1,j+1) = (2*img(i+1,j+1)+img(floor(H/2)+i+1, j+1))/2;
        inwavelet1(2*i+2,j+1) = (2*img(i+1,j+1)-img(floor(H/2)+i+1, j+1))/2;
    end
end
img = inwavelet1;
for i=0:W-1
    for j=0:H/2-1
        inwavelet1(i+1,2*j+1) = (2*img(i+1,j+1)+img(i+1, floor(W/2)+j+1))/2;
        inwavelet1(i+1,2*j+2) = (2*img(i+1,j+1)-img(i+1, floor(W/2)+j+1))/2;
    end
end
img = inwavelet1;
figure, imshow(img);title('inverse image')