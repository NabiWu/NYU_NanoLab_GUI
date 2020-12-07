tg = uitabgroup; % tabgroup
for ii = 1:2
  if (ii==1) s = "First Two Channels";
  else s= "Second Two Chnnels";
  end
thistab = uitab(tg,'Title', s); % build iith tab
axes('Parent',thistab); % somewhere to plot
subplot(2,2,1)
x = linspace(0,10);
y1 = sin(x);
plot(x,y1)
title('Subplot 1: sin(x)')

subplot(2,2,2)
y2 = sin(2*x);
plot(x,y2)
title('Subplot 2: sin(2x)')

subplot(2,2,3)
y3 = sin(4*x);
plot(x,y3)
title('Subplot 3: sin(4x)')

subplot(2,2,4)
y4 = sin(8*x);
plot(x,y4)
title('Subplot 4: sin(8x)')

end