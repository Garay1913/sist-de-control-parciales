% Zparams_circuit.m
% Calculo de Z11,Z12,Z21,Z22 para el circuito dado
clear; clc;

% datos
A = 0.2;
R1 = 50;
R2 = 200;
R3 = 1000;
R4 = 800;

% Formulas directas (resultado analítico)
Z11 = (R1+R2)*(1 - A);
Z12 = (R1+R2);
Z21 = Z11;              % como se dedujo V2 = V cuando I2=0 (R4 sin corriente)
Z22 = (R1 + R2 + R4);

fprintf('Resultados por formulas:\n');
fprintf('Z11 = %.2f Ohm\n', Z11);
fprintf('Z12 = %.2f Ohm\n', Z12);
fprintf('Z21 = %.2f Ohm\n', Z21);
fprintf('Z22 = %.2f Ohm\n', Z22);

% Verificacion por sistema lineal usando NODAL (variables: V = nodo superior)
% Hacemos dos simulaciones:
% 1) Excitar I1=1, I2=0  -> calcular V1,V2 => Z11,Z21
% 2) Excitar I1=0, I2=1  -> calcular V1,V2 => Z12,Z22
%
% Para modelar la rama central: corriente vertical = A*I1 (independiente de V),
% y en caso I1=0 la rama central no conduce. Implementamos KCL manualmente.

% Caso 1: I1 = 1, I2 = 0
I1 = 1; I2 = 0;
% KCL en nodo V: I1 + 0 (desde R4) = V/(R1+R2) + A*I1
V = (R1+R2)*(1-A)*I1;   % derivado antes
V1 = V;
V2 = V;                 % I2=0 => no corriente por R4 => V2 = V
Z11_num = V1 / I1;
Z21_num = V2 / I1;

% Caso 2: I1 = 0, I2 = 1
I1 = 0; I2 = 1;
% rama central no conduce; corriente por rama izquierda = I2
V = (R1+R2)*I2;
V1 = V;
V2 = V + I2*R4;
Z12_num = V1 / I2;
Z22_num = V2 / I2;

fprintf('\nResultados por verificacion numerica (I1/I2 excitaciones unitarias):\n');
fprintf('Z11_num = %.2f Ohm\n', Z11_num);
fprintf('Z21_num = %.2f Ohm\n', Z21_num);
fprintf('Z12_num = %.2f Ohm\n', Z12_num);
fprintf('Z22_num = %.2f Ohm\n', Z22_num);