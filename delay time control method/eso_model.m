function [sys,x0,str,ts]=eso_model(t,x,u,flag)
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
sizes.NumContStates  = 6;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 6;
sizes.NumInputs      =2;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;

sys=simsizes(sizes);
x0=[0,0,0,0,0,0];
str=[];
ts=[0 0];
function sys=mdlDerivatives(t,x,u)
B=1.1397e-005;%k/(t1*t2)
ut=u(2);


e=x(1)-u(1);

%线性系数
% la1=50*3;
% la2=3*50^2;
% la3=50^3;
% la4=50^4;
% la5=50^5;
% la6=50^6;
%菲波纳奇数列
h=0.1;
la1=1;
la2=1/3*h;
la3=2/(8*h)^2;
la4=3/(13*h)^3;
la5=5/(21*h)^4;
la6=8/(34*h)^5;

tao=0.01;%延时

%线性模型
% sys(1)=x(2)-la1*e;
% sys(2)=(-2*x(1)-2*tao*x(2)+2*x(3))/tao^2-la2*e;
% sys(3)=x(4)-la3*e;
% sys(4)=x(5)-la4*e;
% sys(5)=x(6)-la5*e+B*ut;
% sys(6)=-la6*e;


%非线性fal函数

delt=0.05;%不能太大
a=0.19;

if abs(e)>delt
     fal=(abs(e)*a)*sign(e);
else 
    fal=e/(delt^(1-a));
end
% 0<a<1;delt>0
 A=0.1206;
K=0.0118;
 B=0.35;
%非线性模型
sys(1)=x(2)-la1*fal;
sys(2)=(-2*x(1)-2*tao*x(2)+2*x(3))/tao^2-la2*fal;
sys(3)=x(4)-la3*fal;
sys(4)=x(5)-la4*fal;
sys(5)=x(6)-la5*fal+B*ut-B/K*(x(4))-A*x(5);
% sys(5)=x(6)-la5*fal+B*ut;
sys(6)=-la6*fal;










function sys=mdlOutputs(t,x,u)
sys(1)=x(1);
sys(2)=x(2);
sys(3)=x(3);
sys(4)=x(4);
sys(5)=x(5);
sys(6)=x(6);