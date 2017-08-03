im=imread('C:\Users\La$h\Desktop\leaf3.jpg');
%convert to 2D black and white with colors inverted
BW = im(:,:,1) < 10;   
%get outlines of each object
[B,L,N] = bwboundaries(BW);
%get stats
stats=  regionprops(L, 'Centroid', 'Area', 'Perimeter');
Centroid = cat(1, stats.Centroid);
Perimeter = cat(1,stats.Perimeter);
Area = cat(1,stats.Area);
CircleMetric = (Perimeter.^2)./(4*pi*Area);  %circularity metric
SquareMetric = NaN(N,1);
TriangleMetric = NaN(N,1);
%for each boundary, fit to bounding box, and calculate some parameters
for k=1:N,
   boundary = B{k};
   [rx,ry,boxArea] = minboundrect( boundary(:,2), boundary(:,1));  %x and y are flipped in images
   %get width and height of bounding box
   width = sqrt( sum( (rx(2)-rx(1)).^2 + (ry(2)-ry(1)).^2));
   height = sqrt( sum( (rx(2)-rx(3)).^2+ (ry(2)-ry(3)).^2));
   aspectRatio = width/height;
   if aspectRatio > 1,  
       aspectRatio = height/width;  %make aspect ratio less than unity
   end
   SquareMetric(k) = aspectRatio;    %aspect ratio of box sides
   TriangleMetric(k) = Area(k)/boxArea;  %filled area vs box area
end
%define some thresholds for each metric
%do in order of circle, triangle, square, rectangle to avoid assigning the
%same shape to multiple objects
isCircle =   (CircleMetric < 1.1);
isTriangle = ~isCircle & (TriangleMetric < 0.6);
isSquare =   ~isCircle & ~isTriangle & (SquareMetric > 0.9);
isRectangle= ~isCircle & ~isTriangle & ~isSquare;  %rectangle isn't any of these
%assign shape to each object
whichShape = cell(N,1);  
whichShape(isCircle) = {'Circle'};
whichShape(isTriangle) = {'Triangle'};
whichShape(isSquare) = {'Square'};
whichShape(isRectangle)= {'Rectangle'};
%now label with results
RGB = label2rgb(L);
imshow(RGB); hold on;
Combined = [CircleMetric, SquareMetric, TriangleMetric];
for k=1:N,
   %display metric values and which shape next to object
   Txt = sprintf('C=%0.3f S=%0.3f T=%0.3f',  Combined(k,:));
   text( Centroid(k,1)-20, Centroid(k,2), Txt);
   text( Centroid(k,1)-20, Centroid(k,2)+20, whichShape{k});
end