clear all; clc; close all;
pkg load control

s = tf('s');
num_G = 3.1;
den_G = [1, 42.6, 679.7, 4924, 1.408e04];
G = tf(num_G, den_G)

% 1: Determinar la constante Td
% Encontramos todos los polos de G(s)
polos_G = pole(G)
% Los polos son:
%  -14.988
%  -11.922
%  -7.845 + 4.154i  <-- Polo dominante
%  -7.845 - 4.154i  <-- Polo dominante

% El polinomio de cancelación es (s - p1)(s - p2) = s^2 + a*s + b
% donde 'a' = 2 * abs(real(polo_dominante))
a = 2 * abs(real(polos_G(3))); % Usamos el polo complejo

% El numerador del PID (normalizado) es s^2 + (1/Td)s + ...
% Igualamos el término 's': 1/Td = a
Td = 1 / a

% 2: Kp para un Sobrepasamiento del 12%%
% Tras la cancelación, el sistema simplificado para el LGR es:
% L(s) = Kp * G_simplificada, donde
% G_simplificada = 3.1 / (s * (s+14.988) * (s+11.922))
% (El 's' viene del integrador 1/Ti del PID)
printf('\n--- Pregunta 2: Cálculo de Kp ---\n');
printf('L(s) simplificada para el LGR:\n');
L = 3.1 / (s * (s + abs(polos_G(1))) * (s + abs(polos_G(2))))

% 1. Calcular Zeta (psita) para Mp=12%
Mp = 0.12;
psita = -log(Mp) / sqrt(pi^2 + (log(Mp))^2);
printf('Zeta (psita) para Mp=12%%: %.3f\n', psita);

% 2. Graficar el LGR y la línea de Zeta
figure;
rlocus(L);
sgrid(psita, []); % Dibuja la línea para Zeta = 0.559 y Wn vacío
title('LGR del Sistema Simplificado (Click para Kp)');

% Definimos el punto de trabajo
s_visual = -3.5038 + 5.20j; 

% Calculamos el valor de L en ese punto
val_L = 3.1 / (s_visual * (s_visual + 14.9881) * (s_visual + 11.9224));

% Calcula Kp
Kp_calculado = 1 / abs(val_L)

% Pregunta 3: Valor Final
% La pregunta es ambigua.
% Si se usa el PID, el sistema es Tipo 1 (error cero).
% Si se usa solo Kp, el sistema es Tipo 0 (error finito).
printf('\n--- Pregunta 3: Valor Final ---\n');

% Asunción 1: Con el PID diseñado (Sistema Tipo 1)
% El integrador (1/s) asegura que el error e_ss sea 0.
A = 3; % Amplitud del escalón
yss_pid = A; % El valor final es igual a la amplitud
printf('Interpretación 1 (Con PID, Tipo 1): yss = %.1f (error es 0)\n', yss_pid);

% Asunción 2: Con solo Controlador Proporcional Kp=100 (Sistema Tipo 0)
Kp = 100;
% Kpos = lim s->0 Kp*G(s) = Kp * G(0)
% dcgain(G) calcula G(0)
Kpos = Kp * dcgain(G);
% yss = A * Kpos / (1 + Kpos)
yss_p = A * Kpos / (1 + Kpos);
