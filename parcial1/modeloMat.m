clear all; clc; close all;
pkg load control;
pkg load symbolic;

syms U C Y A X F s E D B real

eq1 = U - C * Y == A * X + F*s*X;
eq2 = E * Y *s - D * X + B * Y == 0;

sol = solve(eq1,eq2,U,Y);

disp("FUNCION DE TRANSFERENCIA DEL SISTEMA")
G = factor(sol.Y/sol.U,s,"s")

%VALORES
A=60;
B=3;
C=70;
D=70;
E=64;
F=4;

%REEMPLAZO LOS VALORES EN G
disp("FUNCION DE TRANSFERENCIA DEL SISTEMA CON LOS VALORES")
G = eval (G)
s = tf ("s");
G = 70 / (256 * s^2 + 3852 * s + 5080);
disp("POLOS")
pole(G)

%Para una entrada escalón
disp("VALOR DE REGIMEN PARA ENTRADA ESCALÓN")
vf = 70 / 5080
step(G);