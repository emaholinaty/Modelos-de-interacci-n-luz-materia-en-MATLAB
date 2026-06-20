clear
close all;
clc

% Datos numéricos
c=1; % velocidad de la luz 
L=1; % longitud del medio

% Discretización de tiempo
t_f=6*L;
delta_t=0.005;        
t=0:delta_t:t_f;
Nt=numel(t);

% Discretización de x
delta_x=0.01;     
x=delta_x:delta_x:L-delta_x; % puntos de la onda
Nx=numel(x); % # puntos de la onda

% Parámetro de la ecuación de ondas
alpha=(c*delta_t/delta_x)^2;

% Matriz de la segunda derivada
a0=-2*ones(Nx,1);
a1=ones(1,Nx-1);
A=diag(a0,0)+diag(a1,-1)+diag(a1,1);
I=eye(Nx);

% Condiciones iniciales
n=12; % A mayor n mayor frecuencia (n=modos de propagación luz)
u_ex0=sin(n.*pi.*x');  % Potencial externo en el instante cero como vector columna
V0=0*x';        % Derivada temporal del potencial en el instante cero 
U0=u_ex0;            % Potencial en el instante cero (el mismo que el potencial externo)
U_t=U0+delta_t*V0; 

T=[U0 U_t]; % T guarda la trayectoria

 for i=1:Nt
  U=U_t+V0*delta_t+alpha*A*U_t;   % verlet velocidades
  V=V0+0.5*(alpha/delta_t)*A*(U_t+U0);  

  U_t=U;
  U0=U_t;
  V0=V;
  
  T=[T U];
  ti=i*delta_t;
  u_ex=u_ex0.*cos(c*n*pi*ti); 
  
  [dU,dx]=der_diff(x,U);
  E=-dU; % Campo eléctrico
  
% Representación gráfica de la onda
  c1=plot(x,U,'o',x,u_ex);
  hold on 
  c2=plot(dx,E);
  title('Onda');
  xlabel('Longitud del medio');
  ylabel('Potencial');
  legend('Potencial eléctrico','Campo eléctrico')
  ylim([-10 10]);
  pause(0.001);
  delete(c1);
  delete(c2);
  
 end
 
 
 
