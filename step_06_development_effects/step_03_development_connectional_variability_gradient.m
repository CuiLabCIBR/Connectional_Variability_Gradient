% ---------------------------------------------------------------------------------------------------------------
% This script was used to generate results of Figure 5
% <Development of the connectional variability gradient during youth>
% Participants from HCP-D were divided using sliding windows, length = 50, step = 5.
% ---------------------------------------------------------------------------------------------------------------

clear
clc

root_dir = 'F:/Cui_Lab/Projects/Connectional_Variability_Gradient/';
addpath(genpath(root_dir))

working_dir = [root_dir 'step_06_development_effects/'];
var_dir = [root_dir 'data/fc_variability/schaefer400/'];
data_dir = [var_dir 'age_effects/'];

load('7net_label_schaefer400.mat')
% We excluded the limbic network in this study.
net_order = [1 2 3 4 6 7]; %1 VIS 2 SMN 3 DAN 4 VAN 5 LIM 6 FPN 7 DMN.

% Load HCP-YA as reference for gradient alignment
load([var_dir 'fc_variability_hcp.mat'])
var_ref = fc_variability_hcp.schaefer400;
var_ref_net = get_matrix_mean(var_ref,net_label,net_order);

load([working_dir,'hcpd_development_info.mat'])
group_num = length(Age);

%%
idx = find(tril(ones(6,6)));

gradient_label = {'alignment_nodal','slope_net'};
gradient_mat = zeros(group_num,2);
gradient_mat_reg_fc = zeros(group_num,2);

for group_i = 1:group_num    
    group_i
    load([data_dir 'lme_' num2str(group_i) '.mat'])
    icc = lme.ICC_c;
    fc_variability_mat = squareform(icc);
    fc_variability_mat_mean = get_matrix_mean(fc_variability_mat,net_label);
    fc_variability_mean(group_i,:) = fc_variability_mat_mean(idx);

    % gradient alignment
    gradient_mat(group_i,1) = corr_matrix(fc_variability_mat,var_ref,net_label,net_order,'Spearman');

    % gradient slope
    var_temp = fc_variability_mean(group_i,:);
    var_temp = sort(var_temp,'descend');
    mdl = fitlm((1:length(var_temp))./length(var_temp),var_temp);
    gradient_mat(group_i,2) = abs(table2array(mdl.Coefficients(2,1)));
end

%%
clc

for i = 1:2
    Gradient = gradient_mat(:,i);
    tbl = table(Age,Gender,HeadMotion,Gradient,'VariableNames',{'Age','Gender','HeadMotion','Gradient'});

    % used in step_04_plot_gam_development.R
    writetable(tbl,[working_dir 'gam_age_' gradient_label{i} '.csv'])
end
