
% -------------premiere partie: Tracking et insertion de l'objet 3d-----------------%

clear all
close all
clc

% lire et afficher la vidéo
videoReader = VideoReader('Video_Init.mp4');
videoPlayer = vision.VideoPlayer('Position',[100,100,640,368]);

% Lire la 1ere frame
objectFrame = readFrame(videoReader);
objectRegion = [0,0,640,640];

objectImage = insertShape(objectFrame,'Rectangle',objectRegion,'Color','red');
figure;
imshow(objectImage);
% [x_init,y_init] = ginput(8)
title('Red box shows object region');

% Poue évité de faire ginput a chaque fois on déclare X_int et Y_int
x_init = [72 42 301 331 132 128 238 244]';
y_init = [248 391 247 389 296 354 295 356]';
points = [x_init,y_init]; % points à tracker
pointImage = insertMarker(objectFrame,points,'+','Color','white');

% Afficher les points
figure;
imshow(pointImage);
title('points to track');

tracker = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker,points,objectFrame);

% charger le fishier
load ("calibrationSession.mat");
k = calibrationSession.CameraParameters.IntrinsicMatrix' ;

% Points repére Monde 
Mw = [0, 0; 0, 125; 175, 0; 175, 125;50,50;50,100;125,50;125,100];

% axis tight manual 
% set(gca,'nextplot','replacechildren'); 
% v = VideoWriter('Video_final.avi');
% open(v);
while hasFrame(videoReader)

      frame = readFrame(videoReader);
      [points,validity] = tracker(frame);
      
      % Calcule de l'homographie
      H = Homographie(points,Mw);

      % Calcule de la matrice de projection qui contient la translation et
      % la rotation 
      [P, R, T] = Projection(H,k);

      % sélectionner 4 points du repere monde pour dessiné l'objet 3d
      X1 = Mw( 5 , : );
      X2 = Mw( 6 , : );
      X3 = Mw( 8 , : );
      X4 = Mw( 7 , : );
            
      %Correspondance x2d <-> x3d  (x; y; 1)' <-> (X; Y; 0; 1)'
      x1 = P * [ X1' ; 0; 1 ];
      x2 = P * [ X2' ; 0; 1 ];
      x3 = P * [ X3' ; 0; 1 ];
      x4 = P * [ X4' ; 0; 1 ];
      
      %Normalisation des vecteurs
      x1 = x1./x1(end);
      x2 = x2./x2(end);
      x3 = x3./x3(end);
      x4 = x4./x4(end);

      % Affiché les points tracker 
      out = insertMarker(frame,points(validity, :),'+');
      videoPlayer(out);

      % dessiné et affiché l'objet 3d   
      imshow(frame);
      h = 40;
      x_ = [x1(1) x2(1) x3(1) x4(1) x1(1) x1(1) x2(1) x3(1) x4(1) x1(1) x2(1) x2(1) x3(1) x3(1) x4(1) x4(1)];
      y_ = [x1(2) x2(2) x3(2) x4(2) x1(2) x1(2)-h x2(2)-h x3(2)-h x4(2)-h x1(2)-h x2(2)-h x2(2) x3(2) x3(2)-h x4(2)-h x4(2)];
      hold on 
      plot(x_, y_,'LineWidth',5);
      title('Video rendu final')
% 
%       % Code pour record la video
%       frame = getframe(gcf);
%       writeVideo(v,frame);

end

release(videoPlayer);
% close(v);

%%
%%---------------------Partie 2: évaluation des erreur--------------------------%

% On appele la fonction pour calcule la differance entre le resultat estimé
% et le resultat fourni

[error_R, error_T] = errors() ;

% Tracé la figure de rotation
figure(3);
plot(error_R)
title('Erreur estimé pour la rotation')
xlabel("Numero de l'image")

% Tracé la figure de transition 
figure(4);
plot(abs(error_T)/10)
title('Erreur estimé pour la translation ')
xlabel("Numero de l'image")

