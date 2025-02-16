function [stim] = test_control_pi(vel, r, width)
% this function is called if push button is clicked

% write a function to create the desired toml file, save it in the correct
% folder, execute it, and delete it. Important information need to be saved
% and available for the user. Maybe do an add-on that the user can choose 
% whether he wants the entered stimuli to get executed randomly or in the 
% order they were entered. Further, add a variable with which the user can 
% choose whether he wants rotational or translation movement or both types
% of movement.

%% set path and file name
tic
targetDirPath = 'go/bin';
exeName = ['arena conf/conf_stripes/test_stripe_',num2str(vel),'_',num2str(width),'.toml'];

command = ['cd ' targetDirPath '; ./' exeName ' &> 1 &'];

toc

%% execute command
system(r,command);

%% save stimulus information
stim.vel = vel;
stim.width = width;


