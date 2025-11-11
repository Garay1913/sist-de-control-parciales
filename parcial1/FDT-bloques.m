clear all; close all; clc
pkg load control;
s=tf('s');

%Defino mis bloques
G1=(s+87)/(s+49);
G2=85*s+1785;
C=(56*s+3528)/s;

%Calculo mi FDTLC
FDTLC=minreal(feedback(C*feedback(G1,G2),1))

% !===================== 2 =====================
% C -> G1 -> G2---> +
%    |             | 
%    |-> G3 ------>| 

close all; clear all; clc
syms s K real

G1=66/(s+18);
G2=(s+71)/(s+4);
G3=(s+28)/(s+5);
C=(10*s+83)/s;

% Ganancia de lazo L(s) = C * (G1*G2 + G3)
L = simplify(C * (G1*G2 + G3));

% FDTLC
T = simplify( L / (1 + L) )

