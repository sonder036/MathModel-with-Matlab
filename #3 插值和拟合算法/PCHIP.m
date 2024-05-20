x=-pi:pi,y=sin(x);
new_x=-pi:0.1:pi
new_y=pchip(x,y,new_x);
plot(x,y,'ro');
hold on;%% 保留窗口，让下一张图在窗口上继续画，这三行也可以写为 plot(x,y,'ro',new_x,new_y,'-b');
plot(new_x,new_y,'-b');
%% plot参数
%% 线方式:  -实线 :点线 -.虚点线 --波折线d
%% 点方式:  .圆点 +加号 *星号 x x形 o小圆
%% 颜色: y黄 r红 g绿 b蓝 k黑