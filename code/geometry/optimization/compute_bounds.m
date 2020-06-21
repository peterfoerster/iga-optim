function [lb, ub] = compute_bounds (x, order, N_ctrl)
    geometry_file = ['v6_opt_order=' num2str(order)];
    create_geometry_opt (geometry_file, x, order);
    [geometry] = mp_geo_load ([geometry_file '.txt']);

    nrb_opt = create_nrb_opt_electrode (order);
    nrb_opt = move_ctrl_opt (nrb_opt, x);
    ctrl    = nrb_opt.coefs ./ nrb_opt.coefs(4,:);

    tol = 1e-4;
    lb = ub = NaN(N_ctrl,1);

    % minimum y-value
    bnds  = nrbextract(geometry(14).nurbs);
    y_min = nrbeval(bnds(3), 1);
    y_min = y_min(2);

    % maximum y-value
    bnds  = nrbextract(geometry(15).nurbs);
    y_max = nrbeval(bnds(1), 0.5);
    y_max = y_max(2);

    % minimum x-value (patch 14)
    bnds  = nrbextract(geometry(15).nurbs);
    x_min = nrbeval(bnds(3), 0);
    x_min = x_min(1);

    if (order < 8)
        % 18
        bnds = nrbextract(geometry(18).nurbs);
        pts3 = bnds(3).coefs(1:2,:) ./ bnds(3).coefs(4,:);
        pts4 = bnds(4).coefs(1:2,:) ./ bnds(4).coefs(4,:);

        ictrl = 2;
        ix    = 1;
        lb(ix) = 0;
        ub(ix) = (pts4(1,1) - tol) - ctrl(1,ictrl);
        lb(ix+1) = 0;
        ub(ix+1) = (pts3(2,end) - tol) - ctrl(2,ictrl);

        % 17
        bnds = nrbextract(geometry(17).nurbs);
        pts3 = bnds(3).coefs(1:2,:) ./ bnds(3).coefs(4,:);
        pts4 = bnds(4).coefs(1:2,:) ./ bnds(4).coefs(4,:);

        ictrl = 3;
        ioff  = 2;
        ix    = ioff + 1;
        lb(ix)   = (pts3(1,1) + tol) - ctrl(1,ictrl);
        ub(ix)   = (pts4(1,end) - tol) - ctrl(1,ictrl);
        lb(ix+1) = (pts4(2,1) + tol) - ctrl(2,ictrl);
        ub(ix+1) = (y_max - tol) - ctrl(2,ictrl);

        % 16
        bnds = nrbextract(geometry(16).nurbs);
        pts3 = bnds(3).coefs(1:2,:) ./ bnds(3).coefs(4,:);

        ioff = 4;
        for ictrl=4:(order+1)
            ix = ioff + 2*ictrl-7;
            lb(ix)   = (pts3(1,1) + tol) - ctrl(1,ictrl);
            ub(ix)   = (pts3(1,end) - tol) - ctrl(1,ictrl);
            lb(ix+1) = (y_min + tol) - ctrl(2,ictrl);
            ub(ix+1) = (y_max - tol) - ctrl(2,ictrl);
        end

        % 15
        bnds = nrbextract(geometry(15).nurbs);
        pts3 = bnds(3).coefs(1:2,:) ./ bnds(3).coefs(4,:);
        pts4 = bnds(4).coefs(1:2,:) ./ bnds(4).coefs(4,:);

        ictrl = order+2;
        ioff  = 4 + 2*(order-2);
        ix    = ioff + 1;
        lb(ix)   = (pts3(1,1) + tol) - ctrl(1,ictrl);
        ub(ix)   = (pts4(1,end) - tol) - ctrl(1,ictrl);
        lb(ix+1) = (y_min + tol) - ctrl(2,ictrl);
        ub(ix+1) = (y_max - tol) - ctrl(2,ictrl);

        % 14
        bnds = nrbextract(geometry(14).nurbs);
        pts3 = bnds(3).coefs(1:2,:) ./ bnds(3).coefs(4,:);
        pts4 = bnds(4).coefs(1:2,:) ./ bnds(4).coefs(4,:);

        ictrl = order+3;
        ioff  = 6 + 2*(order-2);
        ix = ioff + 1;
        lb(ix)   = (x_min + tol) - ctrl(1,ictrl);
        ub(ix)   = (pts4(1,1) - tol) - ctrl(1,ictrl);
        lb(ix+1) = (pts3(2,1) + tol) - ctrl(2,ictrl);
        ub(ix+1) = (y_max - tol) - ctrl(2,ictrl);
    elseif (order >= 8)
        % 18
        bnds = nrbextract(geometry(18).nurbs);
        pts3 = bnds(3).coefs(1:2,:) ./ bnds(3).coefs(4,:);
        pts4 = bnds(4).coefs(1:2,:) ./ bnds(4).coefs(4,:);

        ictrl = 2;
        ix    = 1;
        lb(ix) = (pts3(1,end) - tol) - ctrl(1,ictrl);
        ub(ix) = (pts4(1,1) - tol) - ctrl(1,ictrl);
        lb(ix+1) = 0;
        ub(ix+1) = (pts3(2,end) - tol) - ctrl(2,ictrl);

        % 17
        bnds = nrbextract(geometry(17).nurbs);
        pts3 = bnds(3).coefs(1:2,:) ./ bnds(3).coefs(4,:);
        pts4 = bnds(4).coefs(1:2,:) ./ bnds(4).coefs(4,:);

        ictrl = 3;
        ioff  = 2;
        ix    = ioff + 1;
        lb(ix)   = (pts3(1,1) + tol) - ctrl(1,ictrl);
        ub(ix)   = (pts4(1,end) - tol) - ctrl(1,ictrl);
        lb(ix+1) = (pts4(2,1) + tol) - ctrl(2,ictrl);
        ub(ix+1) = (y_max - tol) - ctrl(2,ictrl);

        % 16
        bnds = nrbextract(geometry(16).nurbs);
        pts3 = bnds(3).coefs(1:2,:) ./ bnds(3).coefs(4,:);

        ictrl = 4;
        ioff  = 4;
        ix    = ioff + 1;
        lb(ix)   = (pts3(1,1) + tol) - ctrl(1,ictrl);
        ub(ix)   = (pts3(1,end) - tol) - ctrl(1,ictrl);
        lb(ix+1) = (y_min + tol) - ctrl(2,ictrl);
        ub(ix+1) = (y_max - tol) - ctrl(2,ictrl);

        % 15
        bnds = nrbextract(geometry(15).nurbs);
        pts3 = bnds(3).coefs(1:2,:) ./ bnds(3).coefs(4,:);
        pts4 = bnds(4).coefs(1:2,:) ./ bnds(4).coefs(4,:);

        ictrl = 5;
        ioff  = 6;
        ix    = ioff + 1;
        lb(ix)   = (pts3(1,1) + tol) - ctrl(1,ictrl);
        ub(ix)   = (pts4(1,end) - tol) - ctrl(1,ictrl);
        lb(ix+1) = (y_min + tol) - ctrl(2,ictrl);
        ub(ix+1) = (y_max - tol) - ctrl(2,ictrl);

        % 14
        bnds = nrbextract(geometry(14).nurbs);
        pts3 = bnds(3).coefs(1:2,:) ./ bnds(3).coefs(4,:);
        pts4 = bnds(4).coefs(1:2,:) ./ bnds(4).coefs(4,:);

        ictrl = 6;
        ioff  = 8;
        ix    = ioff + 1;
        lb(ix)   = (x_min + tol) - ctrl(1,ictrl);
        ub(ix)   = (pts4(1,1) - tol) - ctrl(1,ictrl);
        lb(ix+1) = (pts3(2,1) + tol) - ctrl(2,ictrl);
        ub(ix+1) = (y_max - tol) - ctrl(2,ictrl);
    end
end
