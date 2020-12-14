% Matlab script creating the heatmap of downloaded ISH gene expression files
% It assumes to have the data as mhd files, and 1 per folder

% Get a list of all files and folders in this folder.
files = dir('./');
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);

% The registered grid data in the allen atlas are always 67,41,58
tot = zeros(67,41,58);

% Iterate through the folder and open the volume
for ii = 3 :   length(subFolders)
    ii
    cd( subFolders(ii).name) ;
        
       info1=mha_read_header('energy.mhd'); 
       v1=mha_read_volume(info1);
       
       tot = tot + v1;
       
    cd ..
end

% Save ovelaps
write_mhd_files('tot', tot, info1.PixelDimensions, info1.DataType)
