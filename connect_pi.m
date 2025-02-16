function [mypi] = connect_pi(IP)


% connect to Raspberry Pi
mypi = raspi(IP,'pi','BombusD136');
% openShell(r)  % opens putty, but not neccassary to run stimuli

% close