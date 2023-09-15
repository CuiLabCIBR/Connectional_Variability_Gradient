# Connectional_Variability_Gradient
Data and codes for our paper **"A Connectional Gradient of Individual Variability across Functional Connectome Edges"**.

*Inter-individual fc variability* matrices for the **HCP-D** and **HCP-YA** (typically referred as **'HCP'**) datasets, and the connectome matrices of *functional connectivity*, *individual variability in structural communicability*, *correlated gene expression* and *receptor similarity* are obtained using `Schaefer-400` (7 Networks order).  See [data](data/) for more details.

## `data`
- The [sub_info](data/sub_info) folder contains the subject information (`sub_id`,`age` and `gender`) used in this study.
- The [fc_variability](data/fc_variability) folder contains the *inter-individual fc variability* matrix for the HCP-D and HCP datasets, saved in the `.mat` file.
- The [connectome_matrix](data/connectome_matrix) folder contains the brain networks constructed by *functional connectivity*, *individual variability in structural communicability*, *correlated gene expression* and *receptor similarity*.
- The [parcellation_files](data/parcellation_files) folder contains the parcellation files used in this study.

## `functions`
The [functions](functions/) folder contains code and files commonly used in `code`.

## `miscellaneous`

The [miscellaneous](miscellaneous/) folder contains code to batch calculating Spearman's rank correlation between FC variability and other connectomes, along with confidence interval estimation using a bootstrap approach.

## `code`

- The [step_01_inter_individual_fc_variability](step_01_inter_individual_fc_variability/) folder contains codes to construct the individual functional connectivity and estimate the inter-individual variability of functional connectivity. 
- The [step_02_connectional_gradient_of_fc_variability](step_02_connectional_gradient_of_fc_variability/) folder contains codes to generate results and figures of *Fig. 1. Individual variability in edge-level FC declines along a connectional level gradient*. 
- The [step_03_white_matter_structural_connectome](step_03_white_matter_structural_connectome/) folder contains codes to generate results and figures of *Fig. 2. Individual variability in structural connectivity communicability is associated with the variability gradient in FC across connectome edges*. 
- The [step_04_correlated_gene_expression](step_04_correlated_gene_expression/) folder contains codes to generate results and figures of *Fig. 3. Correlated gene expression connectome is associated with the variability gradient in FC across edges*.
- The [step_05_receptor_similarity](step_05_receptor_similarity/) folder contains codes to generate results and figures of *Fig. 4. Connectome of neurotransmitter receptor and transporter expression is associated with FC variability gradient across edges*.
- The [step_06_development_effects](step_06_development_effects/) folder contains codes to generate results and figures of *Fig. 5. Development of the connectional variability gradient during youth*.
- The [step_07_cognitive_effects](step_07_cognitive_effects/) folder contains codes to generate results and figures of *Fig. 6. The connectional variability gradient is associated with the higher-order cognitions*.

## `wiki`
The detailed description about the codes used in this study, from `step_01_inter_individual_fc_variability` to `step_07_cognitive_effects`, can be found [here](https://github.com/CuiLabCIBR/Connectional_Variability_Gradient/wiki).

## `note`
The current repository does not include code and data used in the supplementary analyses, these will be added in the near future. The FC and SC matrices of each individual from the HCP-D and HCP-YA datasets have not been uploaded due to the limited the size of large single file.

