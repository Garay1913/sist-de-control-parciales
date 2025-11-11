clc; clear all; close all;
pkg load control;
s = tf('s')
G = (96*s + 7488) / (s^3 + 64*s^2 + 1075*s + 3900)
pole(G)


# Diseñar un compensador PI para los sig. requerimientos:
# Mp = 0 => psita = 1
# ts min
# PI(s) = Kp * (s + 1/Ti) / s
# FdTLA = PI(s) * G(s)
# 1) Determinar el valor de Ti para cancelar el polo dominante
Ti = 1 / abs(max(pole(G)))
PI = (s + 1/Ti) / s;


# 2) Armo la FdTLA para dar con el punto de diseño viendo el LGR
FdTLA = (s + 1/Ti) / s * (96*s + 7488) / (s^3 + 64*s^2 + 1075*s + 3900);
figure; rlocus(FdTLA); sgrid(1, 10);


# Punto de diseño
s1 = -9.0634 + 0i;


# Calculo de Kp usando la cond. de modulo
# invK = abs(PI(s1)*G(s1)) => Kp = 1/invK
invK = abs((s1 + 1/Ti) / s1 * (96*s1 + 7488) / (s1^3 + 64*s1^2 + 1075*s1 + 3900));
K1 = 1 / invK


# 3) Simulacion
FdTLC1 = minreal(feedback(K1*FdTLA, 1));
figure; step(FdTLC1);
figure; rlocus(FdTLC1); sgrid(1, 10);

%--------------------------------------------------------------
%PUNTO B - SobrePasamiento 4% psita = 0,707
%--------------------------------------------------------------

# Diseñar un compensador PI para los sig. requerimientos:
# Mp = 4% => psita = 0.707
# ts min
figure; rlocus(FdTLA); sgrid(0.707, 10);

# Punto de diseño
s2 = -8.4893 + 8.4893i

# Calculo de Kp usando la cond. de modulo
# invK = abs(PI(s2)*G(s2)) => Kp = 1/invK

invK = abs((s2 + 1/Ti) / s2 * (96*s2 + 7488) / (s2^3 + 64*s2^2 + 1075*s2 + 3900));
K2 = 1 / invK

# Simulacion
FdTLC2 = minreal(feedback(K2*FdTLA, 1));
figure; step(FdTLC2);
figure; rlocus(FdTLC2); sgrid(0.707, 10);