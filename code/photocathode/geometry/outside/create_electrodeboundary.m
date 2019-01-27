function [electrode_boundary] = create_electrodeboundary ()
% front curve
radius = 14.46e-3;
center = [100e-3-radius 35.54*1e-3 0];
sang = 3*pi/2 + 67.5/180*pi;
eang = pi/4;
electrode_boundary(2) = nrbcirc(radius,center,sang,eang);

radius = 14.46e-3;
center = [100e-3-radius 35.54*1e-3 0];
sang = pi/4;
eang = pi/2;
electrode_boundary(3) = nrbcirc(radius,center,sang,eang);
electrode_boundary(3) = nrbreverse(electrode_boundary(3));

% front connection with cathode
p1 = [(100-(92.5-73.26-14))*1e-3 20e-3 0];
p2 = nrbeval(electrode_boundary(2), 0);
electrode_boundary(1) = nrbline(p1, p2);

% back curve
radius = 7.5e-3;
center = [7.5e-3 (35+7.5)*1e-3 0];
sang = pi/2;
eang = sang + pi/3;
electrode_boundary(5) = nrbcirc(radius,center,sang,eang);
electrode_boundary(5) = nrbreverse(electrode_boundary(5));

radius = 7.5e-3;
center = [7.5e-3 (35+7.5)*1e-3 0];
sang = pi/2 + pi/3;
eang = sang + pi/3;
electrode_boundary(6) = nrbcirc(radius,center,sang,eang);
electrode_boundary(6) = nrbreverse(electrode_boundary(6));

radius = 7.5e-3;
center = [7.5e-3 (35+7.5)*1e-3 0];
sang = pi/2 + 2*pi/3;
eang = sang + pi/3;
electrode_boundary(7) = nrbcirc(radius,center,sang,eang);

% insert kink here

% lower back horizontal
p1 = [7.5*1e-3 35e-3 0];
p2 = [(7.5+73.26)*1e-3 35e-3 0];
electrode_boundary(8) = nrbline(p1, p2);

% upper horizontal
p1 = nrbeval(electrode_boundary(5), 1);
p2 = nrbeval(electrode_boundary(3), 0);
electrode_boundary(4) = nrbline(p1, p2);

% front vertical
p1 = [(7.5+73.26)*1e-3 20e-3 0];
p2 = [(7.5+73.26)*1e-3 35e-3 0];
electrode_boundary(9) = nrbline(p1, p2);

% lower front horizontal
p1 = [(7.5+73.26)*1e-3 20e-3 0];
p2 = [(7.5+73.26+14)*1e-3 20e-3 0];
electrode_boundary(10) = nrbline(p1, p2);
end
