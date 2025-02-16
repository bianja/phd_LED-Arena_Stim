function [savename] = create_test_stripe_image(width,col,mypi)

% function to create image with a single stripe (user defined width) to
% give into test stimulus (rotating arena, config fle is defined in a
% further function)

im = zeros(16,16*8,3,'uint8');

% image properties (where to start with stripe? at total zero position?)
w = width; % define width 

% create stripe with defined width
im(:,1:w,1) = col(1);
im(:,1:w,2) = col(2);
im(:,1:w,3) = col(3);

% save in current folder
savename = ['test_stripe_w',num2str(width),'.png'];
imwrite(im,savename)

% put file on pi
deleteFile(mypi,savename)
putFile(mypi,savename,'/home/pi/go/bin/bg')