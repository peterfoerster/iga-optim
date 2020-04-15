function [ptcs_vac, ptcs_el] = create_ptcs_opt (ptcs_vac, ptcs_el, order, crv)
   bnds    = nrbextract(ptcs_vac(19));
   bnds(1) = nrbline(nrbeval(bnds(3), 0), nrbeval(crv(19), 0));
   bnds(2) = nrbline(nrbeval(bnds(3), 1), nrbeval(crv(19), 1));
   ptcs_vac(19) = nrbcoons(bnds(3), crv(19), bnds(1), bnds(2));
   bnds = nrbextract(ptcs_vac(22));
   ptcs_vac(22) = nrbcoons(bnds(3), nrbdegelev(bnds(4), order-3), bnds(1), bnds(2));
   bnds = nrbextract(ptcs_vac(23));
   ptcs_vac(23) = nrbcoons(bnds(3), nrbdegelev(bnds(4), order-3), bnds(1), bnds(2));

   bnds    = nrbextract(ptcs_vac(18));
   bnds(1) = nrbline(nrbeval(bnds(3), 0), nrbeval(crv(18), 0));
   bnds(2) = nrbline(nrbeval(bnds(3), 1), nrbeval(crv(18), 1));
   ptcs_vac(18) = nrbcoons(bnds(3), crv(18), bnds(1), bnds(2));
   bnds = nrbextract(ptcs_vac(20));
   ptcs_vac(20) = nrbcoons(bnds(3), nrbdegelev(bnds(4), order-3), bnds(1), bnds(2));
   bnds = nrbextract(ptcs_vac(21));
   ptcs_vac(21) = nrbcoons(bnds(3), nrbdegelev(bnds(4), order-3), bnds(1), bnds(2));

   bnds    = nrbextract(ptcs_vac(17));
   bnds(3) = nrbline(nrbeval(crv(17), 0), nrbeval(bnds(2), 0));
   bnds(4) = nrbline(nrbeval(crv(17), 1), nrbeval(bnds(2), 1));
   ptcs_vac(17) = nrbcoons(bnds(3), bnds(4), crv(17), bnds(2));

   bnds    = nrbextract(ptcs_vac(16));
   bnds(3) = nrbline(nrbeval(crv(16), 0), nrbeval(bnds(2), 0));
   bnds(4) = nrbline(nrbeval(crv(16), 1), nrbeval(bnds(2), 1));
   ptcs_vac(16) = nrbcoons(bnds(3), bnds(4), crv(16), bnds(2));

   bnds    = nrbextract(ptcs_vac(15));
   bnds(3) = nrbline(nrbeval(crv(15), 0), nrbeval(bnds(2), 0));
   bnds(4) = nrbline(nrbeval(crv(15), 1), nrbeval(bnds(2), 1));
   ptcs_vac(15) = nrbcoons(bnds(3), bnds(4), crv(15), bnds(2));

   bnds    = nrbextract(ptcs_vac(14));
   bnds(1) = nrbline(nrbeval(crv(14), 1), nrbeval(bnds(4), 0));
   bnds(2) = nrbline(nrbeval(crv(14), 0), nrbeval(bnds(4), 1));
   ptcs_vac(14) = nrbcoons(nrbreverse(crv(14)), bnds(4), bnds(1), bnds(2));
   bnds = nrbextract(ptcs_vac(13));
   ptcs_vac(13) = nrbcoons(nrbdegelev(bnds(3), order-3), bnds(4), bnds(1), bnds(2));
   bnds = nrbextract(ptcs_vac(12));
   ptcs_vac(12) = nrbcoons(nrbdegelev(bnds(3), order-3), bnds(4), bnds(1), bnds(2));
   bnds = nrbextract(ptcs_vac(11));
   ptcs_vac(11) = nrbcoons(nrbdegelev(bnds(3), order-3), bnds(4), bnds(1), bnds(2));

   % electrode
   bnds    = nrbextract(ptcs_el(6));
   bnds(1) = nrbline(nrbeval(crv(19), 0), nrbeval(bnds(4), 0));
   bnds(2) = nrbline(nrbeval(crv(19), 1), nrbeval(bnds(4), 1));
   ptcs_el(6) = nrbcoons(crv(19), bnds(4), bnds(1), nrbdegelev(bnds(2), order-2));

   bnds = nrbextract(ptcs_el(5));
   bnds(1) = nrbline(nrbeval(crv(18), 0), nrbeval(bnds(1), 1));
   bnds(4) = nrbline(nrbeval(bnds(1), 1), nrbeval(crv(17), 1));
   ptcs_el(5) = nrbcoons(crv(18), bnds(4), bnds(1), crv(17));

   bnds = nrbextract(ptcs_el(4));
   bnds(1) = nrbline(nrbeval(bnds(3), 0), nrbeval(crv(16), 1));
   bnds(2) = nrbline(nrbeval(bnds(3), 1), nrbeval(crv(16), 0));
   ptcs_el(4) = nrbcoons(bnds(3), nrbreverse(crv(16)), bnds(1), nrbdegelev(bnds(2), order-2));

   bnds = nrbextract(ptcs_el(3));
   bnds(1) = nrbline(nrbeval(bnds(3), 0), nrbeval(crv(15), 0));
   bnds(2) = nrbline(nrbeval(bnds(3), 1), nrbeval(crv(15), 1));
   ptcs_el(3) = nrbcoons(nrbdegelev(bnds(1), order-2), bnds(2), bnds(3), crv(15));

   bnds = nrbextract(ptcs_el(2));
   bnds(1) = nrbline(nrbeval(bnds(3), 0), nrbeval(crv(14), 1));
   bnds(2) = nrbline(nrbeval(bnds(3), 1), nrbeval(crv(14), 0));
   ptcs_el(2) = nrbcoons(bnds(3), nrbreverse(crv(14)), bnds(1), nrbdegelev(bnds(2), order-2));

   bnds = nrbextract(ptcs_el(1));
   ptcs_el(1) = nrbcoons(bnds(3), bnds(4), bnds(1), nrbdegelev(bnds(2), order-3));
end