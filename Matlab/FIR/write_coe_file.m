function write_coe_file(h,filename)

fid=fopen(filename,"wt");
fprintf(fid,"RADIX=10;\n");
fprintf(fid,"COEFDATA=\n");
fprintf(fid,"%d,\n",h(1:end-1));
fprintf(fid,"%d;\n",h(end));
