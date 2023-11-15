%Quitamos los valores iniciales
%Y = h-h(1);
%U = max(0,u-40);

%Construimos el vector tiempo
T2 = t(1):t(end)/(length(t)-1):t(end);

%Construimos un filtro de 1er orden
s = tf("s");
filtro = 1/(10*s+1);

%Filtramos las señales de voltaje
Yf = lsim (filtro,Y,T2);


%%%%%%%
% Para grado 1 - Hacer calculos y definir gamma, theta y tau
T_step = T2(sum(U<5));
gamma =  (Yf(end)-Yf(1))/(U(end)-U(1));

[m1,t1] = min(abs(Yf - Yf(end)*0.283));
[m2,t2] = min(abs(Yf - Yf(end)*0.632));
t1 = T2(t1)-T_step;
t2 = T2(t2)-T_step;
theta = (t2 - (3*t1))/(1-3);
tau = 3*(t1-theta);

%%%%%%%

%%%%%%%
% Para grado 1 sin smith - Hacer calculos y definir gamma, theta y tau

%gamma1 =  (Yf(end)-Yf(1))/(U(end)-U(1));

%[m3,t3] = min(abs(Yf - Yf(end)*0.9502));
%t3 = T(t3);
%tau1 = t3/3;

%%%%%%%

G = (gamma/((tau*s)+1))*exp(-theta*s);
Ye = lsim(G,U,T2);

plot(T2,U,T2,Yf,T2,Ye)




