%INITIALIZE MATLAB
close all;
clc;
clear all;



%MEASURED DATA
Timems = [];
SubtractedCurrentnA = [];

%DEFINE TOLERANCE
tol = 1e-6;


%DETERMINE NUMBER OF SAMPLES
M = length(Timems);


%MAKE AN INTELLIGENT INITIAL GUESS 
A = max(SubtractedCurrentnA);
x0 = mean(Timems);
s = 0.5*(max(Timems)-min(Timems));



%
%MAIN ITERATION LOOP
%
err = inf;
while err > tol
    
    %Compute ColumnVector f
    f = A*exp(-((Timems-x0)/s).^2);
    
    
    %Calculate Column Vector d
    d = SubtractedCurrentnA - f;
    
    
    %Construct Z Matrix 
    z1 = f/A;
    z2 = 2*f.*(Timems-x0)/S^2;
    z3 = 2*f.*(Timems-x0).^2/s^3;
    Z = [ z1 z2 z3];
    
    %Updata Coefficients 
    da = (Z.'*Z)\(Z.'*d);
    A = A + da(1);
    x0 = x0 +da(2);
    s = s + da(3);
    
    
    %Calculate Error 
    err = max(abs(da./[A;x0;s]));
    
    
end

%OPEN A FIGURE WINDOW 
figure ("Color", "w", "Position", [391,5000 287.5000 688 420]);



%COMPUTE GAUSSIAN
x = linespace (0,6,1000);
f = A*exp(-((x-x0)/s).^2);


%SHOW GAUSSIAN
plot (Timems, SubtractedCurrentnA, "xr", "LineWidth",2);
hold on;
plot (x,f,"-b","LineWidth",1);
hold off;
axis equal tight; 
xlim([0 4]);
ylim([-0.5 4]);
xlable("$x$-axis","Interpreter", "LaTex");
ylable("$f(x)$", "Interpreter", "LaTex", 0,...
        "HorizontalAlignment", "right");

    
title ("GAUSSIAN FIT USING NONLINEAR REGRESSION");
 










