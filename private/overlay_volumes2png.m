function overlay_volumes2png(vol, vol_overlay, clim, pngFileName, type, type_clim)
% Generates colorFA in png format of the slices. 
%   CLIM - Vector of length two - lower limit & upper limit of intensity
%   PNGFILENAME - file name with full path
%   TYPE, TYPE_CLIM - Optional. See overlay_volumes.m
%

if ~exist('type', 'var')
   type = 'redgreen';
elseif strcmpi(type, 'edge')
   if exist('type_clim', 'var')
      overlay_volume_edge2png(vol, vol_overlay, clim, pngFileName, type_clim);
   else
      overlay_volume_edge2png(vol, vol_overlay, clim, pngFileName);
   end
   return;
end

if ~exist('type_clim', 'var')
   type_clim = [70 94];
end

A = overlay_volumes(vol, vol_overlay, clim, type, type_clim);
vol2png(A, [0 1], pngFileName, 'rgb');

end

