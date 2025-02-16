
%% create array with RGB values showing a green light 

% clear workspace
clear all %#ok<CLALL>
close all
clc

% create array (black)
image = zeros(16,16*8,3);
image = im2uint8(image);

% set green colour
image(8:10,8:10,2) = 200; 
% image(1:16,1:16,3) = 255; 

% show image
figure
imshow(image)

% export as png
cd('C:\Users\Bianc\OneDrive\Desktop\phd\Setup\arena')
imwrite(image,'green_image.png') % mit imwrite wird das Bild als png ohne weiﬂen Rand gespeichert (nicht saveas nutzen!)

%% array stripes image 1

clear image

% create array
image = zeros(16,16,3,'uint8');

% stripes (green)
for i = 1 : 8 : size(image,2)
    image(:,i:i+3,2) = 200;
end

% show image
figure
imshow(image)

% export as png
imwrite(image,'stripe_image_16.png')

%% array stripes image 2

clear image

% create array
image = zeros(16,16,3,'uint8');

%stripes
for i = 1 : 16 : size(image,2)
    image(:,i:i+7,2) = 200;
end

% show image
figure
imshow(image)

%export as png
imwrite(image,'stripe_image2_16.png')


