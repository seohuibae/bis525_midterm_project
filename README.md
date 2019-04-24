# BiS525 Brain Dynamics Term project 2019
KAIST bis525 midterm project

### project description
We are supposed to provide you with time series of EEG (electroencephalogram) recorded from patients with
panic disorder (3 sets) (class website or by emails) and age-matched healthy subjects (3 sets). They are
measured in microvolts and represent measurements taken at the sampling frequency of 256Hz. The number
of data points is about 15,360.
1. Estimate nonlinear dynamical measures (correlation dimension, or the first positive Lyapunov exponent etc)
or information-theoretic measures (Entropy etc) of the attractor in the phase space reconstructed from the
EEG. Describe how to reconstruct the attractor and estimate the correlation dimension using embedding
procedure in detail.
2. Use the surrogate data method to determine whether your results from raw EEG is from nonlinear
determinism or not.
3. What is the clinical or physiological implication of the finding from your analysis?
4. Your term project report should follow the format of the articles in standard journals (e.g., Frontiers in
behavioral neuroscience or Scientific reports). Source codes for estimating the nonlinear measures and for
surrogate analysis should be included as an Appendix.
5. Information about EEG recording setup and subjects (both patients and healthy controls) is as follows:
- EEG Recording for the data set you are provided with was done in a 2-channel recording paradigm (Fp1, Fp2).
the signal was band-pass filtered(0 – 50Hz), and was sampled at 256Hz sampling frequency.
- You will be provided with data from healthy control subjects, as well as data from patients who have been
clinically diagnosed with panic disorder.
- Recording was done under eye-open conditions and you will be provided with two channel EEG data
corresponding to the FP1 and FP2 channels. Each data EEG recording will have data acquired continuously
from 60s of an EEG recording, totalling in about 15360 data points per EEG channel.
- Further details(Age, Gender, Specific Experiment Conditions) will be provided along with the EEG data sets
(which will be in .txt format).

### dataset 
The dataset provided for this midterm exam is an excerpt containing 2-channel EEG recordings for 3
patients in each subject group (Control, Panic disorder), meaning that there are 12 EEG recordings in
total.
They are sampled at 256Hz, and were collected from a resting state eye-open condition in which
participants were asked to fixate on a point for 1 minute and being restricted form moving both their
head and their eye gaze.
The data has been stored in tab delimited .txt files. Each txt file has two columns. The left column is the
time point, and the right column is the sampled EEG voltage.
Each patient folder has two text files. EEG-1 corresponds to recordings from the FP1 channel, and EEG-2
corresponds to recordings from the FP2 channel.
Basic subject information is provided below:
