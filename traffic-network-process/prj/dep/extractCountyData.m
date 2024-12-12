function counties = extractCountyData(nation)
%EXTRACTCOUNTYDATA Decompose nation level COVID-19 data into county data.
%   This function processes the COVID-19 data struct @nation and returns
%   COVID-19 data and auxiliary information per county in a struct array
%   @counties.

for i = 1:size(nation.county.bkg250KrsArs, 1)
    % BKG data
    counties(i).ars = nation.county.bkg250KrsArs(i);
    counties(i).name = nation.county.bkgData(i).GEN;
    counties(i).area.lat = nation.county.bkgData(i).Lat;
    counties(i).area.lon = nation.county.bkgData(i).Lon;
    counties(i).area.polyshape = nation.county.bkgData(i).Polyshape;
    counties(i).area.geoshape = nation.county.bkgData(i).Geoshape;
    counties(i).area.size = nation.county.bkgData(i).KFL;
end

end
