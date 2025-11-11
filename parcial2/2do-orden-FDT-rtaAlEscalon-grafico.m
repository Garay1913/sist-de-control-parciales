clear all; close all; clc
pkg load control

%PARCIAL 2018 - 1ER EJERCICIO

% vemos que se trata de un sistema de segundo orden
% porq notamos que tiene picos, tanto hacia arriba
% como hacia abajo, la curva oscila, tiene un solo
% pico y luego se amortigua

% Por esto usamos la FDT de un sistema de segundo orden
% clasico que es la siguiente
% G(s) = k wn^2/(s^2 + 2*psita*wn*s+wn^2)
% siendo K la ganancia estatica o valor final de la rta
% psita el coeficiente de amortiguamiento
% wn la frecuencia no amortiguada

% Primero definimos los datos que nos da la grafica
% Mp que es el sobresalto maximo u overshoot que es de
% Mp = 0.25, luego tenemos el tp, que es el tiempo del
% pico que es 0.01 y por ultimo la constante K, que
% es la ganancia estatica o valor final, k=2

Mp = 0.25;
tp = 0.01;
k = 2;

% Primero calculo Psita,
%sqrt((ln(mp))^2/pi^2 + (ln(mp))^2)

psita = sqrt((log(Mp))^2/(pi^2 + (log(Mp))^2))

%Ahora calculmos wn como wn = pi/(tp*sqrt(1-psita^2))

wn = pi /(tp * sqrt(1-psita^2))

%Solo queda armar mi funcion de transferencia
%G=tf(k*wn^2,[1 2*psita*wn wn^2])
%step(G);grid
%G = tf (numerador, denominador)

G = tf(k*wn^2, [1 2*psita*wn wn^2]);
step(G); grid;
