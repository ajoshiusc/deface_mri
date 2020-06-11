function rand_str = randstr(n)
% generates a random string of lower case letters and numbers of length n


if usejava('jvm')
   tmp_name = strrep(char(java.util.UUID.randomUUID),'-','');
   while length(tmp_name)<n
      tmp_name = [tmp_name strrep(char(java.util.UUID.randomUUID),'-','')];
   end
else
   tmp_name = num2str(feature('timing','cpucount'));
   while length(tmp_name)<n
      tmp_name = [tmp_name num2str(feature('timing','cpucount'))];
   end
end

rand_str = tmp_name(1:n);

end
