close all; clear all; clc
pkg load control
pkg load symbolic

syms J R m g L K tau D Q V s real;

eq1 = ((J/R^2) + m) * s^2 * D == -(m*g/L) * Q;
eq2 = Q == (K/tau) * V * (1 / (s + 1/tau));

S = solve(eq1, eq2, D, V);
D_V = simplify(S.D/S.V);

s=tf('s');
J = 1e-6;
m = 0.25;
tau = 2e-3;
R = 0.01;
L = 0.45;
K = 36;
g = 9.81;

s=tf('s');
D_V = (-K*R^2*g*m)/(L*s^2*(J+R^2*m)*(s*tau+1));