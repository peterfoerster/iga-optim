function [N_probe] = generate_input_normal (Q, N_prt, rho_probe, mu, sigma, geometry, filename)
  % choose random starting positions normally distributed
  % astra uses [m]
  N_probe = length(rho_probe);
  r = zeros(N_prt+N_probe, 3);

  for iprt=1:N_probe
    if (rho_probe(iprt) < 0)
      r_2D = geo_nurbs (geometry(1).nurbs, geometry(1).dnurbs, geometry(1).dnurbs2, {0, -rho_probe(iprt)}, 0, geometry(1).rdim);
      r(iprt,2:3) = [-r_2D(2) r_2D(1)];
    else
      r_2D = geo_nurbs (geometry(1).nurbs, geometry(1).dnurbs, geometry(1).dnurbs2, {0, rho_probe(iprt)}, 0, geometry(1).rdim);
      r(iprt,2:3) = [r_2D(2) r_2D(1)];
    end
  end

  rho = random('normal', mu, sigma, [1 N_prt]);
  % rho = random('uniform', -1, 1, [1 N_prt]);
  for iprt=1:N_prt
    % check if rho is outside knotspan
    if (abs(rho(iprt)) <= 1)
      if (rho(iprt) < 0)
        r_2D = geo_nurbs (geometry(1).nurbs, geometry(1).dnurbs, geometry(1).dnurbs2, {0, -rho(iprt)}, 0, geometry(1).rdim);
        r(iprt+N_probe,2:3) = [-r_2D(2) r_2D(1)];
      else
        r_2D = geo_nurbs (geometry(1).nurbs, geometry(1).dnurbs, geometry(1).dnurbs2, {0, rho(iprt)}, 0, geometry(1).rdim);
        r(iprt+N_probe,2:3) = [r_2D(2) r_2D(1)];
      end
  end

  % 9e-3 ns entire emission time randomly emit during that time frame
  % probe particles not emitted right at the beginning
  % astra uses [ns]

  % total charge -1nC equally distributed
  % astra uses [nC]
  q = Q/N_prt;

  % particle index 1 for electrons
  % cathode: flag -3 for probe and -1 else
  % otherwise flag 3 for probe and 5 else

  % write .ini file
  write_input (filename, N_prt, N_probe, r, q);
end
