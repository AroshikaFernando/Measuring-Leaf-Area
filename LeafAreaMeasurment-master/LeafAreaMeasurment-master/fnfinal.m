I= imread('C:\xampp\htdocs\news\upload\leaf.jpg');
%original image

%finding a threshold using otsu method
thr = graythresh(I);
thr_img = im2bw(I,thr);

%inverting it
invImg = ~thr_img;

%filling the holes
BW2 = imfill(invImg,'holes');

%seperating the leaf

BW3=bwpropfilt(BW2,'Area',1);

numberofpixelsinleaf = sum(BW3(:));
%detecting the square
Iarea = bwareaopen(BW2,100);
Ifinal = bwlabel(Iarea);


stat = regionprops(Ifinal,'boundingbox','Area');


for cnt = 1 : numel(stat)
    bb = stat(cnt).BoundingBox;
    
    
  
end
%getting the smallest area which is the box
allAreas = [stat.Area];
[sortedAreas, sortingIndexes] = sort(allAreas, 'ascend');

box= sortingIndexes(1); 
boxImage = ismember(Ifinal, box) ;
% Now binarize
boxImage = boxImage > 0;
% Display the image.

numberOfpixelsinbox = sum(boxImage(:));
%getting the area
AreaOfLeaf=(numberofpixelsinleaf/numberOfpixelsinbox)*1;
fprintf('%f cmxcm',AreaOfLeaf);