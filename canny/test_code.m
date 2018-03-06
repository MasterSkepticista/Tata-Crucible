url = 'http://192.168.0.100:8080/photo.jpg'; %code for connecting to ip camera android app in chrome browser
ss  = imread(url);

image = ss ;
rmat = image(:,:,1);
gmat = image(:,:,2);
bmat = image(:,:,3);
%%rmat sobel
[~, threshold] = edge(rmat, 'prewitt');
fudgeFactor = 0.9;
BWs = edge(rmat,'prewitt', threshold * fudgeFactor);
se90 = strel('line', 4, 90);
se0 = strel('line',4, 0);
BWsdil = imdilate(BWs, [se90 se0]);
BWsdil = medfilt2(BWsdil);
BWsdilr = filter2(fspecial('prewitt'),BWsdil);
BWsdilr = ~filter2(fspecial('average',3),BWsdil);
%figure, imshowpair(BWsdilr, BWs, 'montage'), title('dilated R gradient mask');

%%gmat sobel
[~, threshold] = edge(gmat, 'prewitt');
fudgeFactor =0.9;
BWs = edge(gmat,'prewitt', threshold * fudgeFactor);
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);
BWsdil = medfilt2(BWsdil);
BWsdilg = filter2(fspecial('prewitt'),BWsdil);
BWsdilg = ~filter2(fspecial('average',3),BWsdil);
%figure, imshowpair(BWsdilg, BWs, 'montage'), title('dilated G gradient mask');

%%bmat sobel
[~, threshold] = edge(bmat, 'prewitt');
fudgeFactor = 0.9;
BWs = edge(bmat,'prewitt', threshold * fudgeFactor);
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);
BWsdil = medfilt2(BWsdil);
BWsdilb = filter2(fspecial('prewitt'),BWsdil);
BWsdilb = ~filter2(fspecial('average',3),BWsdil);
%figure, imshowpair(BWsdilb, BWs, 'montage'), title('dilated B gradient mask');

%%view all

c=(BWsdilr+ BWsdilg+BWsdilb)/3;
imshow(c);
c = im2bw(c);
circleFinder(c);
