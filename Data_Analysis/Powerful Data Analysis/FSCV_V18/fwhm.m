function [width] = fwhm(x,y)

y = abs(y) / max(abs(y));
N = length(y);
half = 0.5;

centerindex = find(y == max(y));

% first da crossing is between v(i-1)-small one & v(i)-large one
i = 2;
while sign(y(i)-half) == sign(y(i-1)-half) && (i <= N-1)
    i = i + 1;
end
interp = (half-y(i-1)) / (y(i)-y(i-1));
tlead = x(i-1) + interp*(x(i)-x(i-1));

%start search for next crossing at center
i = centerindex + (centerindex-i) - 2; % for faster performance( symmetric shape of Gaussian curve)
while ((sign(y(i)-half) == sign(y(i-1)-half)) && (i <= N-1))
    i = i + 1;
end
if i ~= N
    interp = (half-y(i-1)) / (y(i)-y(i-1));
    ttrail = x(i-1) + interp*(x(i)-x(i-1));
    width = abs(ttrail - tlead);
else
    disp("Cannot find enough indices (fwhm)");
    width = NaN;
end


