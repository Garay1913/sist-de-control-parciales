# RTA TRANSITORIA SIST 1ER ORDEN
# EJERCICIO 9
# ========================================
# recordatorio, dependiendo de que % de error tomemos para la banda de yss
# va a cambiar cuantos tau vale el tiempo de establecimiento
# banda de +-5% -> ts=~3tau
# banda de +-2% -> ts=~4tau
# banda de +-1% -> ts=~5tau
close all; clear all; clc
yss = 6;
# el problema marca 2 puntos:
# a) y(176 seg)=5,96 (osea el 99,3% de yss)
ts99 = 176;
# b) y(137 seg)=5,88 (osea el 98% de yss)
ts98 = 137;

K = yss;
tau99 = ts99/5
tau98 = ts98/4

# ========================================
# EJERCICIO 10
# ========================================
close all; clear all; clc
yss = 4;
# el problema marca 2 puntos:
# a) y(282 seg)=3,97 (osea el 99,25% de yss)
ts99 = 282;
# b) y(219 seg)=3,92 (osea el 98% de yss)
ts98 = 219;

K = yss;
tau99 = ts99/5
tau98 = ts98/4

