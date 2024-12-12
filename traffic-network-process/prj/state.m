% Integrate the county resolution traffic flow matrix 
% into a state resolution traffic flow matrix normalization = 1;

states = 16;
days = size(nation.mobility.daily{1},1)
% countyDailyAdj = nation_mobility_W;
countyDailyAdj = nation.mobility.daily{2};
stateDailyAdj = zeros(states,states,days);
stateIdx = zeros(states+2,1);
stateIdx(1)=0;
stateIdx(states+2)=0;
sum1StateIdx = 0;
sum2StateIdx = 0;

% if normalization == 1
%     for j = 1:size(countyDailyAdj, 3)
%      countyDailyAdj(:, :, j) = countyDailyAdj(:, :, j)/max(countyDailyAdj(:, :, j), [], 'all');
%     end
% end

for index = 1:size(nation.county.bkg250KrsArs,1)
    for nState = 1 :16
        if nation.county.bkg250KrsArs(index) >= nState*1000 && (nation.county.bkg250KrsArs(index) < (nState+1)*1000)
            stateIdx(nState+1) = stateIdx(nState+1) + 1; 
        end
    end      
end
disp(stateIdx)
for day= 1:days
    disp(day)
    sum1StateIdx = 0;
    for countRow = 1 :size(stateIdx)-2
        sum1StateIdx = stateIdx(countRow) + sum1StateIdx;  
        for rowIdx = sum1StateIdx + 1:sum1StateIdx + stateIdx(countRow + 1)
            sum2StateIdx = 0;
            for countCol = 1 :size(stateIdx)-2
                sum2StateIdx = stateIdx(countCol) + sum2StateIdx;
                for colIdx = sum2StateIdx + 1:sum2StateIdx + stateIdx(countCol + 1)
                    stateDailyAdj(countRow,countCol,day) = stateDailyAdj(countRow,countCol,day) + countyDailyAdj(rowIdx,colIdx,day);
                end
            end
        end
    end
end

