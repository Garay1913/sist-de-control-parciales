clear all; clc; close all;
pkg load control;
pkg load symbolic;

syms K R L I s X Y V real

eq1= K*s*X + R*I + L*s*I ==V;
eq2= (s^2)*X - X - I ==0;

Sol=solve(eq1,eq2,V,X);
disp('Función de Transferencia del Sistema: ')
G=factor(Sol.X/Sol.V,s,'s')

%Valores:
R=10;
L=0.1;
K=10;

%Funcion de transferencia con valores
G=eval(G)
s=tf('s');
G=1/(0.1*s^3+10*s^2+9.9*s-10);
pole(G) %Polos:
%PARECE SER INESTABLE