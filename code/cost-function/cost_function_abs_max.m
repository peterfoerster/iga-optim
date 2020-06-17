function [obj] = cost_function_abs_max (x, order)
    geometry_file = ['v6_opt_order=' num2str(order)];
    create_geometry_opt (geometry_file, x, order);

    [problem_data, method_data] = setup_problem (geometry_file);
    [geometry, msh, space, phi] = mp_solve_electrostatics (problem_data, method_data);

    iptcs = [18 17 16 15 14];

    obj = 0;
    for ii=1:length(iptcs)
        obj_ptc = computeE_max (phi(space.gnum{iptcs(ii)}), msh.msh_patch{iptcs(ii)}, space.sp_patch{iptcs(ii)}, geometry(iptcs(ii)));
        obj = max([obj obj_ptc]);
    end
end
