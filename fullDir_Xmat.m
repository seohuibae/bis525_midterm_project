function [dir,title] = fullDir_Xmat(idxClass,idxName,idxChannel,isSurrogate)
cell_common = './Xmat/Xmat_';
cell_class = {'Patient','Control'};
cell_name = {'_A','_B','_C'};

if isSurrogate
    dir = [cell_common, cell_class{idxClass}, cell_name{idxName},'_',num2str(idxChannel),'_surrogate.mat'];
    title = [cell_class{idxClass}, cell_name{idxName},num2str(idxChannel),'_surrogate'];
else
    dir = [cell_common, cell_class{idxClass}, cell_name{idxName},'_',num2str(idxChannel),'.mat'];
    title = [cell_class{idxClass}, cell_name{idxName},num2str(idxChannel)];
end
end
