function gen_win_pkg(rom_data)

rom_depth=length(rom_data);

fid=fopen("win_pkg.vhd","wt");
fprintf(fid,"library IEEE;\n");
fprintf(fid,"use IEEE.STD_LOGIC_1164.ALL;\n");
fprintf(fid,"use IEEE.NUMERIC_STD.ALL;\n\n");
fprintf(fid,"package win_pkg is\n\n");
fprintf(fid,"type t_win_array is array (0 to %d) of integer;\n\n",rom_depth-1);

fprintf(fid,"constant k_win_array: t_win_array := (\n");
fprintf(fid,"%d, %d, %d, %d, %d, %d, %d, %d, \n",rom_data(1:end-8));
fprintf(fid,"%d, %d, %d, %d, %d, %d, %d, %d);\n\n",rom_data(end-7:end));

fprintf(fid,"end package win_pkg;\n");
fclose(fid);


