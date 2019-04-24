function dir = fullDir(idxClass,idxName)
dir_common = './Brain Dynamics Midterm Exam Dataset';
dir_class = {'/Panic Disorder','/Control'};
dir_name = {'/A','/B','/C'};
% dir_file = {'/EEG_1.txt','/EEG_2.txt'};

dir = [dir_common, dir_class{idxClass}, dir_name{idxName}];
end
