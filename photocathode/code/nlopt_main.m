clear all; close all; clc;
pkg load geopdes;

order  = 3;
N_ctrl = 11*(order-2) - 2;
x_ini  = zeros(N_ctrl,1);

[lb, ub] = compute_bounds (x_ini, order, N_ctrl);

% global:
% solo: ISRES
% local:
% solo: COBYLA

% nlopt interface
opt.algorithm     = NLOPT_GN_ISRES;
opt.n             = N_ctrl;
opt.min_objective = @(x) cost_function_max(x, order);
opt.lower_bounds  = lb;
opt.upper_bounds  = ub;
opt.fc            = {@(x) volume_constraint(x, order), @(x) ctrl_constraint(x, order, N_ctrl)};
opt.verbose       = 1;
opt.maxeval       = 100;
opt.maxtime       = 6*60*60;

tic;
[x_opt, obj, retcode] = nlopt_optimize (opt, x_ini);
fprintf('\ntime elapsed for optimization: %d min\n', toc/60);

save(['result_nloptim_order=' num2str(order) '.mat'], 'x_opt', 'obj', 'retcode');

% signal that the program is finished
x = linspace(1, 20, 8000);
Y = sin(2*pi*440*x);
sound(Y);
