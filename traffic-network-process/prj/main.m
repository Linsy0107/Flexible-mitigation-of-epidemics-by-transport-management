clearvars -except nation counties datasets pathHelper 
close all
tStart = tic;
curTime = string(datetime(now, 'ConvertFrom', 'datenum', 'Format', 'yyMMdd_HHmmss'));

%% settings
% enable detailed outputs 
verbosity = false;

%%% preprocessing settings
% switch to enable a rerun of preprocessing 
rerunPreProcessing = false;
% specify the filter masks to include/exclude agencies in the filter logic
procSettings.includeAgencyList = ["DB"]; 
procSettings.excludeAgencyList = ["Bus"];  
% specify the GTFS data set type as described in the documentation of processDelfiData; should match to the entries of "datasets.delfiDataSets"
procSettings.fileTypeGtfs = [1, 2, 2];  
procSettings.verbosity = verbosity;     

%% setup data sets and related paths 用于设置数据集与相关数据
disp("#> setup") 
tStartSection = tic; 

if exist('pathHelper', 'var') == false 
    [path, ~, ~] = fileparts(mfilename('fullpath'));  
    disp(path);
    % add dependencies to path
    addpath(genpath(strcat(pwd, '/dep'))); 
    % define file paths
    % dictionary with zip archive path and target directory path
    datasets.bkgRaw = "raw\covid-data\data\bkg\";
    datasets.bkgUnpacked = "unpacked\covid-data\data\bkg\";
    datasets.bkgDataSets = ["vg250-ew_12-31.utm32s.shape.ebenen"];
    
    datasets.delfiRaw = "raw\covid-data\data\delfi\";
    datasets.delfiUnpacked = "unpacked\covid-data\data\delfi\";
    datasets.delfiDataSets = [
        "20200401_fahrplaene_gesamtdeutschland_gtfs";
        "20201210_fahrplaene_gesamtdeutschland_gtfs";
        "20210423_fahrplaene_gesamtdeutschland_gtfs"];  
    
    datasets.processedRaw = "processed\";
    datasets.processedUnpacked = "unpacked\processed\";
    datasets.processedDataSets = ["GermanyCountyCovid_DB.zip"];
    datasets.processedDataSet = ["GermanyCountyCovid_DB"];
    
    % update path and extract archives
    pathHelper = prepareEnv(datasets, append(path, "\dep\"), append(path, "\dat\"));
    clear path
end
tEndSection = toc(tStartSection);
disp(append("Section runtime: ", string(tEndSection), "s")) 

%% extract and process raw data if not available from disk 
disp("#> data preprocessing/.mat file loading")
tStartSection = tic;
processedDataFileName = append('/', datasets.processedDataSets(end), '.mat');
% check if .mat file with processed data exists or rerun is enabled
if ~logical(exist(append(pathHelper.getDataSetPath(datasets.processedRaw, datasets.processedDataSets(end)), processedDataFileName), 'file')) || rerunPreProcessing
    [nation, counties] = runRawDataExtractionAndProcessing(datasets, pathHelper, procSettings);
else
    % check if data variables are already in workspace
    if ~exist('nation', 'var') || ~exist('counties', 'var')
        load(append(pathHelper.getDataSetPath(datasets.processedUnpacked, datasets.processedDataSets(end)), processedDataFileName))
    end
end
tEndSection = toc(tStartSection);
disp(append("Section runtime: ", string(tEndSection), "s"))
