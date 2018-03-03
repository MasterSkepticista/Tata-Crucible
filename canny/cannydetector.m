function [Ioutput]= cannydetector(I)
I1=im2double(I);
[IGradX, IGradY]= smoothing(I1);
Iabst=abs(IGradX)+abs(IGradY);
[theta]=computeangle(IGradX,IGradY);
[Iabst1]=nonmaximalsupression(Iabst,theta);
Ie=im2uint8(Iabst1);
Tl=115;
Th=180;
[Ie1]=gradingedges(Ie,Tl,Th);
[Ifinal]=connectingedge(Ie1,Tl,Th);
theta=padarray(theta,[1 1]);
Ifinal= Ifinal(7:end-7,7:end-7);
Ioutput=Ifinal;
figure;
  subplot(1,2,1);imshow(I);title('origional image');
%   subplot(3,3,2);imshow(Ismooth);title('Smoothed image');
%   subplot(3,3,3);imshow(IGradX);title('Gradient along X');
%   subplot(3,3,4);imshow(IGradY);title('Gradient along Y');
%   subplot(3,3,5);imshow(Iabst);title('Absolute Gradient');
%   subplot(3,3,6);imshow(Ie);title('INonMaximalSupression');
%   subplot(3,3,7);imshow(Ie1);title('Threshold= 105');
%   subplot(2,2,2);imshow(BW);title('CANNY WITH 0 THRESH');
%   subplot(2,2,3);(imshow(BW1));title('CANNY WITH THRESH');
  subplot(1,2,2);(imshow(Ifinal));title('Final Image');
  
   
   