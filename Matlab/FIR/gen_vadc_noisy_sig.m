function gen_vadc_pkg(rom_data)

rom_depth=length(rom_data);

fid=fopen("FIR/vadc_pkg.vhd","wt");
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

% generate virtual ADC data
Fs=100e6;
dt=1/Fs;
N=1024;
t=dt.*(0:N-1);
Fc=77e6;
As=1000;
An=100;

x=round(As*sin(2*pi*Fc.*t));
n=round(An*randn(1,length(x)));
xn=x+n;

subplot(2,1,1);
plot(xn);
xlabel('sample');ylabel('ADC code');

f=linspace(0,Fs/1e6,N);
subplot(2,1,2);
X=20*log10(abs(fft(xn,N)));
plot(f,X);
xlabel('F(MHz)');ylabel('Mag(dB)');

gen_vadc_pkg(xn);
