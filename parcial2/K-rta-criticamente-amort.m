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


%----------------- CON CALCULO ---------------------
clc; clear all; close all;
pkg load control;

s = tf('s');
G = 2 /((s+15)*(s+3))

# Para determinar el punto de trabajo
figure; rlocus(G); sgrid(1, 10);

%vemos 2 polos s1 = -15 y s2 = -3
breakawayPoint = ((-15)+(-3))/ 2

%punto de ruptura = 9

%Condicion de modulo K = 1 / |G(pto de rup)|
denK = abs(2/((breakawayPoint+15)*(breakawayPoint+3)))
K = 1/denK


FdTLA = K*G
# Simulacion
FdTLC = minreal(feedback(FdTLA, 1))
figure; step(FdTLC);
figure; rlocus(FdTLC);
pole(FdTLC)