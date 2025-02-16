
%% create array with RGB values 

function [savename] = create_image(width, col, mypi)
% create image and save it in folder; I need to put it on the pi folder;
% therefore use package to connect to pi, save image there and disconnect
% from pi

val = exist('mypi'); 
im = zeros(16,16,3,'uint8');
m = 2;

% image properties
w = width*m;
w2 = (w/2)-1;
for i = 1 : w : size(im,2)
    im(:,i:i+w2,1) = col(1);
    im(:,i:i+w2,2) = col(2);
    im(:,i:i+w2,3) = col(3);
end

% save in current folder
savename = ['img',num2str(width),'.png'];
imwrite(im,savename)

if val == 1 % mypi exits
% put file on pi
deleteFile(mypi,savename)
putFile(mypi,savename,'/home/pi/go/bin/bg')
else 
end





