clear all; clc; close all;
pkg load control

s = tf('s');
G1 = (s + 10);
G2 = 1 / (s^3 + 49*s^2 - 52*s - 100);

% 4. Calcular la L(s) correcta para el LGR
% L(s) = (G1*G2) / (1+G2)
L = (G1 * G2) / (1 + G2);
L = minreal(L)
% Esto mostrará L(s) = (s+10) / (s^3 + 49s^2 - 52s - 99)

% 5. Graficar el LGR
figure(1);
rlocus(L);
title('LGR Correcto - Sistema Estable para K > 62.8');
grid on;

% 6. Confirmar el cruce y la ganancia (Pregunta 1 y 2)
% Encontramos la ganancia K donde s = j3.285
% * ESTA ES LA LÍNEA CORREGIDA *
w_cruce = 3.285; % Frecuencia de cruce
valor_L_en_cruce = freqresp(L, w_cruce); % Valor de L(jw)
Kc_cruce = 1 / abs(valor_L_en_cruce); % K = 1 / |L(jw)|

printf('--------------------------------------------------\n');
printf('RESULTADOS BASADOS EN LAS FUNCIONES ESCRITAS:\n');
printf('Pregunta 1: Rango de estabilidad K_c > %.2f\n', Kc_cruce);
printf('Pregunta 2: Frecuencia de oscilación: %.3f rad/s\n', w_cruce);

% 7. Calcular Valor Final (Pregunta 3)
Kc = 100;

% Creamos el lazo cerrado G_LC
% G_LC = (Kc*L) / (1 + Kc*L)
G_LC = feedback(Kc * L, 1);

% Usamos dcgain() para encontrar el valor final ante un escalón unitario
valor_final = dcgain(G_LC);
printf('Pregunta 3: Valor final para K_c = 100 es: %.2f\n', valor_final);
printf('--------------------------------------------------\n');