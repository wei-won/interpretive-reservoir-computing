**************************************************************************
      Simulate ESN Model Using VAR Based On ERP Signal
**************************************************************************
This work is implemented by Wei Wang, under Prof. Zhanpeng Jin's 
supervision and guidance.


================ Contents ==================
It tries to find the connection between biological and artificial
neural networks by modeling the brain activity (EEG & ERP signals)
with reservoir computing like neural network.


================= Usage ====================
Run “run_over_single_subject.m” first to simulate several models 
in respect to a number of ERP samples of single subject with 
one specified type of stimuli, each model corresponding to one 
ERP sample. The number of REPs can be defined in the file.
 
After that, try “analyze_single_subject_with_same_stimulus.m” 
to calculate the correlation coefficients of input term and 
internal weight matrix between different models. 

“analyze_diff_stimuli_on_single_subject.m” can help calculating 
the similarities between different models of same subject but 
with different types of stimuli.

“analyze_different_subjects_with_same_stimulus.m” will analyze 
the similarities between different models of diverse subjects 
given same type of stimulus.

For the above two cases, “run_over_single_subject.m” should be 
played for multiple times in advance on the signals of specific subjects 
and stimuli types, so as to generate corresponding models.