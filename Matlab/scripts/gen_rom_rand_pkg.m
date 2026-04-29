clear;
rom_depth=1024;
rom_bits=16;

rom_min=-1*2^(rom_bits-1);
rom_max=2^(rom_bits-1)-1;

rom_data=randi([rom_min, rom_max],1,rom_depth);

plot(rom_data, 'bx');

fid=fopen("../rom_rand_pkg.vhd","wt");
fprintf(fid, "library IEEE;\n");
fprintf(fid, "use IEEE.STD_LOGIC_1164.ALL;\n");
fprintf(fid, "use IEEE.NUMERIC_STD.ALL;\n\n");
fprintf(fid, "package rom_rand_pkg is\n\n");
fprintf(fid, "type t_rom_array is array (0 to %d) of integer;\n\n",rom_depth-1);

fprintf(fid, "constant k_rom_rand: t_rom_array := (\n");
fprintf(fid, "%d, %d, %d, %d, %d, %d, %d, %d, \n",rom_data(1:end-8));
fprintf(fid, "%d, %d, %d, %d, %d, %d, %d, %d); \n\n",rom_data(end-7:end));

fprintf(fid, "end package rom_rand_pkg;\n");
