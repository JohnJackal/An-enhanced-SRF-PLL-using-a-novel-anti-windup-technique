close all
scenario = 1;

if scenario == 1
    % HV Circuit and PI regulator params
    Rs = 106;
    Ls = 338e-3;
    Us = 150e3*sqrt(2);
    zeta=0.5;
    ts=0.1;
    Kp=18.4/Us/ts;
    Ki=43.32/Us/(zeta*ts)^2;
    % PLL params;
    omega_gn = 100*pi;
    idref = 1e3;
    iqref = 0;
    delta_ss = asin((omega_gn*Ls*idref+Rs*iqref)/Us);
    beta = 10*pi;
    C1 = 1-Kp*Ls*idref;
elseif scenario == 0
    % LV Circuit and PI regulator params
    Rs = 3.75;
    Ls = 12e-3;
    Us = 100*sqrt(2);
    zeta=0.5;
    ts=0.1;
    Kp=18.4/Us/ts;
    Ki=43.32/Us/(zeta*ts)^2;
    % PLL params;
    omega_gn = 100*pi;
    idref = 20;
    iqref = 0;
    delta_ss = asin((omega_gn*Ls*idref+Rs*iqref)/Us);
    beta = 10*pi;
    C1 = 1-Kp*Ls*idref;
end
% Other params
np = 1;
nc = 1;
nw = 2;
nu = 1;
nz = 1;
% Closed-loop system matrices
A = [-1/C1*Kp*Us*cos(delta_ss),1/C1;-1/C1*Ki*Us*cos(delta_ss),1/C1*Ki*Ls*idref];
Bv = [Kp/C1,1/C1;Ki/C1,Ki*Ls*idref/C1];
Bq = [1/C1,Ki*Ls*idref/C1]';
C = [-1/C1*Kp*Us*cos(delta_ss),1/C1];
Dv = [Kp/C1,1/C1];
Dq = (1-C1)/C1;
Cp = [1,0];

syms x;
fplot(-Us*x,[-2*pi,4],'r','lineWidth',1.5);
hold on
% area([-pi-2*delta_ss,pi-2*delta_ss],[-Us*(-pi-2*delta_ss),-Us*(pi-2*delta_ss)],'FaceColor','g','EdgeColor','r','LineWidth',1.5);
plot([-pi-2*delta_ss,-pi-2*delta_ss],[-10e5,14e5],'--b','lineWidth',1.5);
plot([pi-2*delta_ss,pi-2*delta_ss],[-10e5,14e5],'--b','lineWidth',1.5);
plot([-2*pi,4],[0,0],'-k','lineWidth',1.5);
y = -Us*sin(x+delta_ss)+Rs*iqref+omega_gn*Ls*idref;
fplot(y,[-2*pi,4],'k','lineWidth',1.5);
% plot(0,0,'Marker','.','MarkerSize',10,'Color','black');
% plot(-pi-2*delta_ss,0,'Marker','.','MarkerSize',10,'Color','black');
% plot(pi-2*delta_ss,0,'Marker','.','MarkerSize',10,'Color','black');
xlabel('u');
ylabel('sat(u)');

ax = gca;
ax.LineWidth=1;
ax.FontName='Times New Roman';
ax.FontSize = 10;
ax.XColor = 'black';
ax.YColor = 'black';
ax.ZColor = 'black';