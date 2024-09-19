function [error_R , error_T] = errors()
%Cette fonction nous calcule les erreurs de rotation et de transition 

    % On importe les données dont on a besoin 
    load ("calibrationSession.mat");
    R_furnis = calibrationSession.CameraParameters.RotationMatrices;
    T_furnis = calibrationSession.CameraParameters.TranslationVectors;
    Mw = calibrationSession.CameraParameters.WorldPoints; 
    Mi = calibrationSession.CameraParameters.ReprojectedPoints;
    k = calibrationSession.CameraParameters.IntrinsicMatrix' ;
    
    
    error_r = zeros(1,14);
    error_t = zeros(1,14);
    for i = 1:14;
        % Calcule de l'homographie
        H = Homographie(Mi(:,:,i),Mw);
        % Calcule de la projection
        [P, R, T] = Projection(H,k);
        % calcule de l'erreur de rotation
        error_r(1,i) = norm(R) - norm(R_furnis(:,:,i)');
        % calcule de l'erreur de transition 
        error_t(1,i) = norm(T) - norm(T_furnis(i,:)');
    end
error_R = error_r;
error_T = error_t;


end