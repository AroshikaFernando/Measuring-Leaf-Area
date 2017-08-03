I= imread('C:\xampp\htdocs\news\upload\leaf.jpg');
%original image
subplot(3, 3, 1);
imshow(I);
%finding a threshold using otsu method
thr = graythresh(I);
thr_img = im2bw(I,thr);
subplot(3, 3, 2);
imshow(thr_img);
%inverting it
invImg = ~thr_img;
subplot(3, 3, 3);
imshow(invImg);
%filling the holes
BW2 = imfill(invImg,'holes');
subplot(3, 3, 4);
imshow(BW2);
%seperating the leaf
subplot(3, 3, 5);
BW3=bwpropfilt(BW2,'Area',1);
imshow(BW3);
numberofpixelsinleaf = sum(BW3(:))
%detecting the square
Iarea = bwareaopen(BW2,100);
Ifinal = bwlabel(Iarea);
subplot(3, 3, 6);

stat = regionprops(Ifinal,'boundingbox','Area');

imshow(I); hold on;
for cnt = 1 : numel(stat)
    bb = stat(cnt).BoundingBox;
    
    rectangle('position',bb,'edgecolor','r','linewidth',2);
  
end
%getting the smallest area which is the box
allAreas = [stat.Area];
[sortedAreas, sortingIndexes] = sort(allAreas, 'ascend');

box= sortingIndexes(1); 
boxImage = ismember(Ifinal, box) ;
% Now binarize
boxImage = boxImage > 0;
% Display the image.
subplot(3, 3, 7);
imshow(boxImage);
numberOfpixelsinbox = sum(boxImage(:))
%getting the area
AreaOfLeaf=(numberofpixelsinleaf/numberOfpixelsinbox)*1