figure(1);
t=coursebijiao(:,1);
plot(t,coursebijiao(:,2),'b--',t,coursebijiao(:,3),'r:',t,coursebijiao(:,4),'k','linewidth',2);
xlabel('t/s','fontsize',24);ylabel('course/��','fontsize',24);
legend('new algorithm','original with delay','original without delay');

%��ͼ�ǲ�ͬ��ʱ�Ƚϣ���Ҫ�ı�ϵͳ��scope�еı������֣��������Σ���ʱģ���趨Ϊ250,300,350��400�õ��Ƚ�ֵ
figure(2);
t1=coursebijiao1(:,1);t2=coursebijiao2(:,1);t3=coursebijiao3(:,1);t4=coursebijiao4(:,1);
plot(t1,coursebijiao1(:,2),'b',t2,coursebijiao2(:,2),'b:',t3,coursebijiao3(:,2),'b--',t4,coursebijiao4(:,2),'b-.','linewidth',2);
xlabel('t/s','fontsize',24);ylabel('course/��','fontsize',24);
legend('\tau1','\tau2','\tau3','\tau4');







