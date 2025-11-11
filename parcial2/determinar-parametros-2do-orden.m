clear all; close all; clc
pkg load control

K = 2.4;
ypico = 2.5;
tpico = 10;

Mp = (ypico - k)/K;

%calculo de psita 
psita = sqrt((log(Mp))^2/(pi^2 + (log(Mp))^2))

%Ahora calculmos wn como wn = pi/(tp*sqrt(1-psita^2))
wn = pi /(tp * sqrt(1-psita^2))

%Solo queda armar mi funcion de transferencia
%G=tf(k*wn^2,[1 2*psita*wn wn^2])
%step(G);grid
%G = tf (numerador, denominador)

G = tf(k*wn^2, [1 2*psita*wn wn^2]);
step(G); grid;