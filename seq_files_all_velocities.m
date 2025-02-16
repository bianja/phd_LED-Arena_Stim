% I have 7 velocities and two directions for two different optic flow types
% So, my idea would be to have one variable with velocities which is
% randomized and another one with 4 inputs which defines type and direction
% of optic flow


%% clear
clear all; close all; clc; %#ok<CLALL>

%% define variables which will be randomized in the following
vel = [30 60 120 240 480 960 1920];
type = {'t+','t-','r+','r-'};
rep = 5;
duration = 10000;
img_p = 'stripes_2LEDs_arena-split';
img_b = 'stripes_black.png';
pause = 30000;
stage = 0;

%% randomize velocities and create cell with four columns each for one type
rand_val = zeros(7,4);
for i = 1 : 4
    temp = randperm(7,7);
    for j = 1 : length(temp)
        rand_val(j,i) = vel(temp(j));
    end
end

%% create variable with 7x1:4
% to 28, each 4th is for one type; if else with if dividable then to this
% type 
rand_type = zeros(1,28);
rand_temp = randperm(28,28);
for i = 1 : length(rand_temp)
   if rem(rand_temp(i),4) == 0 % without rest
       rand_type(i) = 4;
   elseif rem((rand_temp(i)+1),4) == 0 % without rest
       rand_type(i) = 3;
   elseif rem((rand_temp(i)+2),4) == 0 % without rest
       rand_type(i) = 2;
   elseif rem((rand_temp(i)+3),4) == 0 % without rest
       rand_type(i) = 1;
   else
       disp('error, somethings wrong with the rand function')
   end
end


%% create txt file
fid = fopen(['conf_stripes_all_velocities_10', '.toml'],'wt');

%% arena code
mhz = 8;
origin = 'north';
mode = 'parallel';

fprintf(fid,'[arena]\n');
fprintf(fid,['mhz = ',num2str(mhz),'\n']);
fprintf(fid,['origin = "',char(origin),'"\n']);
fprintf(fid,['mode = "',char(mode),'"\n']);
fprintf(fid,'\n');

% image code green pattern
fprintf(fid,'[[image]]\n');
fprintf(fid,'key = "img_p"\n');
fprintf(fid,['file = "bg/',char(img_p),'.png"\n']);
fprintf(fid,'limit = 16\n');
fprintf(fid,'\n');

% image code black screen
fprintf(fid,'[[image]]\n');
fprintf(fid,'key = "img_b"\n');
fprintf(fid,['file = "bg/',char(img_b),'.png"\n']);
fprintf(fid,'limit = 16\n');
fprintf(fid,'\n');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% code for rotation and translation .....
c_tp = 0; c_rp = 0; c_tn = 0; c_rn = 0;
for i = 1 : length(rand_type)
    if rand_type(i) == 1 %'t+'
        c = c_tp;
        c = c + 1;
        c_tp = c;
        j = 1;
        vl = +1;
        vr = -1;
        
    elseif rand_type(i) == 3 %'r+'
        c = c_rp;
        c = c + 1;
        c_rp = c;
        j = 1;
        vl = +1;
        vr = +1;
        
    elseif rand_type(i) == 2 %'t-'
        c = c_tn;
        c = c + 1;
        c_tn = c;
        j = 2;
        vl = -1;
        vr = +1;
        
    elseif rand_type(i) == 4 %'r-'
        c = c_rn;
        c = c + 1;
        c_rn = c;
        j = 2;
        vl = -1;
        vr = -1;
        
    end
    
    % set pin, either 0 or 1 (direction)
    if rem(j+1,2) == 0
        % event left code - pin
        fprintf(fid,'[[event-left]]\n');
        fprintf(fid,'type = "pin"\n');
        fprintf(fid,'pin = 0\n');
        fprintf(fid,'\n');
    elseif rem(j,2) == 0
        % event right code - pin
        fprintf(fid,'[[event-right]]\n');
        fprintf(fid,'type = "pin"\n');
        fprintf(fid,'pin = 1\n');
        fprintf(fid,'\n');
    end
    
    % event left stage pattern
    fprintf(fid,'[[event-left]]\n');
    fprintf(fid,'type = "stage"\n');
    fprintf(fid,'key = "img_p"\n');
    fprintf(fid,['duration = ', num2str(stage), '\n']);
    fprintf(fid,'\n');
    
    % event right stage pattern
    fprintf(fid,'[[event-right]]\n');
    fprintf(fid,'type = "stage"\n');
    fprintf(fid,'key = "img_p"\n');
    fprintf(fid,['duration = ', num2str(stage), '\n']);
    fprintf(fid,'\n');
    
    % event left code - pattern
    fprintf(fid,'[[event-left]]\n');
    fprintf(fid,'type = "rotation"\n');
    fprintf(fid,['speed-x = ',num2str(rand_val(c,rand_type(i))*(vl)),'.0\n']);
    fprintf(fid,['duration = ', num2str(duration), '\n']);
    fprintf(fid,'\n');
    
    % event right code - pattern
    fprintf(fid,'[[event-right]]\n');
    fprintf(fid,'type = "rotation"\n');
    fprintf(fid,['speed-x = ',num2str(rand_val(c,rand_type(i))*(vr)),'.0\n']);
    fprintf(fid,['duration = ', num2str(duration), '\n']);
    fprintf(fid,'\n');
    
    % set pin, either 0 or 1 (direction)
    if rem(j+1,2) == 0
        % event left code - pin
        fprintf(fid,'[[event-left]]\n');
        fprintf(fid,'type = "pin"\n');
        fprintf(fid,'pin = 0\n');
        fprintf(fid,'\n');
    elseif rem(j,2) == 0
        % event right code - pin
        fprintf(fid,'[[event-right]]\n');
        fprintf(fid,'type = "pin"\n');
        fprintf(fid,'pin = 1\n');
        fprintf(fid,'\n');
    end
    
    % event left stage pattern
    fprintf(fid,'[[event-left]]\n');
    fprintf(fid,'type = "stage"\n');
    fprintf(fid,'key = "img_b"\n');
    fprintf(fid,['duration = ', num2str(stage), '\n']);
    fprintf(fid,'\n');
    
    % event right stage pattern
    fprintf(fid,'[[event-right]]\n');
    fprintf(fid,'type = "stage"\n');
    fprintf(fid,'key = "img_b"\n');
    fprintf(fid,['duration = ', num2str(stage), '\n']);
    fprintf(fid,'\n');
    
    % event left code - black screen
    fprintf(fid,'[[event-left]]\n');
    fprintf(fid,'type = "static"\n');
    fprintf(fid,['duration = ', num2str(pause), '\n']);
    fprintf(fid,'\n');
    
    % event right code - black screen
    fprintf(fid,'[[event-right]]\n');
    fprintf(fid,'type = "static"\n');
    fprintf(fid,['duration = ', num2str(pause), '\n']);
    fprintf(fid,'\n');
   
end

     


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% sequencer code
fprintf(fid,'[sequencer]\n');
fprintf(fid,['repetitions = ', num2str(rep), '\n']);
fprintf(fid,'log-frames = true\n');
fprintf(fid,'log-events = true\n');
fprintf(fid,'\n');

%% close
fclose(fid);
