clear;
rom_depth=1024;
rom_bits=16;

t=0:rom_depth-1;
w=(2*pi/rom_depth)*t;
a=2^(rom_bits-1)-1;

rom_data_i=round(a*cos(w));
rom_data_q=round(a*sin(w));

plot(rom_data_i, 'r');
hold on;
plot(rom_data_q, 'b');
hold off;

fid=fopen("dds_pkg.vhd", "wt");
fprintf(fid, "library IEEE;\n");
fprintf(fid, "use IEEE.STD_LOGIC_1164.ALL;\n");
fprintf(fid, "use IEEE.NUMERIC_STD.ALL;\n\n");
fprintf(fid, "package dds_pkg is\n\n");
fprintf(fid, "type t_dds_array is array (0 to %d) of integer;\n\n", rom_depth-1);

fprintf(fid, "constant k_cos_table: t_dds_array := (\n");
fprintf(fid, "%d, %d, %d, %d, %d, %d, %d, %d, \n", rom_data_i(1:end-8));
fprintf(fid, "%d, %d, %d, %d, %d, %d, %d, %d); \n\n", rom_data_i(end-7:end));

fprintf(fid, "constant k_sin_table: t_dds_array := (\n");
fprintf(fid, "%d, %d, %d, %d, %d, %d, %d, %d, \n", rom_data_q(1:end-8));
fprintf(fid, "%d, %d, %d, %d, %d, %d, %d, %d); \n\n", rom_data_q(end-7:end));

fprintf(fid, "end package dds_pkg;\n");
