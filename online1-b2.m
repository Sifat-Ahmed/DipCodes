x= -360 : 5 : 360
y1= sind(x)
plot(x,y1,'.-y')
hold on
y2=sind(2*x)
plot (x,y2,'.-r')
hold on
y3=y1+y2
plot(x,y3,'.-g')
hold on
y4=y1.*y2
plot(x,y4,'.-m')
hold on


