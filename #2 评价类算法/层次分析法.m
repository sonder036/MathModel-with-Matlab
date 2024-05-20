A=input('输入判断矩阵:');                % 输入判断矩阵
%% 计算一致性比例CR
n=size(A,1);                            %求出判断矩阵阶数
[V,D]=eig(A);                           %求出特征值和特征向量
Max_eig=max(D(:));                      %找出最大特征值
CI=(Max_eig-n)/(n-1);                   %计算一致性指标
RI=[0 0 0.52 0.89 1.12 1.26 1.36];      %列出平均随机一致性指标
CR=CI/RI(n);                            %求出一致性比例
if(CR<0.1)                              %判断一致性是否能接受
    disp("一致性可以接受!");
else
    disp("一致性检验未通过，需要修改判断矩阵!");
end
%% 方法一：算数平均法求权重
Product_A=sum(A,2);                    %将判断矩阵每行相乘
Product_n_A=Product_A./n;              %求几何平均值
w_ari=Product_n_A./sum(Product_n_A);   %将其标准化
disp('算数平均值值法求权重结果为:');     %输出结果
disp(w_ari);    
%% 方法二：几何平均法求权重
Product_B=prod(A,2);                    %将判断矩阵每行相乘
Product_n_B=Product_B.^(1/n);           %求几何平均值
w_geo=Product_n_B./sum(Product_n_B);    %将其标准化
disp('几何平均值值法求权重结果为:');      %输出结果
disp(w_geo);             
%% 方法三：特征值法求权重
[r,c]=find(D==Max_eig,1);               %找到最大特征值的位置
w_eig=V(:,c)./sum(V(:,c));              %找到相应的特征向量，并将其标准化
disp('特征值法求权重结果为:');            %输出结果
disp(w_eig); 