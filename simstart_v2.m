%% Simulation Start
% This code runs the FO-Diff-MAS2D code developed by ...
% This script is edited by (dhollenbeck 12/29/2020)
%....................................................
%clear all
% close all

global ttt1;
ttt1 = clock;

%% Added by Sean Rider for Standard Crop Dusting - consider removing(dhollenbeck 12/29/2020)
% global q dir;
% q = 1;
% dir = 1;
%%%%%

%% Initialization procedures 
initialization1
init_check

%% IC and BC check - consider removing(dhollenbeck 12/29/2020)
%resp = '';
% while isempty(findstr('yn',resp))
%   resp = input('Are the initial conditions and boundary conditions what you want (y,n)? ','s');
%   resp = lower(resp);
% end
%
% if resp == 'y',
% 	pre_process_Riesz;

%% Preprocess 
pre_process_Riesz_dh;
dT = 0.005;
OPTIONS=simset('Solver', 'ode4', 'FixedStep', dT);

%% Run simulation
sim('diffu_ctrl_simfrac_new', SIMTIME,OPTIONS)
% sim('diffu_ctrl_sim', SIMTIME,OPTIONS);

%% Post process simulation
%post_process
save CVT_Consensus;
disp('My program takes about:');
disp(etime(clock,ttt1));