function [g] = nm_bc_2D (ib, x, y)
switch (ib)
	case {3}
		g = zeros(size(x));
	otherwise
		error('unknown boundary');
end%switch
end