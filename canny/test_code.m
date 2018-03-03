image = imread('Straw.jpg');
image = rgb2gray(image);
canny = cannydetector(image);
%invert black and white
canny = ~canny;
imshow(canny);