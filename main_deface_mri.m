clc;clear all;close all;
restoredefaultpath;


%% 
% This code performs defacing of brain mri by first applying rigid 
% registration and then deforming the mask from BCI-DNI brain
%
%% INPUT: 
% This following code expects that the subject.mask.nii.ga and
% subject.bfc.nii.gz exist. These files are generated by running
% BrainSuite's first two steps.

% If these files do not exist, then
% first run BrainSuite sequence on the subject MRI till BSE and BFC (the
% first two steps of BrainSuite sequence).

%% OUTPUT:
% The output is stored at <subject>.deface.mask.nii.gz and <subject>.deface.nii.gz

%%
% This is the name of the subject mri that you want to deface
subbasename = '/home/ajoshi/Desktop/temp/preMRI' %'/deneb_disk/defacing_data/1001_T1'; 

% Location of BrainSuite's BCI-DNI atlas
atlasbasename = '/home/ajoshi/BrainSuite19b/svreg/BCI-DNI_brain_atlas/BCI-DNI_brain';

% Deface mask that is included with this script. It is in the same
% directory as this code.
atlas_deface_mask = ['BCI-DNI_brain.deface.mask.nii.gz'];

aa=tic;

deface_mri(subbasename,atlasbasename,atlas_deface_mask);

toc(aa)

