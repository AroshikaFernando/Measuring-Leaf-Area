grayImage = imread('C:\Users\La$h\Desktop\leaf9.jpg');
% Get the dimensions of the image.  
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(grayImage);
if numberOfColorBands > 1
	% It's not really gray scale like we expected - it's color.
	% Convert it to gray scale by taking only the green channel.
	grayImage = grayImage(:, :, 2); % Take green channel.
end
% Display the original gray scale image.
subplot(2, 3, 1);
imshow(grayImage, []);

backgroundImage = imread('C:\Users\La$h\Desktop\back2.jpg');
% Get the dimensions of the image.  
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(backgroundImage);
if numberOfColorBands > 1
	% It's not really gray scale like we expected - it's color.
	% Convert it to gray scale by taking only the green channel.
	backgroundImage = backgroundImage(:, :, 2); % Take green channel.
end
% Display the image.
subplot(2, 3, 2);
imshow(backgroundImage, []);

diffImage = double(grayImage) - double(backgroundImage);
% Display the image.
subplot(2, 3, 3);
imshow(diffImage, []);
colorbar;
axis on;
textureImage = stdfilt(diffImage, true(9));
subplot(2, 3, 4);
imshow(textureImage, []);



colorbar;
axis on;
% Let's compute and display the histogram.
[pixelCount, grayLevels] = hist(textureImage(:), 256);
subplot(2, 3, 5); 
bar(grayLevels, pixelCount);
grid on;

% Find mask
mask = textureImage > 30;
% Get the convex hull to join the two sides.
mask = bwconvhull(mask, 'union');
% Display the mask image.
subplot(2, 3, 6);
imshow(mask, []);
axis on;