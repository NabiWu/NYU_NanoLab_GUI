daq.reset
daq.HardwareInfo.getInstance('DisableReferenceClockSynchronization',true);  % This is to overcome a different issue
d = daq.getDevices;
s = daq.createSession('ni');
ch = addAnalogOutputChannel(s,'Dev1','ao0','Voltage');
lh = addlistener(s, 'DataRequired', @queueMoreData);
s.IsContinuous = true;
queueOutputData(s,linspace(-1, 1, 1000)');
startBackground(s);

s = daq.createSession('ni');
addAnalogOutputChannel(s,'cDAQ1Mod2',0,'Voltage');
s.IsContinuous = true;
s.Rate = 10000;
data = linspace(-1,1,5000)';
lh = addlistener(s,'DataRequired', ...
         @(src,event) src.queueOutputData(data));
queueOutputData(s,data)
startBackground(s);

