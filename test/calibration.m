clear;
close all;
clc;

addpath('../shwfs/');
addpath('./data/');  
pic = '11.bmp';
shstruct = struct(); 
shstruct.maxinteger = 255;
sh_flat = double(rgb2gray(imread(pic)))/ shstruct.maxinteger;
sh_flat_bg = zeros(size(sh_flat));
shstruct.calibration_date = datestr(now, 'yyyymmddHHMMSS');
shstruct.use_bg = 1;               
shstruct.thresh_binary_img = max(sh_flat(:)) * 0.2; 
shstruct.npixsmall = 15;          
shstruct.strel_rad = 8;            
shstruct.coarse_grid_radius = 6;  
shstruct.percent = 0.2;            
shstruct.multiply_est_radius = 1/sqrt(2);
shstruct.centroid = @centroid;     
shstruct.pupil_radius_m =2.25e-3;    
shstruct.totlenses = 127;
shstruct.flength = 45e-3;
shstruct.pitch = 150e-6;
shstruct.camera_pixsize = 5e-6;
shstruct.sa_radius_m = shstruct.pitch/2;
shstruct.dai_n_zernike = 4;  

[shstruct] = shwfs_calibrate(...
    shstruct, 'shstruct.mat', sh_flat, sh_flat_bg);
