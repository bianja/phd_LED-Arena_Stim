function [duration] = test_single_stripe_seq(img, speed, repetitions, mypi, width, dir)

% function to write sequencer file to execute within matlab gui: test
% stimulus, single stripe rotating over arena (parameters defined by user
% by using the user interface)

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
% seq_files('stripes_4LEDs_arena',[30 60 120 240 480 960 1920],3000,5)

% cd ('F:\Setup\Arena_stim\stim')
%% set movement direction

% if direction == 2   % ccw
% elseif direction == 1   % cw
%     speed = speed *(-1);
% else
%     error('invalid direction')
% end
degree = 360;

speedval_temp = 2.8125*(2+width)*speed;
duration = (1/speedval_temp)*360;
duration = duration * 1000;
duration = round(duration);
if dir == 1 % CCW
    degree = degree * -1;
elseif dir == 2 %CW
    duration = duration * -1;
end

% duration = duration * 5;

for i = 1 : size(speed,2)
    %% create txt file
    fid = fopen(['conf_stripes/test_stripe_', num2str(speed(i)),'_',num2str(width), '.toml'],'wt');
    
    %% arena code
    mhz = 8;
    mode = 'serial';
    
    fprintf(fid,'[arena]\n');
    fprintf(fid,['mhz = ',num2str(mhz),'\n']);
    fprintf(fid,['mode = "',char(mode),'"\n']);
    fprintf(fid,'clear-screen = false\n');
    fprintf(fid,'\n');
    
    %% image code
    
    fprintf(fid,'[[image]]\n');
    fprintf(fid,'key = "imgR"\n');
    fprintf(fid,['file = "bg/',char(img),'"\n']);
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
    fprintf(fid,['degree-x = ', num2str(degree), '.0\n']);
    fprintf(fid,['duration = ', num2str(duration), '\n']);
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
putFile(mypi,['conf_stripes/test_stripe_', num2str(speed(i)),'_',num2str(width), '.toml'],'/home/pi/go/bin/conf/conf_stripes')
