function project1_bicubic

clear all;
fig=imread('Fig0236(a)(letter_T).tif');%讀圖
[height1 width1 d] = size(fig);%獲取圖片大小

cut_size(1) = height1/1;%shear剪裁比例
cut_size(2) = width1/1;%shear剪裁比例

c_fig = fig(1:cut_size(1),1:cut_size(2));
clear fig;
fig=c_fig;
%
m_fig = size(fig);
height1 = m_fig(1);
width1 = m_fig(2);
zoom_in_scale = 10 ;%縮小比例
height1=height1-1;
width1=width1-1;

if zoom_in_scale~=0
    for v=1:zoom_in_scale:height1
        for w=1:zoom_in_scale:width1
            s_fig(((v-1)/zoom_in_scale)+1,((w-1)/zoom_in_scale)+1)= fig(v,w);%利用迴圈取出矩陣中的px,放到新的矩陣中
        end
    end
    clear fig;
    fig = s_fig;
end
%
[r c d] = size(fig);

zoom = 10; %放大比例

rn = floor(zoom*r);
cn = floor(zoom*c);
s = zoom;
im_zoom = cast(zeros(rn,cn,d),'uint8');
im_pad = zeros(r+4,c+4,d);
im_pad(2:r+1,2:c+1,:) = fig;
im_pad = cast(im_pad,'double');
for m = 1:rn
    x1 = ceil(m/s); x2 = x1+1; x3 = x2+1;
    p = cast(x1,'uint16');
    if(s>1)
       m1 = ceil(s*(x1-1));
       m2 = ceil(s*(x1));
       m3 = ceil(s*(x2));
       m4 = ceil(s*(x3));
    else
       m1 = (s*(x1-1));
       m2 = (s*(x1));
       m3 = (s*(x2));
       m4 = (s*(x3));
    end
    X = [ (m-m2)*(m-m3)*(m-m4)/((m1-m2)*(m1-m3)*(m1-m4)) ...
          (m-m1)*(m-m3)*(m-m4)/((m2-m1)*(m2-m3)*(m2-m4)) ...
          (m-m1)*(m-m2)*(m-m4)/((m3-m1)*(m3-m2)*(m3-m4)) ...
          (m-m1)*(m-m2)*(m-m3)/((m4-m1)*(m4-m2)*(m4-m3))];
    for n = 1:cn
        y1 = ceil(n/s); y2 = y1+1; y3 = y2+1;
        if (s>1)
           n1 = ceil(s*(y1-1));
           n2 = ceil(s*(y1));
           n3 = ceil(s*(y2));
           n4 = ceil(s*(y3));
        else
           n1 = (s*(y1-1));
           n2 = (s*(y1));
           n3 = (s*(y2));
           n4 = (s*(y3));
        end
        Y = [ (n-n2)*(n-n3)*(n-n4)/((n1-n2)*(n1-n3)*(n1-n4));...
              (n-n1)*(n-n3)*(n-n4)/((n2-n1)*(n2-n3)*(n2-n4));...
              (n-n1)*(n-n2)*(n-n4)/((n3-n1)*(n3-n2)*(n3-n4));...
              (n-n1)*(n-n2)*(n-n3)/((n4-n1)*(n4-n2)*(n4-n3))];
        q = cast(y1,'uint16');
        sample = im_pad(p:p+3,q:q+3,:);
        im_zoom(m,n,1) = X*sample(:,:,1)*Y;
        if(d~=1)
              im_zoom(m,n,2) = X*sample(:,:,2)*Y;
              im_zoom(m,n,3) = X*sample(:,:,3)*Y;
        end
    end
end
clear fig;
fig = cast(im_zoom,'uint8');
%
[height1 width1 d] = size(fig);%獲取圖片大小
angle = 0;%設定順時針旋轉角度
if angle~=0
    angle = 360-angle;
    pi=3.1415926;
    angle = angle*(pi/180);
    height3 = height1*sqrt(2.0);
    width3 = width1*sqrt(2.0);
    cy1 = height1/2;
    cx1 = width1/2;
    cy3 = height3/2;
    cx3 = width3/2;
    for o=1:height1
        for p=1:width1
            long = floor(((p-cx3)*cos(angle)+(o-cy3)*sin(angle))+cx1);
            short = floor((-(p-cx3)*sin(angle)+(o-cy3)*cos(angle))+cy1);
            while long<=0
                long=long+1;
            end
            while short<=0
                short=short+1;
            end
            r_fig(short,long)=fig(o,p);
        end
    end
    
    for o=1:height1
        for p=1:width1
            long = ceil(((p-cx3)*cos(angle)+(o-cy3)*sin(angle))+cx1);
            short = ceil((-(p-cx3)*sin(angle)+(o-cy3)*cos(angle))+cy1);
            while long<=0
                long=long+1;
            end
            while short<=0
                short=short+1;
            end
            r_fig(short,long)=fig(o,p);
        end
    end
    
    clear fig;
    fig = r_fig;
end

%
move = 0 ; %往右位移pixel
[height1 width1 d] = size(fig);
block_1 = uint8(zeros(height1,width1));
background_1(height1 ,1:move) = fig(1,1);
block_1(:, 1:move) = background_1;
block_1(: ,move+1:width1) = fig(:, 1:width1-move);
clear fig;
fig = block_1;
%
imwrite(fig, 'project1_bicubic.tif','tif');  
imshow(fig)
