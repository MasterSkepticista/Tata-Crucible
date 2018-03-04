image = imread('straws.jpg');
image = imsharpen(image, 'Amount', 4);
rmat = image(:,:,1);
gmat = image(:,:,2);
bmat = image(:,:,3);
%%rmat sobel
[~, threshold] = edge(rmat, 'sobel');
fudgeFactor = 0.9;
BWs = edge(rmat,'sobel', threshold * fudgeFactor);
se90 = strel('line', 4, 90);
se0 = strel('line',4, 0);
BWsdil = imdilate(BWs, [se90 se0]);
BWsdil = medfilt2(BWsdil);
BWsdilr = ~filter2(fspecial('average',3),BWsdil);
%figure, imshowpair(BWsdilr, BWs, 'montage'), title('dilated R gradient mask');

%%gmat sobel
[~, threshold] = edge(gmat, 'sobel');
fudgeFactor = 0.9;
BWs = edge(gmat,'sobel', threshold * fudgeFactor);
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);
BWsdil = medfilt2(BWsdil);
BWsdilg = ~filter2(fspecial('average',3),BWsdil);
%figure, imshowpair(BWsdilg, BWs, 'montage'), title('dilated G gradient mask');

%%bmat sobel
[~, threshold] = edge(bmat, 'sobel');
fudgeFactor = 0.9;
BWs = edge(bmat,'sobel', threshold * fudgeFactor);
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);
BWsdil = medfilt2(BWsdil);
BWsdilb = ~filter2(fspecial('average',3),BWsdil);
%figure, imshowpair(BWsdilb, BWs, 'montage'), title('dilated B gradient mask');

%%view all

c=(BWsdilr+ BWsdilg+BWsdilb);
c=im2bw(c);
imshow(c);
detectCircles = @(x) imfindcircles(x,[40 80],'Sensitivity',0.8800, 'EdgeThreshold',0.03, 'Method','TwoStage', 'ObjectPolarity','Dark');
[centers, radii, metric] = detectCircles(c);

