

% 1. Parameters & Signal Generation
Fs = 100e6;
dt = 1/Fs;
N = 2048;
t = dt.*(0:N-1);
A = 10000; % Increased amplitude for better resolution in 16-bit logic

Create a chirp signal from 70-80MHz (sitting in the 2nd Nyquist Zone)
f1 = 70e6;
f2 = 80e6;
x_adc = round(A*chirp(t, f1, t(end), f2, 'linear'));

% 2. Write Stimulus File for VHDL
This creates the text file your VHDL testbench will read
fid = fopen('hilbert\hilbert_input.txt', 'w');
for i = 1:length(x_adc)
    fprintf(fid, '%d\n', x_adc(i));
end
fclose(fid);