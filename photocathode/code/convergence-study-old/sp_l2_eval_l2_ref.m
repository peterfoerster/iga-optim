% evaluate l2

function [l2conv, l2ref] = sp_l2_eval_l2_ref (sp, msh, u_ref, space_ref, u_conv, space_conv, geometry)
% this is used for ensuring that the original version and the modified one coincide
% valu_test = sp_eval_msh (u_ref, sp, msh);

% get quadrature points
msh_pts_x = msh.qn{1};
msh_pts_y = msh.qn{2};
msh_pts_y = reshape( msh_pts_y, 1, numel(msh_pts_y) );

valu_ref = sp_eval(u_ref, space_ref, geometry, {msh_pts_x, msh_pts_y}, 'value');
valu_conv = sp_eval(u_conv, space_conv, geometry, {msh_pts_x, msh_pts_y}, 'value');

% reshape according to original
% valu_test = reshape (valu_test, sp.ncomp, msh.nqn, msh.nel);
valu_ref = reshape (valu_ref, sp.ncomp, msh.nqn, msh.nel);
valu_conv = reshape (valu_conv, sp.ncomp, msh.nqn, msh.nel);

% tests if the original and new solution coincide
% if ( max(max(max(valu_ref - valu_test)))~=0 )
%   error('original and new solution differ');
% end

% compute determinant and quadrature weights
w = msh.quad_weights .* msh.jacdet;

l2conv_elem = sum (reshape (sum (valu_conv.^2, 1), [msh.nqn, msh.nel]) .* w);
l2conv  = sqrt (sum (l2conv_elem));

l2ref_elem = sum (reshape (sum (valu_ref.^2, 1), [msh.nqn, msh.nel]) .* w);
l2ref  = sqrt (sum (l2ref_elem));
end