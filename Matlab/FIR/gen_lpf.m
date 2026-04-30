function hint = gen_lpf()
% generate filter
Fs=100e6;
Fpass=2e6;
Fstop=10e6;
Ntaps=32;
Nbits=16;

% parks-mcclellan filter
h=firpm(Ntaps-1,[0 Fpass/(Fs/2) Fstop/(Fs/2) 1],[1 1 0 0],[1 1]);

% convert to integers
g=2^(floor(log2((2^(Nbits-1))/max(h))));
hint=round(g.*h);

% plot filter
subplot(2,1,1);
plot(hint,'bx-');
title('Filter Taps');

subplot(2,1,2);
fftsize=2048;
H=20*log10(abs(fft(hint,fftsize)));
H=H-max(H);
f=linspace(-Fs/2/1e6,Fs/2/1e6,fftsize);
plot(f,fftshift(H),'b');

% write to coe file
write_coe_file(hint,"FIR/lpf.coe");
