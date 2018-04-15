%% sdofxfer plotting FRF of sdof model for different damping values
% Reference: Vibration Simulation Using MATLAB & ANSYS by Michael R. Hatch %

clc; clear all; close all;
m = 10; z = 0.1:0.1:1; k = 5; % assign mass, damping ratio, stiffness values
wn = sqrt(k/m);
f_n = 500;                   % defines no. of Frequency points
w = logspace(-1,1,f_n);      % -1, is 10^-1, 1 is 10^1, and freq points 
rad2deg = 180/pi;
s = j*w;
for n = 1:length(z)
    xfer(n,:) = (1/m)./(s.^2 + 2*z(n)*wn*s+wn^2);
    mag(n,:) = abs(xfer(n,:));
    phase(n,:)  = angle(xfer(n,:))*rad2deg;
end
figure
for n = 1:length(z)
    loglog(w,mag(n,:),'b-')
    title('SDOF Freq response magnitude for zeta = 0.1 to 1.0 in step 0.1')
    xlabel('Freq, rad/sec')
    ylabel('Magnitude')
    grid on, hold on
    
end

figure
for n = 1:length(z)
    semilogx(w,phase(n,:),'m-')
    title('SDOF Freq response phase for zeta = 0.1 to 1.0 in step of 0.1')
    xlabel('Freq, rad/sec')
    ylabel('Magnitude')
    grid on, hold on

end
