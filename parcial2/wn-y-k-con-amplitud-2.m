pkg load symbolic
pkg load control
close all;clear all;clc
s=tf('s')
Ymax=1.67
Yss=1.6
Tp=0.0529
A = 2;

#k=yss/A donde A era la amplitud del escalon
K=Yss/A

%SOBREPASAMIENTO MAXIMO
Mp=(Ymax-Yss)/Yss

%PSITA - COEF DE AMORTIGUAMIENTO
psita=sqrt(log(Mp)^2/(log(Mp)^2+pi^2))

%WN - FREC NO AMORTIGUADA
Wn=pi/(Tp*sqrt(1-psita^2))