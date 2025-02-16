function [] = create_image_STA(number, squares, widthP, widthX, widthY, col, mypi)

%% Script to create different versions of grayscale images
% this script uses the function 'spatialPattern.m' to create a grayscale
% image and afterwards calculates a fft to analyse the spectrum of the image

% OUTPUT is a figure containing 'i' grayscale images with defined alpha 
% values and pixel number and a fourier transform analysis of each pattern

% PARAMETERS
% widthX = number of image pixel in x direction
% widthY = number of image pixel in y direction
% alpha = exponent for spatial filter function 
% number = number of images to produce

%% test

% % set paramters
% col = [0 255 0];
% num = 1; % figure number
% widthP = 4; % width of squares (in px, One px = 2.82°)
% widthX = 16/widthP; % number of pixel in x direction
% widthY = (16*8)/widthP; % number of pixel in y direction
% % alpha = 0; % choose alpha values
% number = 10; % number of images
% squares = 20; % number of squares to add in random checkerboard patterns (screen is dark, add bright dots)
% F = cell(number,1); % create empty cell to save fft for each image
% I = cell(number,1); % create empty cell to save image information
% posS = zeros(2,squares); 
% 
% mkdir('SpikeTriggeredAverage')

%%
val = exist('mypi'); 
mkdir('SpikeTriggeredAverage')

for j = 1 : number
    %% image
%     figure(1)
    
    % create empty matrix with pixel width and alpha value at position i
    Image = zeros(widthX,widthY,'uint8');
    
    % add bright squares
    for k = 1 : squares
        posS(1,k) = randi(widthX*widthY);
        posS(2,k) = 1;
        for i = 1 : 4
            if posS(1,k) > 32
                posS(1,k) = posS(1,k)-32;
                posS(2,k) = i+1;
            end
        end
    end
    for i = 1 : squares
        Image(posS(2,i),posS(1,i)) = 255;
    end
    
    temp = Image;
    % adjust pixel width
    for i = 1 : widthX
        for k = 1 : widthP
            Image(i*widthP-widthP+k,:) = temp(i,:);
        end
    end
    temp2 = Image;
    for i = 1 : widthY
        for k = 1 : widthP
            Image(:,i*widthP-widthP+k) = temp2(:,i);
        end
    end
    
    % show image
%     imshow(Image, [])
%     axis('on', 'image')
%     impixelinfo;
%     grid on;    
    
    % save image
    Image = uint8(255 * mat2gray(Image));
    savename = ['image',num2str(j),'.png'];
    imwrite(Image,['SpikeTriggeredAverage\',savename])
    
    if val == 1 % mypi exits
        % put file on pi
        deleteFile(mypi,savename)
        putFile(mypi,savename,'/home/pi/go/bin/bg')
    else
    end
    
end
% cd('\\132.187.28.150\home\Data\Analysis\matlab\SpikeTriggeredAverage')
save('SpikeTriggeredAverage/Images.mat','I')

