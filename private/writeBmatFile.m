function writeBmatFile(bMatrices, fname)
% bMatrices should be 3x3xnDir

fid = fopen(fname, 'w');
for iDir = 1:size(bMatrices,3)
   temp = squeeze(bMatrices(:,:,iDir))';
   temp = temp(:)';
   fprintf(fid, '%22.15f %22.15f %22.15f\n%22.15f %22.15f %22.15f\n%22.15f %22.15f %22.15f\n\n', temp);
end
fclose(fid);
end
