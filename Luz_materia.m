% MODELOS UNIDIMENSIONALES DE INTERACCIÓN LUZ-MATERIA
clear 
close all
clc

% PARTÍCULAS
% Datos
N_D=1;   % Dimensión
N_P=11;   % Número de partículas
L=1;     % Longitud del medio
m=1;     % Masa  
k=1;     % Constante elástica
q=0.02;  % Carga de las partículas

% Discretización de tiempo
t_f=6;
delta_t=0.005;        
t=0:delta_t:t_f;
Nt=numel(t)-1;

% Condiciones iniciales partículas
mass=ones(1,N_P);  % Vector de masas
r0=zeros(N_D,N_P);  
r0(1,1)=0;   
r0(1,N_P)=L;

for j=1:N_P
  r0(1,j)=(j-1)*L/(N_P-1); % Posiciones iniciales
end

dr=0*(L/N_P)*2*(rand(N_D,N_P)-0.5); % Desplazamientos de las partículas
dr(:,1)=0;                              % Primera partícula
dr(:,N_P)=0;                            % Última partícula
r0=r0+dr;
v0=zeros(N_D,N_P); % Velocidad inicial

% Fuerzas que actúan

Fuerza_osc= @(r,E) Fuerzas_part(r,E,k,q);                % Definimos una 
                                                         % función anónima
[r,v,t,U_f]=Verlet_part(Fuerza_osc,mass,r0,v0,delta_t,t_f); % Verlet_part
N_T=numel(t);

% Representación de las partículas
for it=1:N_T
  plot(r(1,:,it),0*r(1,:,it),'o-')
  title('Partículas')
  xlabel('x [m]')
  xlim([-0.1 1.1])
  pause(0.0001)
end

% Energías 
% Ekin=zeros(N_P,N_T); Etot=Ekin;        % Inicializamos vectores
% Ep_electrica=Ekin;   Ep_elastica=Ekin;

% for tp=1:N_T
%   Ekin(:,tp)=0.5*m.*v(:,:,tp).^2;               % Energía cinética
%   Ep_electrica(:,tp)=q.*U_f(:,:,tp).*10.^18; % Energía potencial eléctrica
%   for p=2:N_P-1
%     Ep_elastica(:,tp)=0.5.*k.*((r(p)-r(p-1))-(r(p)-r(p+1))).^2; % Energía potencial elástica
%   end
%   Etot(:,tp)=Ekin(:,tp)+Ep_electrica(:,tp)+Ep_elastica(:,tp);
%   Epot(:,tp)=Ep_electrica(:,tp)+Ep_elastica(:,tp); 
% end

% Representación energía cinética 
% figure()
% plot(t,Ekin(1,:),t,Ekin(2,:),t,Ekin(3,:),t,Ekin(4,:),t,Ekin(5,:))
% ylabel('Energía cinética [J]')
% xlabel('Tiempo [s]')
% title('Energía cinética de cada partícula')
% legend('1','2','3','4','5')
% ylim([-0.0001 0.01])

% Representación energía potencial
% figure()
% plot(t,Epot(1,:),t,Epot(2,:),t,Epot(3,:)+2.6,t,Epot(4,:)+3.6,t,Epot(5,:))
% ylabel('Energía potencial')
% xlabel('Tiempo [s]')
% title('Energía potencial de cada partícula')
% legend('1','2','3','4','5')
% ylim([-1.2 1])




  