function [] = write_geometryfile (outside_ptcs, filename)
  [interfaces, boundaries] = nrbmultipatch (outside_ptcs);
  boundaries = [];

  boundaries(1).patches = [1 2 3 4 5 6 7 8 10 11 11 12 12 13 13 13];
  boundaries(1).faces   = [3 3 3 1 1 4 4 4  4  1  2  3  4  1  2  4];

  boundaries(2).patches = [1 2 3 4 5 6 7 8 9 10];
  boundaries(2).faces   = [4 4 4 2 2 3 3 3 3  3];

  boundaries(3).patches = [1 10];
  boundaries(3).faces   = [1  1];

  for ibnd = 1:length(boundaries)
    boundaries(ibnd).nsides = length(boundaries(ibnd).patches);
  end

  nrbexport (outside_ptcs, interfaces, boundaries, filename);
end
