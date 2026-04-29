function gen_vadc_pkg_fn(rom_data)

rom_depth=length(rom_data);

fid=fopen("vadc_pkg.vhd","wt");
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

% 1. Setup parameters and generate the signal 'x'
Fs=100e6;
dt=1/Fs;
N=1024;
t=dt.*(0:N-1);
Fc=5e6;
A=1000;

x=round(A*sin(2*pi*Fc.*t));

subplot(2,1,1);
plot(x);
xlabel('sample');ylabel('ADC code');

f=linspace(0,Fs/1e6,N);
subplot(2,1,2);
X=20*log10(abs(fft(x,N)));
plot(f,X);
xlabel('F(MHz)');ylabel('Mag(dB)');


gen_vadc_pkg_fn(x);