% Copyright (C) 2019 The Regents of the University of California and the University of Southern California
% Created by Anand A. Joshi, Chitresh Bhushan, David W. Shattuck, Richard M. Leahy
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; version 2.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301,

function deface_mri(subbasename,atlasbasename,atlas_deface_mask)

DIL_SZ=7;

mri_mask = [subbasename,'.mask.nii.gz'];
mri_bse = [subbasename,'.bfc.nii.gz'];

atlas_bse_mask = [atlasbasename,'.mask.nii.gz'];
atlas_bse = [atlasbasename,'.bfc.nii.gz'];

if ~exist(mri_bse,'file')
    error([mri_bse,' doesn''t exist, first run BrainSuite till BFC on the subject']);
end

out_img=[subbasename,'warpedbci.nii.gz'];
reg_mat_file=[subbasename,'warpedbci.rigid_registration_result.mat'];

% optional input
opts = struct(...
    'dof', 12, ...
    'pngout', false,   ...
    'nthreads', 2,     ... Number of (possible) parallel threads to use
    'reg_res',3, ... resolution at which registration takes place.
    'static_mask', mri_mask,...
    'moving_mask', atlas_bse_mask ...
    );

opts.similarity='sd';
%warning('off', 'MATLAB:maxNumCompThreads:Deprecated');
[M_world, ref_loc] = register_files_affine(atlas_bse,mri_bse, out_img, opts);
%warning('on', 'MATLAB:maxNumCompThreads:Deprecated');


% Apply the rigid registration to mask

output_file=[subbasename,'.deface.mask.nii.gz'];
transform_data_affine(atlas_deface_mask, 'moving', output_file, atlas_bse,mri_bse, reg_mat_file, 'nearest');
[xx,yy,zz] = ndgrid(-DIL_SZ:DIL_SZ, -DIL_SZ:DIL_SZ,-DIL_SZ:DIL_SZ);
nhoodd = sqrt(xx.^2 + yy.^2 + zz.^2) <= DIL_SZ;

v=load_nii_BIG_Lab(output_file);
v.img = imdilate(v.img, nhoodd);
save_untouch_nii_gz(v,output_file);


if exist([subbasename,'.nii.gz'],'file')
    sub_file=[subbasename,'.nii.gz'];
elseif exist([subbasename,'.nii'],'file')
    sub_file=[subbasename,'.nii'];
end

try
    check_nifti_file(sub_file);
catch
    % If there is error in the header, replace it with 1mm isotropic header.
    v1=load_untouch_nii_gz(sub_file);
    % Make the header look like BrainSuite header
    v1.hdr.hist.srow_x(1:3)=[v.hdr.dime.pixdim(2),0,0];
    v1.hdr.hist.srow_y(1:3)=[0,v.hdr.dime.pixdim(3),0];
    v1.hdr.hist.srow_z(1:3)=[0,0,v.hdr.dime.pixdim(4)];
    v1.hdr.dime.scl_slope = 0;
end

v1.img=double(v1.img).*double(v.img>0);
save_untouch_nii_gz(v1,[subbasename,'.deface.nii.gz']);

