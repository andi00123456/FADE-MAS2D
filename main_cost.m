clear all,clc     % pollution   %control effort   % position error  % 0.33
% R = 0.33;        % 1                     0                     0                         0.33
% KK = 0.33;      % 0                     1                     0
% Q = 0.33*1e4; % 0                     0                     1

% First sceniaro
R = 0.33;        % 1                     0                     0                         0.33
KK = 0.33; % 0                     1                     0
Q = 0.33*1e4; % 0                     0                     1
n_opt =10;
cost_function
save('J_average.mat');
clear all,clc
%% Second sceniaro
R = 1;        % 1                     0                     0                         0.33
KK = 0; % 0                     1                     0
Q = 0; % 0                     0                     1
n_opt =10;
cost_function
save('J_R.mat');
clear all,clc
%% Third sceniaro
R = 0;        % 1                     0                     0                         0.33
KK = 1; % 0                     1                     0
Q = 0; % 0                     0                     1
n_opt =10;
cost_function
save('J_KK.mat');
clear all,clc
%% Fourth sceniaro
R = 0;        % 1                     0                     0                         0.33
KK = 0; % 0                     1                     0
Q = 1; % 0                     0                     1
n_opt =12;
cost_function
save('J_Q.mat');
