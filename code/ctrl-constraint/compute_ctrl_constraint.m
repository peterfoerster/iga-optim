function [ctrl_diff_lb, ctrl_diff_ub] = compute_ctrl_constraint(geometry, ctrl_diff_lb, ctrl_diff_ub, order)
   tol = 1e-6;

   % 19
   bnds = nrbextract(geometry(19).nurbs);
   pts4 = bnds(4).coefs(1:2,:) ./ bnds(4).coefs(4,:);
   for ictrl=2:(order-1)
      ix = 2*ictrl - 3;
      % check left
      y = pts4(2,ictrl);
      % allow initial position
      x_min = compute_linev(y, bnds(3)) - 1e-2;
      ctrl_diff_lb(ix) = pts4(1,ictrl) - (x_min + tol);
      % right given by bounds
      ctrl_diff_ub(ix) = NaN;
      % check bottom -> enforce correct order
      if (ictrl>2)
         ctrl_diff_lb(ix+1) = pts4(2,ictrl) - (pts4(2,ictrl-1) + tol);
      elseif (ictrl==2)
         ctrl_diff_lb(ix+1) = NaN;
      end
      % check top -> enforce correct order
      ctrl_diff_ub(ix+1) = (pts4(2,ictrl+1) - tol) - pts4(2,ictrl);
   end

   % 18
   bnds = nrbextract(geometry(18).nurbs);
   pts3 = bnds(3).coefs(1:2,:) ./ bnds(3).coefs(4,:);
   pts4 = bnds(4).coefs(1:2,:) ./ bnds(4).coefs(4,:);
   ioff = 2*order - 4;
   for ictrl=2:(order-1)
      ix = ioff + 2*ictrl - 3;
      % check left
      y = pts4(2,ictrl);
      x_min = compute_linev(y, bnds(3));
      ctrl_diff_lb(ix) = pts4(1,ictrl) - (x_min + tol);
      % check right -> enforce correct order
      ctrl_diff_ub(ix) = (pts4(1,ictrl+1) - tol) - pts4(1,ictrl);
      % check bottom
      x = pts4(1,ictrl);
      y_min = compute_lineu(x, bnds(1));
      if (x<=pts3(1,1))
         ctrl_diff_lb(ix+1) = pts4(2,ictrl) - (y_min + tol);
      else
         ctrl_diff_lb(ix+1) = NaN;
      end
      % check top
      x = pts4(1,ictrl);
      y_max = compute_lineu(x, bnds(3));
      ctrl_diff_ub(ix+1) = (y_max - tol) - pts4(2,ictrl);
   end

   % 17
   bnds = nrbextract(geometry(17).nurbs);
   pts1 = bnds(1).coefs(1:2,:) ./ bnds(1).coefs(4,:);
   ioff = 4*order - 8;
   for ictrl=2:(order-1)
      ix = ioff + 2*ictrl - 3;
      % check left/right -> enforce correct order
      ctrl_diff_lb(ix) = pts1(1,ictrl) - (pts1(1,ictrl-1) + tol);
      ctrl_diff_ub(ix) = (pts1(1,ictrl+1) - tol) - pts1(1,ictrl);
      % bottom/top given by bounds
      ctrl_diff_lb(ix+1) = NaN;
      ctrl_diff_ub(ix+1) = NaN;
   end

   % 16
   bnds = nrbextract(geometry(16).nurbs);
   pts1 = bnds(1).coefs(1:2,:) ./ bnds(1).coefs(4,:);
   ioff = 6*order - 12;
   for ictrl=2:(order-1)
      ix = ioff + 2*ictrl - 3;
      % check left/right -> enforce correct order
      ctrl_diff_lb(ix) = pts1(1,ictrl) - (pts1(1,ictrl-1) + tol);
      ctrl_diff_ub(ix) = (pts1(1,ictrl+1) - tol) - pts1(1,ictrl);
      % bottom/top given by bounds
      ctrl_diff_lb(ix+1) = NaN;
      ctrl_diff_ub(ix+1) = NaN;
   end

   % 15
   bnds = nrbextract(geometry(15).nurbs);
   pts1 = bnds(1).coefs(1:2,:) ./ bnds(1).coefs(4,:);
   ioff = 8*order - 16;
   for ictrl=2:(order-1)
      ix = ioff + 2*ictrl - 3;
      % check left -> enforce correct order
      ctrl_diff_lb(ix) = pts1(1,ictrl) - (pts1(1,ictrl-1) + tol);
      % check right
      y = pts1(2,ictrl);
      x_max = compute_linev(y, bnds(4));
      ctrl_diff_ub(ix) = (x_max - tol) - pts1(1,ictrl);
      % check bottom
      x = pts1(1,ictrl);
      y_min = compute_lineu(x, bnds(4));
      if (x>=pts1(1,end))
         ctrl_diff_lb(ix+1) = pts1(2,ictrl) - (y_min + tol);
      else
         ctrl_diff_lb(ix+1) = NaN;
      end
      % top given by bounds
      ctrl_diff_ub(ix+1) = NaN;
   end
end
