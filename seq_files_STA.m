function [] = seq_files_STA(numIm, stimDuration, pause, mypi)
% function to write sequencer files for spike triggered average stimulus
% with mhz 12, origin north and mode parallel as default settings
% img = image name to show in arena (in bg)
% speed = in °/s
% duration = of rotation
% repetitions = of sequence
% direction = forewards (1) or backwards (2)? write 

%% test function
% img = 'stripes_4LEDs_arena-split';
% speed = [30, 60, 120];
% duration = 3000;
% repetitions = 5;
% direction = 1;

% example
% seq_files_split('stripes_4LEDs_arena-split',[30 60 120 240 480 960 1920],3000,5,1)


%% arena code
fid = fopen('conf_STA.toml','wt'); % save all images to one toml file
mhz = 8; 
origin = 'north';
mode = 'serial';

%% create text file
fprintf(fid,'[arena]\n');
fprintf(fid,['mhz = ',num2str(mhz),'\n']);
fprintf(fid,['origin = "',char(origin),'"\n']);
fprintf(fid,['mode = "',char(mode),'"\n']);
fprintf(fid,'clear-screen = true\n');
fprintf(fid,'\n');

%% for loop to load all images to toml file and stimulus control
% show each image for x sec and between images balck screen for y sec
for i = 1 : size(numIm,2) 
    
    %% image code
    fprintf(fid,'[[image]]\n');
    fprintf(fid,'key = "imgO"\n');
    fprintf(fid,['file = "bg/',char(img),'"\n']);
    fprintf(fid,'limit = 16\n');
    fprintf(fid,'\n');
    
    fprintf(fid,'[[image]]\n');
    fprintf(fid,'key = "imgW"\n');
    fprintf(fid,['file = "bg/',char(img),'"\n']);
    fprintf(fid,'limit = 16\n');
    fprintf(fid,'\n');
    
    %% event code - pin
    fprintf(fid,'[[event-left]]\n');
    fprintf(fid,'type = "pin"\n');
    fprintf(fid,'pin = 0\n');
    fprintf(fid,'\n');
    
    fprintf(fid,'[[event-right]]\n');
    fprintf(fid,'type = "pin"\n');
    fprintf(fid,'pin = 0\n');
    fprintf(fid,'\n');
    
    %% event code - stage 
    fprintf(fid,'[[event-left]]\n');
    fprintf(fid,'type = "stage"\n');
    fprintf(fid,'key = "imgO"\n');
    fprintf(fid,['duration = ', char(stimDuration), '\n']); 
    
    fprintf(fid,'[[event-right]]\n');
    fprintf(fid,'type = "stage"\n');
    fprintf(fid,'key = "imgW"\n');
    fprintf(fid,['duration = ', char(stimDuration), '\n']); 
    
    %% event code - pin
    fprintf(fid,'[[event-left]]\n');
    fprintf(fid,'type = "pin"\n');
    fprintf(fid,'pin = 0\n');
    fprintf(fid,'\n');
    
    fprintf(fid,'[[event-right]]\n');
    fprintf(fid,'type = "pin"\n');
    fprintf(fid,'pin = 0\n');
    fprintf(fid,'\n');
    
    %% event code - black screen
    fprintf(fid,'[[event-left]]\n');
    fprintf(fid,'type = "static"\n');
    fprintf(fid,['duration = ', char(pause), '\n']); 
    
    fprintf(fid,'[[event-right]]\n');
    fprintf(fid,'type = "static"\n');
    fprintf(fid,['duration = ', char(pause), '\n']); 
   
end

%% sequencer code
fprintf(fid,'[sequencer]\n');
fprintf(fid,'repetitions = 1\n');
fprintf(fid,'log-frames = true\n');
fprintf(fid,'log-events = true\n');
fprintf(fid,'\n');

%% close
fclose(fid);

%% put file
putFile(mypi,'conf_STA.toml','/home/pi/go/bin/conf/conf_STA')

