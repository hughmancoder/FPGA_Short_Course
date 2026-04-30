function gen_vadc_pkg_fn(rom_data)

rom_depth=length(rom_data);

fid=fopen("hilbert/vadc_pkg.vhd","wt");
fprintf(fid,"library IEEE;\n");
fprintf(fid,"use IEEE.STD_LOGIC_1164.ALL;\n");
fprintf(fid,"use IEEE.NUMERIC_STD.ALL;\n\n");
fprintf(fid,"package vadc_pkg is\n\n");
fprintf(fid,"type t_vadc_array is array (0 to %d) of integer;\n\n",rom_depth-1);

fprintf(fid,"constant k_vadc_array: t_vadc_array := (\n");
fprintf(fid,"%d, %d, %d, %d, %d, %d, %d, %d, \n",rom_data(1:end-8));
fprintf(fid,"%d, %d, %d, %d, %d, %d, %d, %d); \n\n",rom_data(end-7:end));

fprintf(fid,"end package vadc_pkg;\n");

end



Fs=100e6;
dt=1/Fs;
N=1024;
t=dt.*(0:N-1);
A=1000;

% create a chirp signal from 70-80MHz
% this is in the 2nd Nyquist Zone
f1=70e6;
f2=80e6;
x=round(A*chirp(t,f1,t(end),f2,'linear'));

% This creates the text file your VHDL testbench will read
fid = fopen('hilbert\hilbert_input.txt', 'w');
for i = 1:length(x_adc)
    fprintf(fid, '%d\n', x_adc(i));
end
fclose(fid);

gen_vadc_pkg_fn(x_adc);

% --- Plotting Section ---
figure('Name', 'ADC Input Signal Analysis');

% Time Domain Plot (Zoomed in to see oscillations)
subplot(2,1,1);
plot(t(1:200)*1e6, x_adc(1:200));
title('Chirp Signal Time Domain (First 200 Samples)');
xlabel('Time (\mus)');
ylabel('Amplitude');
grid on;

% Frequency Domain Plot
subplot(2,1,2);
L = length(x_adc);
Y = fft(x_adc);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

plot(f/1e6, P1);
title('Single-Sided Amplitude Spectrum of x_{adc}');
xlabel('f (MHz)');
ylabel('|P1(f)|');
grid on;
