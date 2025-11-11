clear all; close all; clc
pkg load symbolic;

syms s K real;

G1 = (10*s + 840) / (s^3 + 69*s^2 + 1016*s - 3696);
FDTLA = K*G1;

FdTLC = FDTLA / (1 + FDTLA);
FdTLC = simplify(FdTLC)

%Polinomio caracteristico
den = (s^3 + 69*s^2 + (1016+10*K)*s + (840*K-3696));

%coeficientes para routh
a0 = 1;
a1=69;
a2=(1016+10*K);
a3=(840*K-3696);

%calculo b1 y c1
%(a1*a2 - a0*a3)/a1
n=a1*a2;
m= a0*a3;
p = n-m;
simplify(p)

%resultado 73800 - 150K, esto debe ser mayor a 0
Kmax = 73800 / 150

%Kmin = a2 > 0
Kmin = 3696/840