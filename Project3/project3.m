function project3
clear all
f = imread('project3/Fig0424(a)(rectangle).tif');
figure,imshow(f);title('original image');
[M, N, ~] = size(f);
wM        = zeros(M, M);
wN        = zeros(N, N);

for u = 0 : (M - 1)
    for x = 0 : (M - 1)
        wM(u+1, x+1) = exp(-2 * pi * 1i / M * x * u);
    end    
end

for v = 0 : (N - 1)
    for y = 0 : (N - 1)
        wN(y+1, v+1) = exp(-2 * pi * 1i / N * y * v);
    end    
end

F = wM * im2double(f) * wN;
fl = log(1 + abs(F));
fm = max(fl(:));
fa = abs(F);
fm = max(fa(:));
ff = fa / fm;
ff_Output = fftshift(ff);
figure,imshow(ff); title('Spectrum');
figure,imshow(ff_Output); title('Contered specturm');
f2 = 1+ log(abs(F));
f2m = max(f2(:));
log_ff = f2/f2m;
log_ff_r = fftshift(log_ff);
figure,imshow(log_ff_r); title('Result showing increased detail after a log transformation');