% compensador con metodo de la bisectriz
close all; clear all; clc
pkg load control
%% me dan de dato PSITA y WN, ademas piden que sea en el menor tiempo de establecimiento posible


% G = (s+5)/(s*(s+2+2i)*(s+2-2i)) = (s+5)/(s*(s^2 + 4s + 8))
num = [1 5];
den = [1 4 8 0];
G = tf(num, den)
wn=8 ; psita=0.4; % requerimientos

% necesito compensar o con ajustar ganancia estoy? si hace falta
rlocus(G); sgrid(psita, wn);

% pto de diseño 
s1 = -psita * wn+ i * wn * sqrt(1-psita^2) % -2.0000 + 3.4641i

% condicion de angulo:
%% AngZ - AngP + AngC = 180°*(2i+1)
%% AngC = -180° + AngP - AngZ
[z, p, ~] = zpkdata(G, 'v') % ceros y polos
suma_angulos_polos = sum(angle(s1-p)) % radianes
suma_angulos_ceros = sum(angle(s1-z))
ang_comp = mod(rad2deg(pi + suma_angulos_polos - suma_angulos_ceros), 360)
%ang_comp = 30° > 0° -> Compensador en adelanto; sino atraso


% metodo bisectriz
ang_bis = 180 - acosd(psita)
ang_aux1 = 180  - acosd(psita) - (ang_bis/2 - ang_comp/2)
ang_aux2 = 180  - acosd(psita) - (ang_bis/2 + ang_comp/2)

%% Aplicando el teorema del seno
if (ang_comp>0)
%% Para compensador en adelanto
    zc = -sind(ang_bis/2 - ang_comp/2) * abs(s1)/sind(ang_aux1)
    pc = -sind(ang_bis/2 + ang_comp/2) * abs(s1)/sind(ang_aux2)
else
%% Para compensador en atraso
    pc = -sind(ang_bis/2 - ang_comp/2) * abs(s1)/sind(ang_aux1)
    zc = -sind(ang_bis/2 + ang_comp/2) * abs(s1)/sind(ang_aux2)
end


%% Validar los valores del polo y cero
C = zpk(zc,pc,1)

hold on;
rlocus(G);
rlocus(C*G);
legend ("Sistema Original", "Sistema Compensado")
sgrid (psita, wn)

%% Determinar el valor de la ganancia del compensador aplicando la condición de módulo
% tmb se puede hacer a ojo con: rlocusx(C*G)
[num, den] = tfdata(C*G, "v")
K = 1/abs(polyval(num,s1)/polyval(den,s1))%polyval -> Dado un polinomio X, lo valua en el punto s1

%% finalmente, el compensador queda:
C = K*C

%% Verificación mediante simulación: (simular esto por separado porque se suma al anterior grafico)
FdTLC = (feedback(C*G,1))
FdTModelo = tf(wn^2, [1 2*psita*wn, wn^2])
step (FdTModelo, FdTLC);
legend ("Modelo", "Sistema")
