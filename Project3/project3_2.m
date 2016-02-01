function project3_2
clear all;
I=imread('project3/Fig0459(a)(orig_chest_xray).tif');
figure,imshow(I); title('Original');

%% Gaussian highpass
G = fspecial('gaussian',[5 5],2);
Ig = imfilter(I,G);
figure,imshow(Ig,[  ]); title('(b)highpass filtering with a Gaussian filter');

%% high frequency-emphasis
[f1,f2] = freqspace(size(I), 'meshgrid' );
D = sqrt(f1.^2 + f2.^2);
H_b=1./((1+0.1./D).^2);  %Butterworth high-pass filter
H_em=0.5+0.75*H_b; %High frequency emphasis filter
H_em=ifftshift(H_em);
I_f=fft2(I);
I_f=I_f.*H_em;
I2=uint8(ifft2(I_f));
figure,imshow(I2, []); title('(c)Result of high-frequency-emphasis filtering using the same filter');

%% histogram equlization
figure,histeq(I2); title('(d)Result of performing histogram equalization on (c)');
