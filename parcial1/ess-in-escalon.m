clear all; close all; clc
pkg load control; % Cargar el paquete de control
pkg load symbolic;

syms s real;
s=tf('s');

%DEFINO BLOQUES
G=13/(s+236);
Ct=13;
C=66*s+3234;
H=1;

%CALCULO LAZO CERRADO INTERNO
LCint=minreal(feedback(G,Ct));

%CALCULO FUNCION DE TRANSFERENCIA LAZO ABIERTO
FDT=minreal(LCint*C)

%BUSCO KP PARA EL CÁLCULO DEL ERROR
s=0;

%Kp=G*H
kp=(858*s+4.204e+04)/(s+405)*H

%CALCULO EL ERROR EN ESTADO ESTABLE PARA ENTRADA ESCALÓN
ess=1/(1+kp)

%!====================== 2 ========================
clear all; close all; clc
pkg load control; % Cargar el paquete de control
pkg load symbolic;

syms s real;
s=tf('s');

%DEFINO BLOQUES
G1=468/(s+398);
G2=134/(s+90);
H=0.1/(s+8);
k=1
%CALCULO LAZO CERRADO INTERNO
LCint=minreal(feedback(G1*G2,H));

%CALCULO FUNCION DE TRANSFERENCIA LAZO ABIERTO
FDT=minreal(LCint*k)

%BUSCO KP PARA EL CÁLCULO DEL ERROR
s=0;

%Kp=FDT
kp=( 6.271e+04* s + 5.017e+05)/(s^3 + 496*s^2 + 3.972e+04 *s + 2.928e+05),

%CALCULO EL ERROR EN ESTADO ESTABLE PARA ENTRADA ESCALÓN
ess=1/(1+kp)

% Calcular K para ess = 0.03
K_deseado = (1/0.03 - 1)/kp