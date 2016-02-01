function project3_3
clear all
f = imread('project3/Fig0516(a)(applo17_boulder_noisy).tif');
figure,imshow(f);title('original image');
ff = fft2(f);

%F = wM * im2double(f) * wN;
fl = log(1 + abs(ff));
fm = max(fl(:));
fa = abs(ff);
fm = max(fa(:));
ffe = fa / fm;
ff_Output = fftshift(ffe);
figure,imshow(ff_Output, []); title('specturm');

[nx ny]=size(f);
I=f(nx:-1:1,:);
u=I;
c=1;
gamma=2;
f_fp=255*c*(u/255).^gamma;
u = f_fp;
fftu = fft2(u,2*nx-1,2*ny-1);
fftu = fftshift(fftu);
%figure,imshow(log(1+(abs(fftu))));
filter=ones(2*nx-1,2*ny-1);
d0=400; n=2; w=20;
for i=1:2*nx-1
    for j=1:2*ny-1
        dist=((i-nx)^2+(j-ny)^2)^.5;
        if dist ~= d0
            filter(i,j)=1/(1+(dist*w/(dist^2-d0^2))^(2*n));
        else
            filter(i,j)=0;
        end
    end
end

fil=filter.*fftu;
fil=ifftshift(fil);
fil=ifft2(fil,2*nx-1,2*ny-1);
fil=real(fil(1:nx,1:ny));
fil=uint8(fil);
rr=filter2(filter, f);
figure,imshow(filter);title('butterworth band-reject filter');
figure,imshow(rr,[]);title('result');