pkg load symbolic
syms s real
s=tf('s');

K=6
te=137 %te en banda de +-2%
T=te/4 %si usara el te cuando se establece. Al 100 divido te/5

%FUNCIÓN SISTEMA DE PRIMER ORDEN
G=K/(T*s+1)

%GRÁFICO PARA VERIFICAR
step(G,350);grid
ylim([0 6])