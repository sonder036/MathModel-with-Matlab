x=-pi:pi,y=sin(x);
new_x=-pi:0.1:pi
new_y1=pchip(x,y,new_x);
new_y2=spline(x,y,new_x);
plot(x,y,'ko');
hold on;%% 保留窗口，让下一张图在窗口上继续画，这三行也可以写为 plot(x,y,'ro',new_x,new_y,'-b');
plot(new_x,new_y1,'-b');
plot(new_x,new_y2,'-r');
legend('基准点','三次埃尔米特插值','三次样条插值','Location','southeast');  
					%依次为三个点线的标识，后两个参数为表示标识位置