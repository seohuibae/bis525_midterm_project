function [DIR,TITLE] = fullDir_Xmat(idxClass,idxName,idxChannel,isSurrogate)
cell_common = './Xmat/Xmat';
cell_class = {'Patient','Control'};
cell_name = {'A','B','C'};

if isSurrogate
    DIR = [cell_common,'_', cell_class{idxClass},'_', cell_name{idxName},'_',num2str(idxChannel),'_surrogate.mat'];
    TITLE = [cell_class{idxClass},' ', cell_name{idxName},' ch',num2str(idxChannel),' (surrogate)'];
else
    DIR = [cell_common,'_', cell_class{idxClass},'_', cell_name{idxName},'_',num2str(idxChannel),'.mat'];
    TITLE = [cell_class{idxClass},' ', cell_name{idxName},' ch',num2str(idxChannel)];
end
end
