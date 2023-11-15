a = 3650;
b = 26000;

tm = t(a:b);
ym = y(a:b) - y(a);
um=(tm>tu(4))*10;
tm = tm - tm(1);

plot(tm,ym,tm,um)

KP = (0.9*tau)/theta;
TI = theta/0.3;
KI = KP/TI;
KD = 0;