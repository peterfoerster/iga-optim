pkg load geopdes;

geometry_file = 'magnetoelastic';

[geometry, boundaries, interfaces, ~, boundary_interfaces] = mp_geo_load ([geometry_file '.txt']);

% plot geometry
% plot_geometry (geometry, boundaries);

% solve for mvp
[problem_data, method_data] = setup_problem (geometry_file);

tic;
[geometry, msh, space, u] = mp_solve_magnetostatics_2d (problem_data, method_data);
fprintf('\ntime elapsed for solution: %d min\n', toc/60);
return
% plot absolute value of electric field and write .dat files
% vtk_pts = {linspace(0, 1, 8), linspace(0, 1, 8)};
% plot_gradient_mp (u, space, geometry, vtk_pts, ['gradient_v3_degree=' num2str(method_data.degree(1)) '_nsub=' num2str(method_data.nsub(1))]);
% view(2);

% write .vtk files
sp_to_vtk (u, space, geometry, method_data.nsub, ['gradient_optim_degree=' num2str(method_data.degree(1)) '_nsub=' num2str(method_data.nsub(1))], '|E|', 'gradient');

% signal that the program is finished
x = linspace(1, 20, 8000);
Y = sin(2*pi*440*x);
sound(Y);
