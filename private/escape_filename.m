function str_out = escape_filename(filename)
% Replaces all occurance of \ by \\ in input string or cellstr.
% It is useful for escaping windows filenames and paths so that fprintf does not generate:
%      Warning: Escape sequence 'U' is not valid
%

if ischar(filename)
   str_out = strrep(filename, '\\', '\'); % to avoid repeating a previously escaped \
   str_out = strrep(str_out, '\', '\\');
   
elseif iscellstr(filename)
   cfuna = @(s) strrep(s, '\\', '\'); % to avoid repeating a previously escaped \
   str_out = cellfun(cfuna, filename, 'UniformOutput', false);
   cfun = @(s) strrep(s, '\', '\\');
   str_out = cellfun(cfun, str_out, 'UniformOutput', false);
else
   error('Input type must be string or cellstring.')
end

end
