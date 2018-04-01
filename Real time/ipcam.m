url = 'http://192.168.43.1:8080';
ss  = imread(url);
fh = image(ss, 'Parent', handles.ax);
while(1)
      ss  = imread(url);
      set(fh,'CData',ss);
      drawnow;
end