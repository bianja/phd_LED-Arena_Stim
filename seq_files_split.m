function [] = seq_files_split(img, speed, duration, repetitions, mypi, width)
% function to write sequencer files automatically
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

%% set movement direction

% if direction == 2   % vorwärts
% elseif direction == 1   % rückwärts
%     speed = speed *(-1);
% else
%     error('invalid direction')
% end

speedval = 2.8125*(2+width)*speed;
duration = duration * 5;

for i = 1 : size(speed,2)
    %% create txt file
    fid = fopen(['conf_stripes/split_stripes_', num2str(speed(i)),'_',num2str(width), '.toml'],'wt');
    
    %% arena code
    mhz = 8;
    origin = 'north';
    mode = 'parallel';
    
    fprintf(fid,'[arena]\n');
    fprintf(fid,['mhz = ',num2str(mhz),'\n']);
    fprintf(fid,['origin = "',char(origin),'"\n']);
    fprintf(fid,['mode = "',char(mode),'"\n']);
    fprintf(fid,'clear-screen = false\n');
    fprintf(fid,'\n');
    
    %% image code
    
    fprintf(fid,'[[image]]\n');
    fprintf(fid,'key = "imgT"\n');
    fprintf(fid,['file = "bg/',char(img),'"\n']);
    fprintf(fid,'limit = 16\n');
    fprintf(fid,'\n');
    
    %% event left code - pin
    
    fprintf(fid,'[[event-left]]\n');
    fprintf(fid,'type = "pin"\n');
    fprintf(fid,'pin = 0\n');
    fprintf(fid,'\n');
    
    %% event right code - pin
    
    fprintf(fid,'[[event-right]]\n');
    fprintf(fid,'type = "pin"\n');
    fprintf(fid,'pin = 0\n');
    fprintf(fid,'\n');
    
    %% event code - stage 
%     
%     fprintf(fid,'[[event-left]]\n');
%     fprintf(fid,'type = "stage"\n');
%     fprintf(fid,'key = "imgT"\n');
%     fprintf(fid,['duration = 5000', '\n']); 
%     
%     fprintf(fid,'[[event-right]]\n');
%     fprintf(fid,'type = "stage"\n');
%     fprintf(fid,'key = "imgT"\n');
%     fprintf(fid,['duration = 5000', '\n']); 
    
%     %% event left code - pin
%     
%     fprintf(fid,'[[event-left]]\n');
%     fprintf(fid,'type = "pin"\n');
%     fprintf(fid,'pin = 0\n');
%     fprintf(fid,'\n');
%     
%     %% event right code - pin
%     
%     fprintf(fid,'[[event-right]]\n');
%     fprintf(fid,'type = "pin"\n');
%     fprintf(fid,'pin = 0\n');
%     fprintf(fid,'\n');
    
    %% event left code - rotation
    
    fprintf(fid,'[[event-left]]\n');
    fprintf(fid,'type = "rotation"\n');
    if rem(speedval(i),1) == 0
        fprintf(fid,['speed-x = ',num2str(speedval(i)),'.0\n']);
    else
        fprintf(fid,['speed-x = ',num2str(speedval(i)),'\n']);
    end
    fprintf(fid,['duration = ', num2str(duration), '\n']);
    fprintf(fid,'\n');
 
    %% event left code - pin
%     
%     fprintf(fid,'[[event-left]]\n');
%     fprintf(fid,'type = "pin"\n');
%     fprintf(fid,'pin = 0\n');
%     fprintf(fid,'\n');
%     
%     %% event right code - pin
%     
%     fprintf(fid,'[[event-right]]\n');
%     fprintf(fid,'type = "pin"\n');
%     fprintf(fid,'pin = 0\n');
%     fprintf(fid,'\n');   
    
    %% event right code - rotation
    
    fprintf(fid,'[[event-right]]\n');
    fprintf(fid,'type = "rotation"\n');    
    if rem(speedval(i),1) == 0
        fprintf(fid,['speed-x = ',num2str(speedval(i)*(-1)),'.0\n']);
    else
        fprintf(fid,['speed-x = ',num2str(speedval(i)*(-1)),'\n']);
    end
    fprintf(fid,['duration = ', num2str(duration), '\n']);
    fprintf(fid,'\n');
    
%     %% event code - stage 
%     
%     fprintf(fid,'[[event-left]]\n');
%     fprintf(fid,'type = "stage"\n');
%     fprintf(fid,'key = "imgT"\n');
%     fprintf(fid,['duration = 5000', '\n']); 
%     
%     fprintf(fid,'[[event-right]]\n');
%     fprintf(fid,'type = "stage"\n');
%     fprintf(fid,'key = "imgT"\n');
%     fprintf(fid,['duration = 5000', '\n']); 
    
    %% event left code - pin
    
    fprintf(fid,'[[event-left]]\n');
    fprintf(fid,'type = "pin"\n');
    fprintf(fid,'pin = 0\n');
    fprintf(fid,'\n');
    
    %% event right code - pin
    
    fprintf(fid,'[[event-right]]\n');
    fprintf(fid,'type = "pin"\n');
    fprintf(fid,'pin = 0\n');
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

%% put file

% second put file on pi (can I overwrite a file? Or do I need to delete it
% when is has the same file name so that I can save my new file?)
putFile(mypi,['conf_stripes/split_stripes_', num2str(speed(i)),'_',num2str(width), '.toml'],'/home/pi/go/bin/conf/conf_stripes')