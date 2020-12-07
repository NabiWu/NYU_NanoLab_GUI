function multiGUI_saveData_experiment(src,event,fid,filename,One_Cycle_Samples,Cycle_Length,subtracted, SingleRun, NumSamples, gain,plots1,plots2,plots3) 

   time = event.TimeStamps; 
   plotVector = time;
   data = event.Data;
   SaveData = [time data];
   dlmwrite(filename,SaveData, '-append')

   [~,c] = size(data);
   colors = ['r' 'g' 'b' 'm' 'r' 'g' 'b' 'm' 'r' 'g' 'b' 'm' 'r' 'g' 'b' 'm'];
     
     if time(1)>= 2*Cycle_Length
     dataRead1 = csvread(filename);
     dataRead = dataRead1((SingleRun*NumSamples)+1:(2*SingleRun*NumSamples),2:end);
         for i = 1:c-1 
           ch(:,i) = mean(reshape(dataRead(:,i),SingleRun,NumSamples),2); %average the samples 
         end
    subtracted = (data(:,2:c) - ch)/gain *10^9;% first column will be analog out ramp values
    end
    
     % clear plots
      if mod(time(1),Cycle_Length)== 0
          for i = 1:c-1
              cla(plots2(i))
              cla(plots3(i))
          end
      end
            
     for i = 2:c
         axes(plots2(i-1))
         hold on
         plot(data(1:One_Cycle_Samples,1), data(1:One_Cycle_Samples,i)/gain*10^9,colors(i-1)) % need one color 
                  
         axes(plots1(i-1))
         hold on
         plot(time, data(:,i), colors(i-1))
         
         axes(plots3(i-1))
          hold on
          plot(plotVector,subtracted(1:length(plotVector),i-1),colors(i-1));
     end
   
       drawnow;
end 
