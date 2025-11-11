clear; clc; close all;
pkg load control   % Activamos funciones de control

s = tf('s');       % Variable en Laplace
K = 121;           % Valor que hace al sistema críticamente amortiguado

G = 1/((s+2)*(s+24));  % Planta del ejercicio
T = feedback(K*G, 1); % Lazo cerrado con retroalimentación unitaria

pole(T)            % Mostramos los polos del sistema

step(T)            % Graficamos la respuesta al escalón
grid on            % Activamos la grilla para ver mejor
title('Respuesta al escalón con K = 121')

% 3. Graficar el Lugar de las Raices
rlocus(G);
title('Lugar Geométrico de las Raíces para G(s)K');
xlabel('Eje Real');
ylabel('Eje Imaginario');
grid on;
