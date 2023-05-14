clear all;
d = load('data_VSRe70.mat');

modes = d.V_POD;
t = d.Y_traj_POD{1,1};
traj1 = d.Y_traj_POD{1,2};

fulltraj = modes*traj1;