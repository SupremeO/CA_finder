%% Felix Agbavor (fa424@drexel.edu), v 1.0

%% Main Script (RUN)
% Run this script and follow program to calculate contact angle

clear
close all
clc

[img_file,pth] = uigetfile('*.*','Choose image file', 'default'); % get path to image file
imfile = imread(fullfile(pth,img_file));

figure
imshow(imfile,[0 90]);
imBW = im2bw(imfile);

% first Pre-processing 
L1 = bwlabeln(1-imBW);  % turn white portion black and black portion white
S = regionprops(L1, 'Area'); % get Area of various regions of image
BW2 = ismember(L1, find([S.Area] == max( [S.Area]) )); % remove unwanted Area from image 
figure
BW3 = imfill( BW2, 'holes'); % fill out any holes
BW3(:,1:200) = 0; 
fig1 = imshow(BW3);
[centers, radii, metric] = imfindcircles(BW3,[20 60]);
set(fig1,'tag','B08'); 
set(fig1,'userdata',BW3);

% determine best approach to use to fit image data
if isempty(centers)
    angle = CA_Propanol();
else
    [angle] = CA_water();
end


fprintf('Contact Angle: %0.3f\n',angle)
texx = sprintf('Contact Angle: %0.3f',angle);
text(0.5,0.5,texx,'Units','normalized','Color','red','FontSize',14)


