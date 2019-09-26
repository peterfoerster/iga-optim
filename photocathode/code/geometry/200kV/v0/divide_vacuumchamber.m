function [vacuumchamber_inside] = divide_vacuumchamber (cathode_boundary, vacuumchamber)
   % bottom front horizontal
   p1 = nrbeval(cathode_boundary(1), 1);
   p2 = nrbeval(vacuumchamber(1), 1);
   vacuumchamber_inside(1) = nrbline(p1, p2);

   p1 = nrbeval(cathode_boundary(2), 1);
   p2 = nrbeval(vacuumchamber(2), 1);
   vacuumchamber_inside(2) = nrbline(p1, p2);

   p1 = nrbeval(cathode_boundary(3), 1);
   p2 = nrbeval(vacuumchamber(3), 1);
   vacuumchamber_inside(3) = nrbline(p1, p2);

   p1 = nrbeval(cathode_boundary(4), 1);
   p2 = nrbeval(vacuumchamber(4), 1);
   vacuumchamber_inside(4) = nrbline(p1, p2);

   % front diagonal
   p1 = nrbeval(cathode_boundary(5), 1);
   p2 = nrbeval(vacuumchamber(5), 1);
   vacuumchamber_inside(5) = nrbline(p1, p2);

   p1 = nrbeval(cathode_boundary(6), 0);
   p2 = nrbeval(vacuumchamber(6), 0);
   vacuumchamber_inside(6) = nrbline(p1, p2);

   p1 = nrbeval(cathode_boundary(7), 0);
   p2 = nrbeval(vacuumchamber(7), 0);
   vacuumchamber_inside(7) = nrbline(p1, p2);

   % holes
   p1 = nrbeval(cathode_boundary(8), 0);
   p2 = nrbeval(vacuumchamber(8), 0);
   vacuumchamber_inside(8) = nrbline(p1, p2);

   p1 = nrbeval(cathode_boundary(9), 0);
   p2 = nrbeval(vacuumchamber(9), 0);
   vacuumchamber_inside(9) = nrbline(p1, p2);

   % top back diagonal
   p1 = nrbeval(cathode_boundary(13), 1);
   p2 = nrbeval(cathode_boundary(10), 1);
   p3 = nrbeval(vacuumchamber(12), 1);
   p1 = [p1(1) p2(2)+(p3(2)-p2(2))/5];
   vacuumchamber_inside(10) = nrbline(p1, p2);

   p1 = nrbeval(vacuumchamber_inside(10), 0);
   p2 = nrbeval(vacuumchamber(10), 0);
   vacuumchamber_inside(11) = nrbline(p1, p2);

   p1 = nrbeval(cathode_boundary(13), 1);
   p2 = nrbeval(cathode_boundary(10), 0);
   p1 = [p1(1) p2(2)];
   vacuumchamber_inside(12) = nrbline(p1, p2);

   p1 = nrbeval(vacuumchamber_inside(12), 0);
   p2 = nrbeval(vacuumchamber_inside(11), 0);
   vacuumchamber_inside(13) = nrbline(p1, p2);

   p1 = nrbeval(vacuumchamber(12), 1);
   p2 = nrbeval(vacuumchamber_inside(12), 0);
   vacuumchamber_inside(14) = nrbline(p1, p2);

   p1 = nrbeval(cathode_boundary(13), 1);
   p2 = nrbeval(vacuumchamber_inside(12), 0);
   vacuumchamber_inside(15) = nrbline(p1, p2);

   % top insulator
   p1 = nrbeval(vacuumchamber(13), 1);
   p2 = nrbeval(cathode_boundary(13), 1);
   vacuumchamber_inside(16) = nrbline(p1, p2);

   p1 = nrbeval(vacuumchamber(13), 0);
   p2 = nrbeval(cathode_boundary(13), 0);
   vacuumchamber_inside(17) = nrbline(p1, p2);

   % bottom insulator
   p1 = nrbeval(vacuumchamber(15), 0);
   p2 = [6e-3 16e-3];
   vacuumchamber_inside(18) = nrbline(p1, p2);

   p1 = nrbeval(vacuumchamber_inside(18), 1);
   p2 = [16e-3, 21e-3];
   vacuumchamber_inside(19) = nrbline(p1, p2);

   p1 = nrbeval(vacuumchamber_inside(19), 1);
   p2 = nrbeval(cathode_boundary(23), 1);
   vacuumchamber_inside(20) = nrbline(p1, p2);

   p1 = nrbeval(vacuumchamber_inside(19), 0);
   p2 = nrbeval(cathode_boundary(23), 0);
   vacuumchamber_inside(21) = nrbline(p1, p2);

   p1 = nrbeval(vacuumchamber(14), 0);
   p2 = nrbeval(vacuumchamber_inside(20), 0);
   vacuumchamber_inside(22) = nrbline(p1, p2);

   % cable
   p1 = nrbeval(vacuumchamber(16), 0);
   p2 = nrbeval(cathode_boundary(23), 0);
   vacuumchamber_inside(23) = nrbline(p1, p2);

   % misc
   p1 = nrbeval(vacuumchamber_inside(22), 1);
   p2 = nrbeval(cathode_boundary(13), 0);
   vacuumchamber_inside(24) = nrbline(p1, p2);

   % lift
   p1 = nrbeval(vacuumchamber_inside(20), 1);
   p2 = nrbeval(cathode_boundary(15), 0);
   vacuumchamber_inside(25) = nrbline(p1, p2);

   p1 = nrbeval(cathode_boundary(22), 1);
   p2 = nrbeval(cathode_boundary(16), 0);
   vacuumchamber_inside(26) = nrbline(p1, p2);

   p1 = nrbeval(cathode_boundary(15), 1);
   p2 = nrbeval(cathode_boundary(20), 1);
   vacuumchamber_inside(27) = nrbline(p1, p2);
end
