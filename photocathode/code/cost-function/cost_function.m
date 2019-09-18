function [obj] = cost_function (x)
   geometry_file = 'photocathode_200kV_optim';
   N_inc = (length(x)-8)/12;
   [iptcs, ibnds] = move_geo_ctrl (geometry_file, N_inc, x);
   [geometry, boundaries, interfaces, ~, boundary_interfaces] = mp_geo_load ([geometry_file '.txt']);

   voltage = -200e3;
   [problem_data, method_data] = init_potential (geometry_file, voltage);
   [geometry, msh, space, u] = mp_solve_laplace_mod (problem_data, method_data);

   iptcs = [6 7 8 9 12 13];
   obj = 0;
   for ii=1:length(iptcs)
      obj = obj + computeE_avg (u(space.gnum{iptcs(ii)}), msh.msh_patch{iptcs(ii)}, space.sp_patch{iptcs(ii)}, geometry(iptcs(ii)));
   end
   obj = obj/length(iptcs);
end
