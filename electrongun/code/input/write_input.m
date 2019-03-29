function [] = write_input (filename, N_prt, iprobe, r, q)
  fid = fopen (filename, 'w');
  for iprt=1:N_prt
    if (any(iprt == iprobe))
      fprintf(fid, '  %E  %E  %E  %E  %E  %E  %E  %E  %i  %i\n', r(iprt,1), r(iprt,2), r(iprt,3), 0, 0, 0, 0, q, 1, 3);
    else
      fprintf(fid, '  %E  %E  %E  %E  %E  %E  %E  %E  %i  %i\n', r(iprt,1), r(iprt,2), r(iprt,3), 0, 0, 0, 0, q, 1, 5);
    end
  end
  fclose (fid);
end
