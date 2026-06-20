

function F=Fuerzas_part(r,Er,k,q)

% Osciladores acoplados 
[N_D,N_P]=size(r);
F=zeros(N_D,N_P);

for p=2:N_P-1   % La primera partícula y la última no experimentan la fuerza 
 F(p)=-k.*((r(p)-r(p-1))+(r(p)-r(p+1)))+q.*Er(p); % Fuerzas sobre las partículas
end
 
 



