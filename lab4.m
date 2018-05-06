%% Lab_4 Modal Analysis of a Cruise Missile Wing %
clc; close all; clear all;

%% To find Transfer Function for all five cases for mdofcf %
load Lab4_Case1
h1=Hf_chan_2;
load Lab4_Case2
h2=Hf_chan_2;
load Lab4_Case3
h3=Hf_chan_2;
load Lab4_Case4
h4=Hf_chan_2;
load Lab4_Case5
h5=Hf_chan_2;
 
tf=[h1,h2,h3,h4,h5];

%% Computing damping, natural frequency, mode shape vector  use mdofcf.m in vibration tool box

display('%%%%%%%% Computing damping, natural frequency, mode shape vector  use mdofcf %%%%%%%')
lamda=zeros(5); z=zeros(5); s=zeros(5);

f1 = 13.44; f2 = 51.7; f3 = 124.7; f4 = 167.8; f5 = 227.8;  % select the peak values from FRF plots for each case %

load Lab4_Case1;
figure
H=20*log10(abs(Hf_chan_2)); % in db
plot(Freq_domain,H,'r'); hold on;
[z1,nf1,u1]=mdofcf(Freq_domain,tf,f1-5,f1+5);   % use -5,+5 lower and upper bounds to the peak value
z(1,1)=z1;
lamda(1,1)=(2*pi*nf1)^2;
s(:,1)=real(u1)

load Lab4_Case2;
H=20*log10(abs(Hf_chan_2)); % in db
plot(Freq_domain,H, 'c'); hold on;
[z2,nf2,u2]=mdofcf(Freq_domain,tf,f2-5,f2+5);
z(2,2)=z2;
lamda(2,2)=(2*pi*nf2)^2;
s(:,2)=real(u2)

load Lab4_Case3;
H=20*log10(abs(Hf_chan_2)); % in db
plot(Freq_domain,H, 'b'); hold on;
[z3,nf3,u3]=mdofcf(Freq_domain,tf,f3-5,f3+5);
z(3,3)=z3;
lamda(3,3)=(2*pi*nf3)^2;
s(:,3)=real(u3)

load Lab4_Case4;
H=20*log10(abs(Hf_chan_2)); % in db
plot(Freq_domain,H, 'm'); hold on;
[z4,nf4,u4]=mdofcf(Freq_domain,tf,f4-5,f4+5);
z(4,4)=z4;
lamda(4,4)=(2*pi*nf4)^2;
s(:,4)=real(u4)

load Lab4_Case5;
H=20*log10(abs(Hf_chan_2)); % in db
plot(Freq_domain,H, 'g'); grid on; xlabel('Frequency - Hz'); ylabel('FRF - db'); hold on;
title('FRF vs Frequency')
legend('Case 1','Case 2', 'Case 3','Case 4','Case 5')
[z5,nf5,u5]=mdofcf(Freq_domain,tf,f5-4,f5+4);
z(5,5)=z5
lamda(5,5)=(2*pi*nf5)^2
s(:,5)=real(u5)

Dampingratio_mdofcf = [z1, z2, z3, z4, z5]            % Damping ratio's using mdofcf
Naturalfreq_mdofcf = [nf1, nf2, nf3, nf4, nf5]        % Natural Frequency using mdofcf
Modeshape_mdofcf = [u1, u2, u3, u4, u5]               % Mode Shape vector using mdofcf

