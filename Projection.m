function [P, R_, T_] = Projection(H,K)
%Cette fonction nous calcule la matrice de projection 

    F = inv(K)*H;
    r1 = F(:,1);
    r2 = F(:,2);
    t = F(:,3);
    r3 = cross(r1,r2);
    
    R = [r1 r2 r3];
    a =  nthroot(det(R),4); % on definit le facteur echelle 
    
    % Calcule des nauveaus elements
    r1 = r1/a;
    r2= r2/a;
    r3 = r3/a^2;
    t = t/a;

    % Matrice rotation
    R_ = [r1 r2 r3];
    % Vecteur T
    T_ = t;
    % Matrice de projection 
    P = K *[R_ T_];
end

%Il est effectivement important de vérifier que le déterminant de la matrice de rotation R dans une matrice de projection est égal à 1.
% Cela indique que la matrice de rotation est une matrice de rotation valide,
% qui respecte les propriétés de l'espace euclidien.