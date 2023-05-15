function [H] = Homographie(mi,mw)
%Cette fonction nous calcule la matrice homographie

    % les points repére image
    u0 = mi(:,1)';
    v0 = mi(:,2)';
    
    %les points repére monde
    u1 = mw(:,1);
    v1 = mw(:,2);
    
    % le nombre de points
    taill = size(mw);
    
    % On a 2 equations avec 9 inconnue 
    A = zeros(2*taill(1),9);

    for i = 0:taill(1)-1;
        A(2*i+1,:) =[zeros(1, 3) , -u1(i+1) , -v1(i+1) , -1 , v0(i+1)*u1(i+1) , v0(i+1)*v1(i+1), v0(i+1)];
        A(2*i+2,:) = [u1(i+1) , v1(i+1) , 1 , zeros(1, 3) , -u0(i+1)*u1(i+1) , -u0(i+1)*v1(i+1) , -u0(i+1)];
    end
    
    % on utilise la Dlt(Direct Linear Transformation) pour résoudre le
    % calcule 
    [U,S,V] = svd(A);

    % On prend V comme vecteur Hi
    h = V(:,end);   

    % on reshape et normalise notre matrice Homographie 
    H = reshape(h, 3, 3)'/h(end);

end