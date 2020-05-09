function out = position_control(in)

X_GF = in(1);
Y_GF = in(2);

global erle;

% [erle.X_des_asd,erle.Y_des_asd,erle.Z_des_asd] = rotateGFtoBF(erle.X_des,erle.Y_des,0,0,0,erle.yaw);
% [erle.X_BF,erle.Y_BF,erle.Z_BF] = rotateGFtoBF(erle.X,erle.Y,erle.Z,erle.roll,erle.pitch,erle.yaw);
% [erle.X_d_BF,erle.Y_d_BF,erle.Z_d_BF] = rotateGFtoBF(erle.X_d,erle.Y_d,erle.Z_d,0,0,erle.yaw);

 %% Control de X
   erle.X_des_filt = (2.5/(2.5+erle.Tm))*erle.X_des_filt_1 + (erle.Tm/(2.5+erle.Tm))*X_GF;
%    erle.X_des_filt = (2/(2+erle.Tm))*erle.X_des_filt_1 + (erle.Tm/(2+erle.Tm))*erle.X_des;
   
% C�lculo del error
%    erle.X_int = erle.X_des_filt*erle.Tm + erle.X_int;
   X_ek = erle.X_des_filt - erle.X_GF;
   % Incremento de la integral del error
    erle.X_Int_ek = erle.X_Int_ek + erle.Tm*X_ek;
    % Controlador PI
%     erle.pitch_des = ((0.0960*(X_ek + erle.X_Int_ek/7.6000 + 1.8671*((X_ek - erle.X_ek_1)/erle.Tm))));
    erle.pitch_des = ((0.1271*(X_ek + erle.X_Int_ek/7.5000 + 1.6667*((X_ek - erle.X_ek_1)/erle.Tm))));
    
% Saturaci�n
    erle.pitch_des = +erle.pitch_des;
    erle.pitch_des = min(erle.pitch_max,max(-erle.pitch_max,erle.pitch_des));
    
    erle.X_des_filt_1 = erle.X_des_filt;
    erle.X_ek_1 = X_ek;
    
 %% Control de Y
   erle.Y_des_filt = (2.5/(2.5+erle.Tm))*erle.Y_des_filt_1 + (erle.Tm/(2.5+erle.Tm))*Y_GF;
%    erle.Y_des_filt = (2/(2+erle.Tm))*erle.Y_des_filt_1 + (erle.Tm/(2+erle.Tm))*erle.Y_des;
   
% C�lculo del error
%    erle.X_int = erle.Y_des_filt*erle.Tm + erle.X_int;
   Y_ek = erle.Y_des_filt - erle.Y_GF;
   % Incremento de la integral del error
    erle.Y_Int_ek = erle.Y_Int_ek + erle.Tm*Y_ek;
    % Controlador PI
%     erle.pitch_des = ((0.0960*(X_ek + erle.X_Int_ek/7.6000 + 1.8671*((X_ek - erle.X_ek_1)/erle.Tm))));
    erle.roll_des = ((0.1271*(Y_ek + erle.Y_Int_ek/7.5000 + 1.6667*((Y_ek - erle.Y_ek_1)/erle.Tm))));
    
% Saturaci�n
    erle.roll_des = -erle.roll_des;
    erle.roll_des = min(erle.roll_des,max(-erle.roll_des,erle.roll_des));
    
    erle.Y_des_filt_1 = erle.Y_des_filt;
    erle.Y_ek_1 = Y_ek;
    
    out = [erle.roll_des,erle.pitch_des];
    
end

