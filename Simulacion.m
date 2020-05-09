clear all;
close all;
clc;

addpath Simulador

global erle;

erle.T_simulacion = 15;% segundos
erle.T_escalon_yaw = 7;%(segundios)


init_plot;
plot_erle_model;
erle_variables;

erle.X_t = 4; %Tiempo de escalón X
erle.Y_t = 4; %Tiempo de escalón X
erle.X_des = 2; %Amplitud del escalón X
erle.Y_des = 1; %Amplitud del escalón Y

SimOut = sim('diagrama_de_bloques');

%% Gráficas
%Control de altura
figure;
subplot(2,1,1);
plot(SimOut,Position_GF(:,3),SimOut,Position_Ref(:,3));xlabel('tiempo(s)');ylabel('Z(m)');legend('actual','ref');
subplot(2,1,2);
plot(erle.time_plot,erle.U1_plot);legend('Señal de control');
figure;
plot(erle.time_plot,erle.Z_d_GF_plot);title('Zd(m/s)');
figure;
plot(erle.time_plot,erle.Z_dd_GF_plot);title('Zdd(m/s^2)');
%Control del roll
figure;
subplot(2,1,1);
plot(SimOut,Attitude(:,1),SimOut,Attitude_Ref(:,1));xlabel('tiempo(s)');ylabel('roll(Deg)');legend('roll','roll_ref');
subplot(2,1,2);
plot(erle.time_plot,erle.U2_plot);legend('Señal de control(U2)');
figure;
plot(erle.time_plot,erle.p_plot);title('p(Deg/s)');
%Control del pitch
figure;
subplot(2,1,1);
plot(SimOut,Attitude(:,2),SimOut,Attitude_Ref(:,2));xlabel('tiempo(s)');ylabel('pitch(deg)');legend('pitch','pitch_ref');
subplot(2,1,2);
plot(erle.time_plot,erle.U3_plot);legend('Señal de control(U3)');
figure;
plot(erle.time_plot,erle.q_plot);title('q(Deg/s)');
%Control del yaw
figure;
subplot(2,1,1);
plot(SimOut,Attitude(:,3),SimOut,Attitude_Ref(:,3));xlabel('tiempo(s)');ylabel('yaw(deg)');legend('yaw','yaw_ref');
subplot(2,1,2);
plot(erle.time_plot,erle.U4_plot);legend('Señal de control(U4)');
figure;
plot(erle.time_plot,erle.r_plot);title('r(Deg/s)');
% Posiciones
figure;
subplot(2,1,1);
plot(SimOut,Position_GF(:,1),SimOut,Position_Ref(:,1));xlabel('tiempo(s)');ylabel('X(m)');legend('actual','ref');
subplot(2,1,2);
plot(SimOut,Position_GF(:,2),SimOut,Position_Ref(:,2));xlabel('tiempo(s)');ylabel('Y(m)');legend('actual','ref');
