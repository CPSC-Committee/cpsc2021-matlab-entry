# MATLAB example code for the 4th China Physiological Signal Challenge 2021

## What's in this repository?
We implemented a threshold-based classifier that uses the coefficient of sample entropy (cosEn) of the ECG lead signals as features. This simple example illustrates how to format your MATLAB entry for the Challenge. However, it is not designed to score well (or, more accurately, designed not to do well), so you should not use it as a baseline for your model's performance.
The Matlab code contains two main sections:
1. Feature extraction: the code files (comp_cosEn. m and sampan. m ) to extract the cosEn of the ECG.
2. The threshold-based classifier: an example code (chanllenge. m) to read the data and make prediction.
3. Save Result: an example code (Result. m) to read all samples and save the running results in batches.

## How do I run this scripts?
You can run this sample entry code by starting MATLAB and running

    predict_endpoints=Result(sample_name,sample_path,save_path)

where 'sample_name' is the path to store the sample name and the sample name (RECORDS), 'sample_path' is the relative path where the recording is stored and refer to wfdb toolbox, 'save_path' is the path where the results are stored.

## How do I run my code and save my results?
Please write your developed algorithm code into the challenge.m. You should save their results as '.mat' files by record. The variable name is specified as 'predict_endpoints' and the name of the result file should be the same as the corresponding record file.

After obtaining the test results, you can evaluate the scores of your method using the [CPSC2021 score code](https://github.com/CPSC-Committee/cpsc2021-python-entry) by running

    python score_2021.py <data_path> <result_save_path>

where '<data_path>' is the folder path of the test set, '<result_save_path>' is the folder path of your detection results.

## Useful links

- [Python example code for The China Physiological Signal Challenge (CPSC2021)](https://github.com/CPSC-Committee/cpsc2021-python-entry)