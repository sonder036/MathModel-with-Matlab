populate_data=[133126 133770 134413 135069 135738 136427 137221 137866 138639 139538]
year=2009:2018
p1 = pchip(year,populate_data,2019:2021);
p2 = spline(year,populate_data,2019:2021);
plot(year,populate_data,'o',2019:2021,p1,'r*-',2019:2021,p2,'b*-');
legend('样本点','三次埃尔米特插值预测','三次样条插值预测','Location','northwest');
title('预测2019-2021人口','FontSize',15);