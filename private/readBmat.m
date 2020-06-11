function bMatrices = readBmat(fname)
% bMatrices are 3x3xnDir

fid = fopen(fname, 'r');

if fid<0
   error('BDP:FileDoesNotExist', ['Could not open the bmat file: ' escape_filename(fname)]);
end

data = fscanf(fid, '%f');
fclose(fid);

if mod(numel(data), 9)~=0
   err_msg = ['Number of elements in the bmat file seems to be invalid: ' escape_filename(fname) ...
      '\n Please make sure that the bmat has only 3x3 matrices. Total number of matrices should be '...
      'same as number of images in diffusion dataset.'];
   error('BDP:InvalidFile', bdp_linewrap(err_msg));
end

data = reshape(data, 3, 3, []);
bMatrices = permute(data, [2 1 3]);

end
