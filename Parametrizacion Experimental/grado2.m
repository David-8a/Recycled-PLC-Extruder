%Construimos el vector tiempo
T = t(1):t(end)/(length(t)-1):t(end);

%Construimos un filtro de 1er orden
s = tf("s");
filtro = 1/(10*s+1);

%Filtramos las señales de voltaje
Yf = lsim (filtro,Y,T);


%%%%%%%
% Para grado 2 - Hacer calculos y definir parametros
T_step = T(sum(U<5));

%%% Se identifica la ganancia Gamma
gamma =  (Yf(end)-Yf(1))/(U(end)-U(1));


%%% Los instantes seleccionados por Stark son los tiempos requeridos para
%%% que la respuesta alcance el 15%, el 45% y el 75%
[m1,t1] = min(abs(Yf - Yf(end)*0.15));
[m2,t2] = min(abs(Yf - Yf(end)*0.45));
[m3,t3] = min(abs(Yf - Yf(end)*0.75));
t1 = T(t1)-T_step;
t2 = T(t2)-T_step;
t3 = T(t3)-T_step;

%%% Para calcular los parametros del sistema debemos realizar las
%%% siguientes ecuaciones
x = (t2-t1)/(t3-t1);
C = (0.0805-(5.547*(0.475-x)^2))/(x-0.356);

if C > 1
    F2C = 2.6*C - 0.6;
else
    F2C = 0.708*(2.811^2);
end

%%% Calculo de la frecuencia natural
omega_n = F2C/(t3-t1);

%%% Luego se cálcula el retardo
F3C = 0.922*(1.66^C);
theta = t2 - (F3C/omega_n);

if theta < 0
    theta = 0;
end

%%% Para calcular los Tau
if C >= 1
    Tau1 = (C+sqrt((C^2)-1))/omega_n;
    Tau2 = (C-sqrt((C^2)-1))/omega_n;
    G = (gamma/(((Tau1*s)+1)*((Tau2*s)+1)))*exp(-theta*s);
else
    G = (gamma/((s^2)+(2*C*omega_n*s)+(omega_n^2)))*exp(-theta*s);
end

%%%%%%%

Ye = lsim(G,U,T);

plot(T,U,T,Yf,T,Ye)
