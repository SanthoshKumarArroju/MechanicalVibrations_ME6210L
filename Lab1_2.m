%% Frequency and Time domain methods to find damping, natural frequency in the cantilever beam
clc; clear all; close all;

%% Hammer_Power spectrum  with extra mass on hammer
load kistler_soft_bl_extmass.mat
figure
plot(Freq_domain,20*log10(PSD_chan_1))

load kistler_pltk_bl_extmass.mat
hold on
plot(Freq_domain,20*log10(PSD_chan_1))

load kistler_metal_extmass.mat
hold on
plot(Freq_domain,20*log10(PSD_chan_1))
title('PSD Input Hammer with extra mass')
xlabel('Frequency'); ylabel('Input Hammer PSD')
legend('soft tip','plastic tip','metal tip')
hold off

%% %% Hammer_Power spectrum  with no extra mass on hammer
load kistler_soft_bl_noextmass.mat
figure
plot(Freq_domain,20*log10(PSD_chan_1))

load kistler_pltk_bl_noextmass.mat
hold on
plot(Freq_domain,20*log10(PSD_chan_1))

load kistler_metal_noextmass.mat
hold on
plot(Freq_domain,20*log10(PSD_chan_1))
hold off
title('PSD Input Hammer with extra mass')
xlabel('Frequency'); ylabel('Input Hammer PSD')
legend('soft tip','plastic tip','metal tip')

%% Frequency Domain technique, Quadrature peak-picking method
% zeta = (wb-wa)/2wd;  wn = wd/sqrt(1-zeta^2)
load kistler_soft_bl_noextmass.mat
figure
plot(Freq_domain,20*log10(abs(Hf_chan_2)))

load kistler_pltk_bl_noextmass.mat
hold on
plot(Freq_domain,20*log10(Hf_chan_2))

load kistler_metal_noextmass.mat
hold on
plot(Freq_domain,20*log10(Hf_chan_2))

hold off
title('FRF')
xlabel('Frequency'); ylabel('FRF')
legend('soft tip','plastic tip','metal tip')


%% Time Domain method, log decrement method
% d=(1/n)*log(x(1)/x(n));
% Td=(Time_domain(n)-Time_domain(1))/(n-1);
% Wd=(2*pi)/Td ;
% zeta=d/(sqrt((4*pi^2)+d^2));
% Wn=Wd*sqrt(1-zeta^2);
% ccr=2*sqrt(k*m);
% c=ccr*zeta;

load kistler_soft_bl_noextmass.mat
% figure
% plot(Time_domain,Time_chan_2*9.81)
% title('Acceleration, m/sec^2 VS Time, sec')
wd = (2*pi)/Time_domain(end);
Acc_soft = Time_chan_2*9.81;
Dis_soft = Acc_soft/wd^2;
figure
plot(Time_domain,Dis_soft)
title('Displacement, m VS Time, sec')

load kistler_pltk_bl_noextmass.mat
% figure
% plot(Time_domain,Time_chan_2*9.81,'r')
Acc_pltk = Time_chan_2*9.81;
Dis_pltk = Acc_soft/wd^2;
figure
plot(Time_domain,Dis_pltk)
title('Displacement, m VS Time, sec')

load kistler_metal_noextmass.mat
% figure
% plot(Time_domain,Time_chan_2*9.81)
Acc_metal = Time_chan_2*9.81;
Dis_metal = Acc_soft/wd^2;
figure
plot(Time_domain,Dis_metal)
title('Displacement, m VS Time, sec')

% title('FRF')
% xlabel('Frequency'); ylabel('FRF')
% legend('soft tip','plastic tip','metal tip')



