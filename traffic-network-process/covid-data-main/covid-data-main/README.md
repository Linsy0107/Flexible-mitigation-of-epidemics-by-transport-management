# covid-data
This repository aggregates relevant data to model pandemic spread in Germany. The repository makes use of git LFS to make a reference via git submodule convenient and lean and allow future updates and addition of new data sets. The data is not necessarily the most current, as it is mainly used for historic analysis. In case you are dependent on the latest release of a specific data set, please refer to the data provider details in the related subdirectory. Feel encouraged to contribute via a pull-request in case you update any specific data set.

# license
The data is licensed as per the individual license statement of the data provider. A reference to the original license statement is provided per data set/provider in the respective subdirectory. Licenses are checked for compatibility with distribution via this repository in advance. All the data herein is provided in raw form as is without support.

# directory tree
## data
This directory holds subdirectories with different data sources. Each subdirectory represents one data provider. A detailed explanation of the individual data sets is given therein.

### data/bkg
Provider: Bundesamt für Kartographie und Geodäsie

Data: Geographic and administrative data of Germany in different resolutions and with differing level of detail.

### data/delfi
Provider: DELFI e.V.

Data: Public transport information for Germany.

### data/destatis
Provider: Statistisches Bundesamt (Destatis)

Data: Statistical information for Germany.

### data/rki
Provider: Robert Koch-Institut

Data: Pandemic parameters for Germany. Different data scopes like cases, vaccinations etc.
