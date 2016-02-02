function project1_bilinear

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
[height1 width1 d] = size(fig);

scale_h = 10; %放大比例
scale_w = scale_h;
height2 = height1*scale_h;
width2 = width1*scale_w;
l_fig = uint8(zeros(height2,width2));
height1=height1-1;
width1=width1-1;

for j=0:height1
    for i=0:width1
        l_fig(ceil(1+j*scale_h),ceil(1+i*scale_w)) = fig(1+j,1+i);
    end
end
clear fig;
fig = l_fig;


for b=1:height2-scale_h
    for a=1:width2-scale_w
        x1 = scale_h*(floor((b-1)/scale_h))+1; 
        y1 = scale_w*(floor((a-1)/scale_w))+1;
        x2 = scale_h*(ceil(b/scale_h))+1;
        y2 = scale_w*(ceil(a/scale_w))+1;
        z1 = fig(x1, y1);  z2 = fig(x1, y2); z3= fig(x2, y1); z4 = fig(x2, y2);%找出相鄰的四個點的點座標
        u = (a-y1)/scale_w; t = (b-x1)/scale_h;%算出u與t
        z = z1*(1-u)*(1-t) + z2*u*(1-t) + z3*t*(1-u) + z4*u*t; %biliner公式
        fig(b,a)=z;%將公式後求得的z帶回取代原本的點
    end
end

fig([height2-scale_h*2+2:height2],:) = [];
fig(:,[width2-scale_w*2+2:width2]) = [];
%
[height1 width1 d] = size(fig);
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
imwrite(fig, 'project1_bilinear.tif','tif');  
imshow(fig)
