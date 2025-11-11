# ==================================================
# EJERCICIO: sacar FdT con diagrama de flujo (usando symbolic)
# ==================================================
close all; clear all; clc
pkg load symbolic
syms s G1 G2 G3 G4 G5 G6 H2 H4 H6 real;

s = tf("s");

l1 = (-1) * H2 * G2;
l2 = (-1) * H6 * G6;
l3 = (-1) * H4 * G1 * G2 * G3 * G4;
l4 = (-1) * H4 * G1 * G6;

P1 = G1 * G2 * G3 * G4 * G5;
P2 = G1 * G6 * G5;

cof1 = 1 - l2;
cof2 = 1;

numerador = (P1 * cof1 + P2 * cof2);
det = 1 - (l1 + l2 + l3) + (l1 * l2 + l2 * l3); # esta mal la resolucion del parcial xq en esa no tiene en cuenta el 4to lazo

M = factor(numerador / det);
M
