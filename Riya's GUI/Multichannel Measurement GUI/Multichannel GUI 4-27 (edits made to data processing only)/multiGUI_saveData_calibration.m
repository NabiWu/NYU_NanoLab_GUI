function multiGUI_saveData_calibration(src,event,fid,filename,plots1) 

   time = event.TimeStamps; 
   data = event.Data;
   
   SaveData = [time data];
   dlmwrite(filename,SaveData, '-append')

   [~,c] = size(data);
   colors = ['r' 'g' 'b' 'm' 'r' 'g' 'b' 'm' 'r' 'g' 'b' 'm' 'r' 'g' 'b' 'm'];

     for i = 2:c
         axes(plots1(i-1))
         hold on
         plot(time, data(:,i), colors(i-1))
     end
      
       drawnow;
end 
