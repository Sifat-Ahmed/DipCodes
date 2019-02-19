x = [-360:5:360];
y1 = sind(2*x);
y2 = cosd(2*x);
y3 = sind(x)+sind(2*x);
y4 = y1 + y2 + y3;
figure;
plot(x,y1,'b',x,y2,'c',x,y3,'m',x,y4,'y')
