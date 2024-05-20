load gdp.mat;
Mean=mean(gdp);
gdp=gdp./repmat(Mean,size(gdp,1),1);    %将Mean复制为size(gdp,1)行的矩阵
disp('预处理后矩阵为:');
disp(gdp);

Y=gdp(:,1);                             %第一列为母序列
X=gdp(:,2:end);                         %其余列为子序列
abs_X_Xi=abs(X-repmat(Y,1,size(X,2)));  %计算|X-xi|矩阵
a=min(min(abs(abs_X_Xi)));              %计算两极最小差
b=max(max(abs(abs_X_Xi)));              %计算两极最大差
rho=0.5;                                %定义分辨系数
gamma=(a+rho*b)./(abs_X_Xi+rho*b);      %计算关联系数
disp('各子序列灰色关联度为:')
disp(mean(gamma));