# NYU_NanoLab_GUI

IN THIS README, I PROVIDE THE BRIEF INTRODCUTION FOR EACH DIRECTORY OF THIS REPO. 


1. In the Data_Analysis directory, I uploaded the two folders. One is the previous data analysis code. The second is the current one that has been already implemented in our GUI. Both versions works propertly, but the second one with more powerful functionality with more detailed plot and information. For people who want to understand the main algorithm for the FSCV data analysis, I recommended to read and understand the previous code at first (which I think it will be useful to understand the final version). The more powerful data analysis code runs in the main18.m as the main file which we call the 'sub-selfmade-function' in it (which I think it looks neat). All the 'sub-selfmade-functions' are also included in the same folder with easy-understanding comments. 


2. The Final GUI (Everything Needed) folder contains the main GUI code, the data analysis code (which we discuss preciously), and all functions mainly control the real-time visualizations. Users could directly study those files in order to understand the fundamentals of the GUI and how it works. The main file also provides needed comments for easy understanding.

3. The FirmWare folder contain verilog files as well as the bit file (chip4_adc_cont.bit). We generate the bit file using the main verilog file (CHIP4_ADC_CONT.v). Please make sure place the bit file into the same directory while you run the GUI. This bit file will allow the FPGA correctly works while doing measurement.


4. The Functionality folder contains some useful MATLAB code (maybe not being used in the final version, but still valueable to take a look). For example, the MultipleTabs folder includs some of my own designs and online sources for generating the multiple tabs user interface which is very useful since we have 4 channels during measurement. The RampSignal folder includs how to generate the ramp signal array; and the daqControl folder includes how to control the NI-DAQ to generate the signal you want. (In our case, we ONLY generate ramp signal and N-shape). There are also other interesting functionality files including how to build a timer, how to generate N-shape signal, how to save the fetched data and so on. 


5. The Kae-Dyi You GUI folder contains the most basic version of GUI. The GUI looks simple but easier to understand. The code is much shorter. If you confused to read the code in the final version of GUI, please take a look at this. 


6. The Paper folder includes some related paper which will give you sense of why we made GUI, what can we do uing the GUI, as well as some of the interesting machine learning techiques.


7. The PresentationPDF contains some of my personal weekly meeting slide. Don't hesitate to open it. I won't be mad at you.


8. Riya's GUI is the resources provided by Ting Wu. I am not sure whether or not her version will be work. But it will definitely provide you some ideas while you are designing your own GUI 


9. Small GUI Examples folder has some very interesting GUI programs that will make your GUI looks professional and neat. You can open the contents.html to guide you for more informations. You can also play around with them to see if they fit your GUI or not.


10. The new_GUI1.0/2.0/3.0 are three folders include all three versions of my GUI. Each version of GUI looks very different but with similiar functionality. All GUIs are labeled in chronoligical order to show how the final version of GUI has been developed. BTW, it is not super important to understand them all as long as you fully understand the final version of GUI. But it is important if you are curious about how it was developed by adding every small features.
