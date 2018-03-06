clc, clear;
url = 'http://192.168.43.1:8080/shot.jpg';
while true,
%% Clear environment vars
% Image Pre-processing and plane trisection


image  = imread(url);

fudgeFactor = 0.9;
se90 = strel('line', 2, 90);
se0 = strel('line', 1, 0);
%image = imsharpen(image, 'Amount', 2);
rmat = image(:,:,1);
gmat = image(:,:,2);
bmat = image(:,:,3);
%% Apply sobel+Image Dilation+Filters on all RGB planes

%%rmat sobel
[~, threshold] = edge(rmat, 'sobel');
BWs = edge(rmat,'sobel', threshold * fudgeFactor);
BWsdilr = imdilate(BWs, [se90 se0]);
%figure, imshowpair(BWsdilr, BWs, 'montage'), title('dilated R gradient mask');

%%gmat sobel
[~, threshold] = edge(gmat, 'sobel');
BWs = edge(gmat,'sobel', threshold * fudgeFactor);
BWsdilg = imdilate(BWs, [se90 se0]);
%figure, imshowpair(BWsdilg, BWs, 'montage'), title('dilated G gradient mask');

%%bmat sobel
[~, threshold] = edge(bmat, 'sobel');
BWs = edge(bmat,'sobel', threshold * fudgeFactor);
BWsdilb = imdilate(BWs, [se90 se0]);
%figure, imshowpair(BWsdilb, BWs, 'montage'), title('dilated B gradient mask');

%%view all
%% Merge all dilated planes and count circles

c=BWsdilr+BWsdilg+BWsdilb;
c=~c;
detectCircles = @(x) imfindcircles(x,[20 35],'Sensitivity',0.89, 'EdgeThreshold',0.0, 'Method','PhaseCode', 'ObjectPolarity','Dark');
[centers, radii, metric] = detectCircles(c);

%% Mark circles on the image
%imshow(c);
%viscircles(centers, radii);
%pause(2);
disp(size(centers,1));
end