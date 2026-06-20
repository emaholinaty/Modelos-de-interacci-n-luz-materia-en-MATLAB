function [r,v,t,U_f] = Verlet_part(Fuerza_osc,mass,r0,v0,delta_t,t_f)
%  Resuelve las ecuaciones de movimiento de N_P particulas en N_D dimensiones
%  Usando Verlet, se calculan las posiciones, las velocidades y las
%  aceleraciones para todo instante de tiempo
% Input:
%   f           : función que calcula la fuerza f=f(r)
%   mass(N_P)   : vector con las masas de las N_P particulas
%   r0(N_D,N_P) : posiciones iniciales (dimensión, partícula)
%   v0(N_D,N_P) : velocidades iniciales (dimensión, partícula) 
%   dt          : intervalo de tiempo
%   t_max       : tiempo final 
% Output:
%   r(N_D,N_P,N_T) : vector de posiciones en cada instante (0:dt:tmax)
%   v(N_D,N_P,N_T) : vector de velocidades en cada instante (dimensión, partícula, tiempo) 
%   t(N_T)         : vector de tiempos

[N_D,N_P]=size(r0);
t=0:delta_t:t_f;   % Tiempos de integración
N_T=numel(t);      % Tiempo total
m=mass;

% CÁLCULO DEL CAMPO ELÉCTRICO
% Datos numéricos
c=1; % Velocidad de la luz 
L=1; % Longitud del medio

% Discretización de x
delta_x=0.01;     
x=delta_x:delta_x:L-delta_x; % Puntos de la onda
Nx=numel(x);                 
alpha=(c*delta_t/delta_x)^2; % Parámetro de la ecuación de ondas

% Matriz de la segunda derivada
a0=-2*ones(Nx,1);
a1=ones(1,Nx-1);
A=diag(a0,0)+diag(a1,-1)+diag(a1,1);
I=eye(Nx);

% Condiciones iniciales (potencial eléctrico)
n=12;               % A mayor n, mayor frecuencia (n=modos de propagación luz)
f0=sin(n.*pi.*x');  % Potencial en el instante cero como vector columna
g0=0*x';            % Derivada temporal del potencial en el instante cero 
U0=f0;              % Potencial inicial

U_t=U0+delta_t*g0; 
V0=g0;

% VERLET VELOCIDADES
r=zeros(N_D,N_P,N_T); v=r; a=r;   % Definir e iniciar

% Condiciones iniciales para verlet
r(:,:,1)=r0;            
v(:,:,1)=v0;

E0=-der_diff(x,U0);                       % Cálculo del campo eléctrico inicial
xm=x(1:end-1)+0.5*diff(x);% Puntos medios de x
U1=U0';
E0r=interp1(xm,E0,r0,'linear','extrap');  % Interpolación del campo eléctrico inicial
U0r=interp1(xm,U1(1:end-1),r0,'linear','extrap');  % Interpolación del potencial inicial

a(:,:,1)=Fuerza_osc(r0,E0r)./m;
U_f=zeros(N_P,N_T);
U_f(:,1)=U0r;

  for i_t=2:N_T 
    U=U_t+V0*delta_t+alpha*A*U_t;           % Incluimos la ec. de ondas en verlet 
    U_t=U;
    
    E=-der_diff(x,U);                       % Cálculo del campo eléctrico
    Er=interp1(xm,E,r,'linear','extrap');   % Interpolación del campo eléctrico 
    U_f=interp1(xm,U_t(1:end-1),r,'linear','extrap'); % Interpolación del potencial
    
    r(:,:,i_t)=r(:,:,i_t-1)+v(:,:,i_t-1)*delta_t+a(:,:,i_t-1)*delta_t^2/2;
    a(:,:,i_t)=Fuerza_osc(r(:,:,i_t),Er(:))./m; 
    v(:,:,i_t)=(r(:,:,i_t)-r(:,:,i_t-1))/delta_t+a(:,:,i_t)*delta_t/2;
  end
end 