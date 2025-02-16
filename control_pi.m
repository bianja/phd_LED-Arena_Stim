function [stim] = control_pi(vel, type, r, width)
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
switch type
    case 'rotational'
        exeName = ['arena conf/conf_stripes/stripes_',num2str(vel),'_',num2str(width),'.toml'];
    case 'translational'
        exeName = ['arena-split.dat conf/conf_stripes/split_stripes_',num2str(vel),'_',num2str(width),'.toml'];
end
command = ['cd ' targetDirPath '; ./' exeName ' &> 1 &'];

toc

%% execute command
system(r,command);

%% save stimulus information
stim.type = type;
stim.vel = vel;
stim.width = width;


