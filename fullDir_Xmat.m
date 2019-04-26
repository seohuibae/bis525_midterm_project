function dir = fullDir_Xmat(idxClass,idxName,idxChannel,isSurrogate)
cell_common = './Xmat/Xmat';
cell_class = {'_Patient','_Control'};
cell_name = {'_A','_B','_C'};
cell_channel = {'_1','_2'};

if isSurrogate
    dir = [cell_common, cell_class{idxClass}, cell_name{idxName},cell_channel{idxChannel},'_surrogate.mat'];
    title = [cell_class{idxClass}, cell_name{idxName},cell_channel{idxChannel},'_surrogate'];
else
    dir = [cell_common, cell_class{idxClass}, cell_name{idxName},cell_channel{idxChannel},'.mat'];
end
end
