function pathHelper = prepareEnv(datasets, dependenciesPath, dataSetPath)
% add dependencies to path
% genpath函数用于生成指定路径下的所有子目录和文件的完整路径列表。
% 在这里，它将返回dependenciesPath路径下所有子目录和文件的完整路径列表。
% ddpath函数用于将指定的路径添加到MATLAB的搜索路径中。
% 在这里，它将把dependenciesPath路径下所有子目录和文件的完整路径添加到MATLAB的搜索路径中，使得MATLAB可以在这些路径下查找和加载相关的函数、工具箱等。
addpath(genpath(dependenciesPath));

sysType = computer(); % 获取当前计算机的类型，并将其存储在变量sysType中。
% 调用名为dataSetFilePath的函数，并将参数dataSetPath传递给它。
% 该函数的作用是生成数据集文件的完整路径，并将结果存储在变量pathHelper中。
pathHelper = dataSetFilePath(dataSetPath); 

% 如果sysType的值为"PCWIN64"，则执行以下操作：
% 显示文本"PCWIN64"。
% 调用函数unpackArchives(datasets, pathHelper)，将数据集解压缩到指定路径。
% 调用函数updatePath()，更新路径信息。
switch sysType
    case 'PCWIN64'
        disp("PCWIN64")
        % unpackArchives(datasets, pathHelper);
        updatePath();
    case 'MACI64'
        disp("MACI64")
        unpackArchives(datasets, pathHelper);
        updatePath();
    case 'GLNXA64'
        disp("GLNXA64")
        unpackArchives(datasets, pathHelper);
        updatePath();
    otherwise
        disp("unknown computer type")
end

% assemble paths and unpack data sets
% 这段MATLAB代码定义了一个名为unpackArchives的函数，该函数用于组装数据集路径并解压缩数据集。
% 函数接受两个参数：datasets和pathHelper。datasets是一个包含多个数据集信息的结构体，pathHelper是一个辅助对象，用于获取数据集的路径。
% 函数首先初始化一个名为datasetArchives的矩阵，用于存储数据集的原始路径和解压缩后的路径。
% 接下来，函数通过循环遍历不同的数据集类型（如BKG、DELFI GTFS、Destatis mobility passenger等），使用pathHelper对象的getDataSetPath方法获取每个数据集的原始路径和解压缩后的路径，并将它们存储在datasetArchives矩阵中。
% 最后，函数返回datasetArchives矩阵，其中包含了所有数据集的原始路径和解压缩后的路径。
    function unpackArchives(datasets, pathHelper)
        
        % assemble BKG data set paths
        offset = 0;        
        for i = 1:size(datasets.bkgDataSets, 1)
            datasetArchives(offset + i, 1) = pathHelper.getDataSetPath(datasets.bkgRaw, datasets.bkgDataSets(i));
            datasetArchives(offset + i, 2) = pathHelper.getDataSetPath(datasets.bkgUnpacked, datasets.bkgDataSets(i));
        end
        
        % assemble DELFI GTFS data set paths
        offset = offset + i;        
        for i = 1:size(datasets.delfiDataSets, 1)
            datasetArchives(offset + i, 1) = pathHelper.getDataSetPath(datasets.delfiRaw, datasets.delfiDataSets(i));
            datasetArchives(offset + i, 2) = pathHelper.getDataSetPath(datasets.delfiUnpacked, datasets.delfiDataSets(i));
        end

        % assemble Destatis mobility passenger data set paths
        offset = offset + i;        
        for i = 1:size(datasets.destatisMobilityPassengerDataSets, 1)
            datasetArchives(offset + i, 1) = pathHelper.getDataSetPath(datasets.destatisMobilityPassengerRaw, datasets.destatisMobilityPassengerDataSets(i));
            datasetArchives(offset + i, 2) = pathHelper.getDataSetPath(datasets.destatisMobilityPassengerUnpacked, datasets.destatisMobilityPassengerDataSets(i));
        end
        
        % assemble Destatis mobility county data set paths
        offset = offset + i;        
        for i = 1:size(datasets.destatisMobilityPassengerDataSets, 1)
            datasetArchives(offset + i, 1) = pathHelper.getDataSetPath(datasets.destatisMobilityCountyRaw, datasets.destatisMobilityCountyDataSets(i));
            datasetArchives(offset + i, 2) = pathHelper.getDataSetPath(datasets.destatisMobilityCountyUnpacked, datasets.destatisMobilityCountyDataSets(i));
        end
                
        % assemble RKI COVID-19 data set paths
        offset = offset + i;        
        for i = 1:size(datasets.rkiCovidDataSets, 1)
            datasetArchives(offset + i, 1) = pathHelper.getDataSetPath(datasets.rkiCovidRaw, datasets.rkiCovidDataSets(i));
            datasetArchives(offset + i, 2) = pathHelper.getDataSetPath(datasets.rkiCovidUnpacked, datasets.rkiCovidDataSets(i));
        end
        
        % assemble RKI COVID-19 vaccination data set paths
        offset = offset + i;
        for i = 1:size(datasets.rkiVaccinationDataSets, 1)
            datasetArchives(offset + i, 1) = pathHelper.getDataSetPath(datasets.rkiVaccinationRaw, datasets.rkiVaccinationDataSets(i));
            datasetArchives(offset + i, 2) = pathHelper.getDataSetPath(datasets.rkiVaccinationUnpacked, datasets.rkiVaccinationDataSets(i));
        end
        
        % assemble processed data set path
        offset = offset + i;
        for i = 1:size(datasets.processedDataSets, 1)
            datasetArchives(offset + i, 1) = pathHelper.getDataSetPath(datasets.processedRaw, datasets.processedDataSets(i));
            datasetArchives(offset + i, 2) = pathHelper.getDataSetPath(datasets.processedUnpacked, datasets.processedDataSets(i));
        end
        
        % unzip archives into specified directories
        for i = 1:size(datasetArchives, 1)
            if(exist(datasetArchives(i, 2), 'file'))
                disp([datasetArchives(i, 1), ' already extracted'])
            else
                unzip(datasetArchives(i, 1), datasetArchives(i, 2));
            end
        end
    end

    function updatePath()
        % 这行代码使用fileparts函数获取当前脚本的完整路径，并将其分解为路径、文件名和扩展名三个部分。其中，mfilename('fullpath')返回当前脚本的完整路径。
        [path, name, ext] = fileparts(mfilename('fullpath'));
        % 这行代码使用addpath函数将当前脚本所在的路径添加到MATLAB的搜索路径中。genpath(path)将路径转换为MATLAB可识别的格式。
        addpath(genpath(path));
    end
end