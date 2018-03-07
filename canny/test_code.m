clc, clear;
%cam = webcam('WebCam');
url = 'http://192.168.43.1:8080/shot.jpg';
while true,
%% Clear environment vars
% Image Pre-processing and plane trisection

image = imread(url);
%image = imread('Straw17.jpg');
%image = imresize(image, [1000, 1000]);
fudgeFactor = 0.9;
se90 = strel('line', 4, 90);
se0 = strel('line', 4, 0);
%image = imsharpen(image, 'Amount', 2);
rmat = image(:,:,1);
gmat = image(:,:,2);
bmat = image(:,:,3);
%% Apply Sobel+Image Dilation+Filters on all RGB planes

%%rmat sobel
[~, threshold] = edge(rmat, 'sobel');
BWs = edge(rmat,'sobel', threshold * fudgeFactor);
BWsdil = imdilate(BWs, [se90 se0]);
BWsdil = medfilt2(BWsdil);
BWsdilr = ~filter2(fspecial('average',1),BWsdil);
%figure, imshowpair(BWsdilr, BWs, 'montage'), title('dilated R gradient mask');

%%gmat sobel
[~, threshold] = edge(gmat, 'sobel');
BWs = edge(gmat,'sobel', threshold * fudgeFactor);
BWsdil = imdilate(BWs, [se90 se0]);
BWsdil = medfilt2(BWsdil);
BWsdilg = ~filter2(fspecial('average',1),BWsdil);
%figure, imshowpair(BWsdilg, BWs, 'montage'), title('dilated G gradient mask');

%%bmat sobel
[~, threshold] = edge(bmat, 'sobel');

BWs = edge(bmat,'sobel', threshold * fudgeFactor);
BWsdil = imdilate(BWs, [se90 se0]);
BWsdil = medfilt2(BWsdil);
BWsdilb = ~filter2(fspecial('average',1),BWsdil);
%figure, imshowpair(BWsdilb, BWs, 'montage'), title('dilated B gradient mask');

%%view all
%% Merge all dilated planes and count circles

c=BWsdilr+BWsdilg+BWsdilb;

detectCircles = @(x) imfindcircles(x,[15 50],'Sensitivity',0.925, 'EdgeThreshold',0.03, 'Method','PhaseCode', 'ObjectPolarity','Dark');
[centers, radii, metric] = detectCircles(c);

%% Mark circles on the image
imshow(c);
viscircles(centers, radii);
end