m=(s'.*eye(5)).*s;              % Mass Matrix
c=(s'.*(2*z*sqrt(lamda))).*s;   % Damping Matrix
k=(s'.*lamda).*s;               % Stiffness Matrix

MM=vpa(m,8)  % use Variable Precision Arithmatic upto 5~8 %
CM=vpa(c,8)  % MM, DM, SM matices in the command window %
KM=vpa(k,8)  

%% Hammer response plots for all five cases
figure
load Lab4_Case1;
HammerForce = Time_chan_1;
plot (Time_domain,HammerForce,'r')
hold on
load Lab4_Case2;
HammerForce= Time_chan_1;
plot (Time_domain,HammerForce,'c')
hold on
load Lab4_Case3;
HammerForce = Time_chan_1;
plot (Time_domain,HammerForce,'k')
hold on
load Lab4_Case4;
HammerForce = Time_chan_1;
plot (Time_domain,HammerForce,'m')
hold on
load Lab4_Case5;
HammerForce = Time_chan_1;
plot (Time_domain,HammerForce,'b')
xlabel('Time - sec'); ylabel('Hammer Force');
legend('Case 1','Case 2', 'Case 3','Case 4','Case 5')
title('Hammer Input response vs Time'); grid on;

%% curve fitting using vtb7_4.m in Vibration Tool Box %

load Lab4_Case1
[z1,nf1,u1]=vtb7_4(Freq_domain,Hf_chan_2,f1-5,f1+5)
load Lab4_Case2
[z2,nf2,u2]=vtb7_4(Freq_domain,Hf_chan_2,f2-5,f2+5)
load Lab4_Case3
[z3,nf3,u3]=vtb7_4(Freq_domain,Hf_chan_2,f3-5,f3+5)
load Lab4_Case4
[z4,nf4,u4]=vtb7_4(Freq_domain,Hf_chan_2,f4-5,f4+5)
load Lab4_Case5
[z5,nf5,u5]=vtb7_4(Freq_domain,Hf_chan_2,f5-1,f5+1)

display('%%%%%%%%% Damping ratio, Natural Frequency and Mode shape vector using vtb7_4.m  %%%%%%%%%%%%%%')

Dampingratio_vtb7_4 = [z1, z2, z3, z4, z5]            % Damping ratio's using vtb7_4
Naturalfreq_vtb7_4 = [nf1, nf2, nf3, nf4, nf5]        % Natural Frequency using vtb7_4
Modeshape_vtb7_4 = [u1, u2, u3, u4, u5]               % Mode Shape vector using vtb7_4

%% curve fitting using sdofcf.m in Vibration Tool Box %

display('%%%%%%%%% Magnitude and Phase plots curve fitting using sdofcf.m  %%%%%%%%%%%%%%')

load Lab4_Case1
figure
[zeta,F,~]=sdofcf(Freq_domain,Hf_chan_2,7,20);
hold on; figure
load Lab4_Case2
[zeta,F,~]=sdofcf(Freq_domain,Hf_chan_2,30,60);
hold on; figure
load Lab4_Case3
[zeta,F,~]=sdofcf(Freq_domain,Hf_chan_2,120,135);
hold on; figure
load Lab4_Case4
[zeta,F,~]=sdofcf(Freq_domain,Hf_chan_2,160,170);
hold on; figure
load Lab4_Case5
[zeta,F,~]=sdofcf(Freq_domain,Hf_chan_2,f5-1.4,f5+1.4);


%% Inertance FRF for all cases %
figure
load Lab4_Case1;
H=20*log10(abs(Hf_chan_2));
plot(Freq_domain,H); grid on; hold on
load Lab4_Case2;
H=20*log10(abs(Hf_chan_2));
plot(Freq_domain,H); grid on; hold on
load Lab4_Case3;
H=20*log10(abs(Hf_chan_2));
plot(Freq_domain,H); grid on; hold on
load Lab4_Case4;
H=20*log10(abs(Hf_chan_2));
plot(Freq_domain,H); grid on; hold on
load Lab4_Case5;
H=20*log10(abs(Hf_chan_2));
plot(Freq_domain,H); grid on; hold on
xlabel('Frequency - Hz'); ylabel('FRF - dB');
title('Inertance FRF vs Frequency');
 

%% To find Power Spectral Density for all five cases

figure
load Lab4_Case1
PSD_dB=20*log10(abs(PSD_chan_1));
plot(Freq_domain,PSD_dB,'r'); hold on
load Lab4_Case2
PSD_dB=20*log10(abs(PSD_chan_1));
plot(Freq_domain,PSD_dB,'c'); hold on
load Lab4_Case3
PSD_dB=20*log10(abs(PSD_chan_1));
plot(Freq_domain,PSD_dB,'b'); hold on
load Lab4_Case4
PSD_dB=20*log10(abs(PSD_chan_1));
plot(Freq_domain,PSD_dB,'m'); hold on
load Lab4_Case5
PSD_dB=20*log10(abs(PSD_chan_1));
plot(Freq_domain,PSD_dB,'g'); hold on
xlabel('Frequency - Hz'); ylabel('Power spectral density - dB');
legend('Case 1','Case 2', 'Case 3','Case 4','Case 5')
title('Input Hammer PSD vs Frequency'); grid on;
axis([-50 600 -110 20])


