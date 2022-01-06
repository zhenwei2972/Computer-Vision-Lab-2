%3.1a
imagesrc = imread('images\maccropped.jpg');
whos Pc
%see the size (I always do)
[m n k]=size(imagesrc);
%display it
%imagesc(imagesrc); axis on;

greyImage = rgb2gray(imagesrc);
figure('Name','Grey Input')
imshow(greyImage);

%%
%3.1b
sobelMask1 = [-1,0,1;-2,0,2;-1,0,1]; %x kernel
sobelMask2 = [-1,-2,-1;0,0,0;1,2,1]; %y kernel

sobelImageMask1 =conv2(greyImage,sobelMask1);
figure('Name','Sobel image after x mask ')
imshow(uint8(sobelImageMask1));

sobelImageMask2 =conv2(greyImage,sobelMask2);
figure('Name','Sobel image afer y mask ')
imshow(uint8(sobelImageMask2));

%sobelImageMaskBoth =uint8(conv2(sobelImageMask2,sobelMask1));
%figure('Name','Sobel Masked Both')
%imshow(sobelImageMaskBoth);

%edges which are not vertical or horizontal become more obvious
%close all
%%
%%3.1c
squaredSobelImage =sobelImageMask1.^2 + sobelImageMask2.^2;
figure('Name','Sobel after squaring')
imshow(uint8(squaredSobelImage));
%square to get the magnitude of gradient at pixel x,y
%%
%3.1d
t = 10000;
squaredSobelImageThresholded = squaredSobelImage>t;
figure('Name','Threshold 10000')
imshow(squaredSobelImageThresholded)

t = 20000;
squaredSobelImageThresholded = squaredSobelImage>t;
figure('Name','Threshold 20000')
imshow(squaredSobelImageThresholded)

t = 30000;
squaredSobelImageThresholded = squaredSobelImage>t;
figure('Name','Threshold 30000')
imshow(squaredSobelImageThresholded)

t = 40000;
squaredSobelImageThresholded = squaredSobelImage>t;
figure('Name','Threshold 40000')
imshow(squaredSobelImageThresholded)

t = 50000;
squaredSobelImageThresholded = squaredSobelImage>t;
figure('Name','Threshold 50000')
imshow(squaredSobelImageThresholded)

t = 100000;
squaredSobelImageThresholded = squaredSobelImage>t;
figure('Name','Threshold 100000')
imshow(squaredSobelImageThresholded)
%at T =0, all pixel values at max magnitude at displayed.

%%
close all
%3ei
tl =0.04;
th=0.1;
sigma =1.0;
E = edge(greyImage,'canny',[tl th],sigma);
figure('Name','CannyEdge1')
imshow(E);
sigma =2.0;
E = edge(greyImage,'canny',[tl th],sigma);
figure('Name','CannyEdge2')
imshow(E);
sigma =3.0;
E = edge(greyImage,'canny',[tl th],sigma);
figure('Name','CannyEdge3')
imshow(E);
sigma =4.0;
E = edge(greyImage,'canny',[tl th],sigma);
figure('Name','CannyEdge4')
imshow(E);
sigma =5.0;
E = edge(greyImage,'canny',[tl th],sigma);
figure('Name','CannyEdge5')
imshow(E);
close all
%%
%3.1eii)
tl =0.01;
th=0.1;
sigma =1.0;
E = edge(greyImage,'canny',[tl th],sigma);
figure('Name','tl0.01')
imshow(E);
tl =0.02;
E = edge(greyImage,'canny',[tl th],sigma);
figure('Name','tl0.02')
imshow(E);
tl =0.03;
E = edge(greyImage,'canny',[tl th],sigma);
figure('Name','tl0.03')
imshow(E);
tl =0.04;
E = edge(greyImage,'canny',[tl th],sigma);
figure('Name','tl0.04')
imshow(E);
tl =0.05;
E = edge(greyImage,'canny',[tl th],sigma);
figure('Name','tl0.05')
imshow(E);
tl =0.06;
E = edge(greyImage,'canny',[tl th],sigma);
figure('Name','tl.0.6')
imshow(E);
close all
%%
%%3.2a
tl =0.04;
th=0.1;
sigma =6.0;
E = edge(greyImage,'canny',[tl th],sigma);
figure('Name','CannyEdge1')
imshow(E);
%%
%3.2b
[H,xp] = radon(E);
figure('Name','radon transform')
imshow(uint8(H));
%%figure('Name','radon transform')
%%imagesc(H);
title('R_{\theta} (X\prime)');
xlabel('\theta (degrees)');
ylabel('X\prime');
%radon transform is the continuous form 
%of the hough transform, radon is more accurate but slower
%%
%3.2c
close all
maxVal = max(H(:));
[xRadiusMax, thetaMax] = find(H== maxVal)

thetaMax
xRadiusMax
figure('Name','radon transform')
imagesc(uint8(H));
%-1 seem to give  better edge. 
%%thetaMax = thetaMax-1
%%thetaMax
%%
%3.2d
radius = xp(xRadiusMax)
[A,B] =pol2cart((thetaMax*pi/180),radius);
B = -B
%get center of image
center = floor((size(greyImage)+1)/2)
center
C = A*(A+179) + B*(B+145);
A
B
C
%%
%3.2e
%substitute into formula since we now have C. 
%Ax+By =C
%find y if x is already given. 
%yl = (C + AX)/B
size(greyImage)
width=357
xl =0;
yl = (C -A *x1) /B;
xr =width-1;
yr = (C -A *xr) /B;
yl
yr
%%
%3.2f
figure('Name','output')
imshow(greyImage)
line([xl,xr],[yl,yr])
%%
%3.3 3D stereo
