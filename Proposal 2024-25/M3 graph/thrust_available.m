clear all;
close all;
clc;
set(0,'DefaultFigureWindowStyle','docked');

rho = 23.679e-4;
Cdo = 0.013;
b = 6;
e = 0.9;

varr = linspace(1,250,100);
darr = [];
W_pl = 20;
S = 7;
W = 7.09 + 0.067*(2.05*S)^(3/2) + W_pl ;

hold on
carr = [];
for i=1:length(varr)
    vguess=varr(i);
    V = vguess;
    cl = W/(0.5 * rho * V^2 * S);
    carr(i) = cl;

    D = 0.5 * rho * V^2 * ( Cdo + ((4*W^2)/(pi*e*b^2*rho^2*V^4*S)) ) * S;
    darr(i) = D;
end

p2=plot(varr,darr,'color','blue','linewidth',2); %drag with 20lbs payload

parr = linspace(500,2650,5); %thrust available at power settings
for i=1:length(parr)
    power_setting = parr(i);
    fl = sprintf('p_500.py %g',power_setting);
    data = double(pyrunfile(fl,'opt'));
    % plot(data(:,1),data(:,2),'color','green')%,'alpha',power_setting/4000)
    p1=plot(data(:,1),data(:,2),'color',[0,.3,0,(300+power_setting)/(2650+300)],'linewidth',2); %refer to line 31
end
% 
power_setting = 2650;
fl = sprintf('p_500.py %g',floor(power_setting));
data = double(pyrunfile(fl,'opt'));
p0=plot(data(:,1),data(:,2),'color','red','linewidth',2); %thrust available @ power setting (line 40)
%plot(data(:,1),data(:,3)/1000,'color','black') %rpm

%plot(varr,10*carr,'color','magenta') %cl @ heavier Wpl x10

ylim([0,20])
ylabel('Drag [lbf]')
xlabel('Velocity [mph]')


grid on







varr = linspace(1,250,100);
darr = [];
W_pl = 0;
W = 7.09 + 0.067*(2.05*S)^(3/2) + W_pl ;

hold on
carr = [];
for i=1:length(varr)
    vguess=varr(i);
    V = vguess;
    cl = W/(0.5 * rho * V^2 * S);
    carr(i) = cl;

    D = 0.5 * rho * V^2 * ( Cdo + ((4*W^2)/(pi*e*b^2*rho^2*V^4*S)) ) * S;
    darr(i) = D;
end

p3=plot(varr,darr,'color','cyan','linewidth',2); %drag with zero payload weight
%plot(varr,10*carr,'color',[1,.5,0]) %cl for zero payload weight

hold off

legend([p0,p1,p2,p3],'Maximum power setting (1960 lb-ft/s)','Lower power settings','Drag with 20 lbs of payload','Drag with 0 lbs of payload','fontsize',20)
xlim([0,225])
set(gca,'FontSize',20)


