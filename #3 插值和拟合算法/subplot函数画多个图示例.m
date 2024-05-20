x=-pi:pi,y=sin(x);
fx=linspace(-pi,pi);    %默认在[-pi,pi]间取100个点
fy=sin(fx);

subplot(3,2,[1,2]);
plot(fx,fy,'k-',LineWidth=1.5);
hold on;
plot(x,y,'ko');
title('原函数与基准点',fontsize=15);

new_x=-pi:0.1:pi
new_y1=pchip(x,y,new_x);
new_y2=spline(x,y,new_x);
plot(x,y,'ko');
subplot(3,2,3);
plot(new_x,new_y1,'-.b',LineWidth=1.5);
title('三次埃尔米特插值',fontsize=15);

subplot(3,2,4);
plot(new_x,new_y2,'-.r',LineWidth=1.5);
title('三次样条插值',fontsize=15);

subplot(3,2,[5,6]);
plot(fx,fy,'k-',LineWidth=1.5);
hold on;
plot(x,y,'ko');
plot(new_x,new_y1,'-.b',LineWidth=1.5);
plot(new_x,new_y2,'-.r',LineWidth=1.5);
legend('原函数','基准点','三次埃尔米特插值','三次样条插值','Location','southeast'); 
title('综合对比图',fontsize=15);