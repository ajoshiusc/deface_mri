function O_trans = bspline_grid_generate_deformation(spacing, sizeI)
% Creates grid of control points for to parameterize deformation-field using uniform 3D
% b-spline. Output is different from bspline_grid_generate() which parameterized a map! To be
% used with bspline_repeated_endpoint_deformation_3d_double_only_x(). 
%
%  Spacing: vector of length 3, representing space between adjacent control points (in unit of
%           voxels) along three dimensions of the image.
%  sizeI: vector with the sizes of the image for which control point would be generated
%

if(length(spacing)==2)
   error('This function does not support 2D grid points.')
else
   % Determine grid spacing
   dx = spacing(1);
   dy = spacing(2);
   dz = spacing(3);
   
   if(mod(sizeI(1)-1,dx) + mod(sizeI(2)-1,dy) + mod(sizeI(3)-1,dz))~=0
      error('Size and spacing must be exact.');
   end
   
   sizeI = sizeI(:);
   spacing = spacing(:);
   
   O_size = ceil(sizeI./spacing);
   O_trans = zeros([O_size(:); 3]');
end

end

