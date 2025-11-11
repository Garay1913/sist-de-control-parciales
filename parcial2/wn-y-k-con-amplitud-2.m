pkg load symbolic
pkg load control
close all;clear all;clc
s=tf('s')
Ymax=1.67
Yss=1.6
Tp=0.0529
#k=yss/R donde R era la amplitud del escalon
K=Yss/2

%SOBREPASAMIENTO MAXIMO
Mp=(Ymax-Yss)/Yss

%PSITA - COEF DE AMORTIGUAMIENTO
psita=sqrt(log(Mp)^2/(log(Mp)^2+pi^2))

%WN - FREC NO AMORTIGUADA
Wn=pi/(Tp*sqrt(1-psita^2))