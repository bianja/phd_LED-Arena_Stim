function [] = seq_files_MHZ(img, MHZ, duration, repetitions)
% function to write sequencer files automatically
% with default settings: mhz = 12, mode = parallel
% img = image name to show in arena (in bg)
% speed = in °/s
% duration = of rotation
% repetitions = of sequence


%% test function
% img = 'stripes_4LEDs_arena';
% speed = [30, 60, 120];
% duration = 3000;
% repetitions = 5;

% example
% seq_files_MHZ('stripes_4LEDs_arena',[2 4 6 8 10],3000,5)

% cd ('F:\Setup\Arena_stim\stim')
%%
for i = 1 : length(MHZ)
    %% create txt file
    fid = fopen(['conf_MHZ/stripes_', num2str(MHZ(i)), '.toml'],'wt');
    
    %% arena code
    mhz = MHZ(i);
    mode = 'parallel';
    
    fprintf(fid,'[arena]\n');
    fprintf(fid,['mhz = ',num2str(mhz),'\n']);
    fprintf(fid,['mode = "',char(mode),'"\n']);
    fprintf(fid,'\n');
    
    %% image code
    
    fprintf(fid,'[[image]]\n');
    fprintf(fid,'key = "img"\n');
    fprintf(fid,['file = "bg/',char(img),'.png"\n']);
    fprintf(fid,'limit = 16\n');
    fprintf(fid,'\n');
    
    %% event code - pin 0
    
    fprintf(fid,'[[event]]\n');
    fprintf(fid,'type = "pin"\n');
    fprintf(fid,'pin = 0\n');
    fprintf(fid,'\n');
    
    %% event code - pin 1
    
    fprintf(fid,'[[event]]\n');
    fprintf(fid,'type = "pin"\n');
    fprintf(fid,'pin = 1\n');
    fprintf(fid,'\n');
    
    %% event code - rotation
    
    fprintf(fid,'[[event]]\n');
    fprintf(fid,'type = "rotation"\n');
    fprintf(fid,['speed-x = ',num2str(60),'.0\n']);
    fprintf(fid,['duration = ', num2str(duration), '\n']);
    fprintf(fid,'\n');
    
    %% sequencer code
    fprintf(fid,'[sequencer]\n');
    fprintf(fid,['repetitions = ', num2str(repetitions), '\n']);
    fprintf(fid,'log-frames = true\n');
    fprintf(fid,'log-events = true\n');
    fprintf(fid,'\n');
    
    %% close
    fclose(fid);
end