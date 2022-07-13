function [sys,x0,str,ts]=yundong(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 2;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      =2;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;

sys=simsizes(sizes);
x0=[0,0];
str=[];
ts=[0 0];
function sys=mdlDerivatives(t,x,u)
 Cb=0.7 ; % 方形系数
 B=32.26; % 船宽
L=183;   % 两柱间船长
% Ar=18 ;% 舵叶面积
% % dm=11.1042  ;%平均吃水
 dm=5.27;
 d=dm;% 满载吃水
% % da=11.2102 ;%尾吃水
% da=6.7;
% % df=10.9982 ;%艏吃水
% df=3.9;
% v=7.15;%船舶航速，可取额定航速m/s
 rou=1025;%kg/m^3
 u0=7.15;%船舶航速，可取额定航速m/s
% m=rou*L*B*d*Cb;
% pai=3.1415926;
% %周昭明公式
% mx=(m/100)*(0.398+11.97*Cb*(1+3.73*d/B)-2.89*Cb*L/B*(1+1.13*d/B)+0.175*Cb*((L/B)^2)*(1+0.541*d/B)-1.107*L/B*d/B);
% my=m*(0.882-0.54*Cb*(1-1.6*d/B)-0.156*L/B*(1-0.673*Cb)+0.826*d/B*L/B*(1-0.678*d/B)-0.638*Cb*d/B*L/B*(1-0.669*d/B));
% Jzz=(L^2)*(33-76.85*Cb*(1-0.784*Cb)+3.43*L/B*(1-0.63*Cb))/100;
% %一撇系统的无量纲值
% md=m/(0.5*rou*(L^2)*d);
% mdx=mx/(0.5*rou*(L^2)*d);
% mdy=my/(0.5*rou*(L^2)*d);
% Ydv=-(pai/2*lmda+1.4*Cb*B/L)*(1+0.67*tao);
% Ydr=pai/4*lmda*(1+0.8*tao);
% Yddeta=-(1+ah)*Ar*f/L/d;
m=0.24688*(0.5*rou*(L^2)*d);
mx=0.0088*(0.5*rou*(L^2)*d);
my=0.1103*(0.5*rou*(L^2)*d);
Yv=-0.3569*(0.5*rou*L*d*u0);
Yr=0.0645*(0.5*rou*(L^2)*d*u0);
Ydeta=-0.0048*(0.5*rou*L*d*(u0^2));
% md=0.0098;
% mdx=0.0088;
% mdy=0.1103;
% Ydv=-0.004;
% Ydr=1.1761e-005;
% Yddeta=0.0016;


%计算u的参数xh、xp
paishui=10806;
Lw=183;
miu=1.07854e006;
Rn=u0*L/miu;
s=(paishui^(2/3))*(3.432+0.305*Lw/B+0.443*B/d+0.643*Cb);
cf=0.075/((log10(Rn)-2.03)^2);
car=0.0002;
cp=0.8;%(cp=cb/cw;cw=0.87)
cr=2.003e-003;
ct=cf+cr+car;
xhc=-(s/(L*d))*ct;

wp=0.5*Cb-0.05;
tp=0.6*wp;
T=500; %螺旋桨推力
xp=(1-tp)*T;
n=126/60;%r/s
Dp=5.85;%m0
xdp=xp/(rou*(n^2)*(Dp^4));

r=u(1);
deta=u(2);



%量纲化
sys(1)=(Yv*x(1)+Yr*r+Ydeta*deta-(m+mx)*(x(2))*r)/(m+my);
sys(2)=((m+my)*x(1)*r+xhc*(x(2))^2*(0.5*rou*(u0^2)*L*d)+xp)/(m+mx);


function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);