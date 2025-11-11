%% Ejercicio 2
close all; clear all; clc
syms s Kd Kp real

G=20/(s^2+10*s);

Gd=Kd*s;
GLC=collect(G/(1+G*Gd),'s');
GLA=Kp*GLC
Kv=s*GLA
%Si Kd=10 y se busca ess<0.1, Kp>105

%!===================== 2 =====================
clc; clear all; close all;
pkg load symbolic;

syms s real;

C = 30/s;
G1 = (4*s) / (s + 400);
G2 = 17 / (s + 50);

G = C * (G1 + G2);
G = simplify(G) # Sistema de tipo 1

# Constante de error
Kp = G;
Kv = s*G;
Ka = s^2*G;

# lim s->0
s = 0;
Kp = eval(Kp);
Kv = eval(Kv)
Ka = eval(Ka);

# ess con una entrada de tipo rampa
ess_e = 1 / (1 + Kp);
ess_r = 1 / Kv
ess_p = 1 / Ka;