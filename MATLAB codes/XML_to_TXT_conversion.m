clear all
close all

% file to read
filename='C:\Users\ryanr\OneDrive\Desktop\Krapf Research\RNA data analysis\Trajectories\Test 2024-3-30\Dish 1\Sample1001_control_Tracks.xml';
% filename to write to
savefile='C:\Users\ryanr\OneDrive\Desktop\Krapf Research\RNA data analysis\Trajectories\Test 2024-3-30\Dish 1\Sample1001_control_Tracks.txt';
% pixel size in micrometers (if in pixels, use 1)
pixelsize = 0.130; 
% maximum track length in frames (movie length)
Max = 1500; 

%% Import tracks, output of trackMate plugin and display them
[tracks, metadata] = importTrackMateTracks(filename); 

% Initialize empty matrix from cell array output of importTrackmateTracks
    % Each cell contains an Nx4 double where N = traj length, 4 = t,x,y,z
    % M = number of trajectories
[M,N]=size(tracks);
% Initialize a matrix of NaNs: [rows=frames, cols=X/Y coords]
B(1:Max,1:2*M)=NaN;
format = '';
title = '';
% Writing a txt file
fid = fopen(savefile, 'w');
traj_counter = 0;
% for each trajectory
for i=1:M
    % cell array of {row,1}
    A=tracks{i,1};
    % Q = length of trajectory, P = 4 (t,x,y,z)
    [Q,P]=size(A);
    % rows = traj length, cols = x coordinates
    B(1:Q,2*i-1)=A(:,2) * pixelsize;
    % y coordinates
    B(1:Q,2*i)=A(:,3) * pixelsize;
    % Write to 4 decimal places
    format = [format,'%12.4f\t%12.4f\t'];
    % Write header (X0 Y0 X1 Y1 ...)
    title = [title, '      ' 'X' num2str(traj_counter) '      ' '\t' '      ' 'Y' num2str(traj_counter) '      ' '\t'];
    traj_counter = traj_counter + 1;
end

%% Write
fprintf(fid, [title,'\r\n']);
fprintf(fid,[format,'\r\n'] ,B');
fclose(fid);