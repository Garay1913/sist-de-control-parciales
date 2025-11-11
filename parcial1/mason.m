%EJERCICIO DE MASON
s = tf('s');

G1 = 1/s;
G2 = (s+10)/(s+100);
G3 = 1/s;
G4 = 1;
G5 = 10;
G6 = 1/s;

H1 = -1;
H2 = -2;

%CAMINOS DIRECTOS K =2

p1 = 8 * G1 * G2 * G3;
p2 = 8 * G4 * G5 * G6 * G3;

% GANANCIA DE LOS LAZOS
l1 = G1 * H1;
l2 = G2 * G3 * H2;
l3 = G4 * G5 * G6 *G3 * H2 * H1;
l4 = G1 * G2 * G3 * H2 * H1;

% DETERMINANTE

D = 1 -  (l1 + l2 + l3 + l4);

dk1 = 1;
dk2 = 1;

M = minreal((p1*dk1 + p2 * dk2)/D)

%!====================== 2 =========================

clc; clear all; close all;
pkg load symbolic;
syms G1 G2 G3 G4 G5 G6 H2 H4 H6 s real;

# Caminos directos de mi sistema
M1 = 8*(1/s)*((s+10)/(s+100))*(1/s)*1*4;
M2 = 8*(1/s)*((s+10)/(s+100))*10*(1/s)*4;

# Lazos de mi grafo
l1 = -1*(1/s);
l2 = -2*(1/s);

# Determinante y Dk de mi sistema
D = 1 - (l1+l2) + (l1*l2);
D1 = 1;
D2 = 1;

# FdT de mi sistema por algoritmo de Mason
Y_R = (M1*D1 + M2*D2) / D
Y_R = simplify(Y_R)



