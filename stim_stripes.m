%% arary stripes (4 LEDs)

% clear workspace
clear all %#ok<CLALL>
close all
clc

%% for arena

clear image

% create array
image = zeros(16,16*8,3,'uint8');


%stripes
for i = 1 : 8 : size(image,2)
    image(:,i:i+3,2) = 200;
end

% show image
figure
imshow(image)


%export as png
imwrite(image,'stripes_4LEDs_arena.png')

%% for arena-split

clear image

image = zeros(16,16,3,'uint8');
for i = 1 : 8 : size(image,2)
    image(:,i:i+3,2) = 255; % grün
%     image(:,i:i+3,1) = 255; % rot
%     image(:,i:i+3,3) = 255; % blau
%     image(:,i:i+3,1:3) = 255; % weiss
end
figure
imshow(image)
imwrite(image,'stripes_4LEDs_arena-split.png')


%% for arena-split 2LED width

clear image

image = zeros(16,16,3,'uint8');
for i = 1 : 4 : size(image,2)
    image(:,i:i+1,2) = 255; % grün
end
figure
imshow(image)
imwrite(image,'stripes_2LEDs_arena-split.png')


%% for arena-split black

clear image

image = zeros(16,16,3,'uint8');
for i = 1 : size(image,2)
    image(:,:,:) = 0; % black
end
figure
imshow(image)
imwrite(image,'stripes_black.png')