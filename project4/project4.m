function project4
clear all;
lena = imread('project4/Fig0809(a).tif');
figure, imshow(lena); title('original image')
lena = im2double(lena);
[h w] = size(lena);
wavelet1 = zeros(w,h);wavelet2 = zeros(w,h);wavelet3 = zeros(w,h);
wavelet4 = zeros(w,h);wavelet5 = zeros(w,h);wavelet6 = zeros(w,h);
for i=0:h-1
    for j=0:w/2-1
        wavelet1(i+1,j+1) = (lena(i+1,j*2+1)+lena(i+1,j*2+2))/2;
        wavelet1(i+1,floor(w/2)+j+1) = lena(i+1,j*2+1)-lena(i+1,j*2+2);
    end
end

for i=0:w/2-1
    for j=0:h-1
        wavelet2(i+1,j+1) = (wavelet1(i*2+1,j+1)+wavelet1(i*2+2,j+1))/2;
        wavelet2(floor(h/2)+i+1,j+1) = wavelet1(i*2+1,j+1)-wavelet1(i*2+2,j+1);
    end
end
wavelet4 = wavelet2;
for i=0:h/2-1
    for j=0:w/4-1
        wavelet3(i+1,j+1) = (wavelet2(i+1,j*2+1)+wavelet2(i+1,j*2+2))/2;
        wavelet3(i+1,floor(w/4)+j+1) = wavelet2(i+1,j*2+1)-wavelet2(i+1,j*2+2);
    end
end

for i=0:w/4-1
    for j=0:h/2-1
        wavelet4(i+1,j+1) = (wavelet3(i*2+1,j+1)+wavelet3(i*2+2,j+1))/2;
        wavelet4(floor(h/4)+i+1,j+1) = wavelet3(i*2+1,j+1)-wavelet3(i*2+2,j+1);
    end
end
wavelet6 = wavelet4;
for i=0:h/4-1
    for j=0:w/8-1
        wavelet5(i+1,j+1) = (wavelet4(i+1,j*2+1)+wavelet4(i+1,j*2+2))/2;
        wavelet5(i+1,floor(w/8)+j+1) = wavelet4(i+1,j*2+1)-wavelet4(i+1,j*2+2);
    end
end

for i=0:w/8-1
    for j=0:h/4-1
        wavelet6(i+1,j+1) = (wavelet5(i*2+1,j+1)+wavelet5(i*2+2,j+1))/2;
        wavelet6(floor(h/8)+i+1,j+1) = wavelet5(i*2+1,j+1)-wavelet5(i*2+2,j+1);
    end
end
save project4/project4bimg.txt wavelet6 -ascii
temp = wavelet6(1:w/8,1:h/8);
[m n]=find(wavelet6==min(min(wavelet6)));
wavelet6 = wavelet6+(-wavelet6(m,n));
wavelet6(1:w/8,1:h/8) = temp;
%imwrite(wavelet6,'project4/project4b.png');
figure,imshow(wavelet6);title('Haar wavelet');