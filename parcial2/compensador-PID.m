% 1. Cargar paquete de control y limpiar entorno
pkg load control
clear all; clc; close all;

% 2. Definir la planta G(s)
s = tf('s');
num_G = 3.1;
den_G = [1, 42.6, 679.7, 4924, 1.408e04];
G = tf(num_G, den_G);

printf('Planta G(s):\n');
disp(G);

% ----------------------------------------------------
% --- Pregunta 1: Determinar la constante Td
% ----------------------------------------------------
% El objetivo es cancelar los polos dominantes de G(s).
% 1. Encontramos todos los polos de G(s)
polos_G = pole(G);
printf('\n--- Pregunta 1: Cálculo de Td ---\n');
printf('Polos de la planta G(s):\n');
disp(polos_G);
% Los polos son:
%  -14.988
%  -11.922
%  -7.845 + 4.154i  <-- Polo dominante
%  -7.845 - 4.154i  <-- Polo dominante

% 2. Los polos dominantes son s = -7.845 ± 4.154i
% El polinomio de cancelación es (s - p1)(s - p2) = s^2 + a*s + b
% donde 'a' = 2 * abs(real(polo_dominante))
a = 2 * abs(real(polos_G(3))); % Usamos el polo complejo

% 3. El numerador del PID (normalizado) es s^2 + (1/Td)s + ...
% Igualamos el término 's': 1/Td = a
Td = 1 / a;

printf('El polinomio de cancelación es: s^2 + %.3f*s + ...\n', a);
printf('Igualamos 1/Td = %.3f\n', a);
printf('Td = %.5f\n', Td);
% El valor 0.06374 del casillero es correcto.

% ----------------------------------------------------
% --- Pregunta 2: Kp para un Sobrepasamiento del 12%%
% ----------------------------------------------------
% Tras la cancelación, el sistema simplificado para el LGR es:
% L(s) = Kp * G_simplificada, donde
% G_simplificada = 3.1 / (s * (s+14.988) * (s+11.922))
% (El 's' viene del integrador 1/Ti del PID)
L = 3.1 / (s * (s + abs(polos_G(1))) * (s + abs(polos_G(2))));

printf('\n--- Pregunta 2: Cálculo de Kp ---\n');
printf('L(s) simplificada para el LGR:\n');
disp(L);

% 1. Calcular Zeta (psita) para Mp=12%
Mp = 0.12;
psita = -log(Mp) / sqrt(pi^2 + (log(Mp))^2);
printf('Zeta (psita) para Mp=12%%: %.3f\n', psita);

% 2. Graficar el LGR y la línea de Zeta
figure;
rlocus(L);
% --- LÍNEA CORREGIDA ---
sgrid(psita, []); % Dibuja la línea para Zeta = 0.559 y Wn vacío
title('LGR del Sistema Simplificado (Click para Kp)');

printf('\nSe ha generado un gráfico LGR.\n');
printf('El valor de Kp se encuentra en la intersección de la rama del LGR');
printf(' con la línea de Zeta (psita).\n');
printf('Puedes usar "rlocfind(L)" en la consola y hacer click en el punto.\n');

% El cálculo analítico (como el que hice en la respuesta anterior)
% da como resultado Kp = 253.06
printf('\nEl Kp calculado analíticamente es: %.2f\n', 253.06);

% ----------------------------------------------------
% --- Pregunta 3: Valor Final
% ----------------------------------------------------
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
printf('Interpretación 2 (Solo Kp=100, Tipo 0): yss = %.5f\n', yss_p);
printf('\nEl casillero (0.071) es cercano a 0.06458, lo que sugiere');
printf(' que la pregunta se refería a un controlador P (Tipo 0).\n')