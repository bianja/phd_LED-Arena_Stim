function [stats, meanval, sdval, diff, im] = STA_Mean(I)

if size(I,2) > size(I,1)
    l = size(I,2);
else
    l = size(I,1);
end


for j = 1 : 3
    for i  = 1 : l
        a =  im2double(I{i}(:,:,j))*255;
        a = a/255*16;% beacuse 16 is max value (limit) of arena
        if i == 1
            b = a;
        else
            b = b + a;
        end
    end
    c = b/size(I,2);
    im(:,:,j) = c;
end
im = im/255; % because Matlab works with 0 to 1 scale
% figure
% imshow(im)

image = uint8(255 * mat2gray(im(:,:,2)));
imageD = im2double(image);
glcms = graycomatrix(image);
stats = graycoprops(glcms);
meanval = mean(imageD(:));
sdval = std(imageD(:));
diff = max(imageD(:)) - min(imageD(:));

% savename = ['MeanImage',count,'.png'];
% imwrite(im,savename)

% xcorr2()

% gray = im2gray(im);
% en = entropy(gray);
% enPlot = entropyfilt(gray);
% imshow(enPlot)