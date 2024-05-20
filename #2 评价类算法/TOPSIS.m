%%步骤一：读取数据  
clear;clc  
load data_water_quality.mat                      %读取数据  
[r,c]=size(X);  
disp('····················读取数据成功····················');  
disp(['评价对象数量为：',num2str(r)]);  
disp(['评价指标数量为：',num2str(c)]);  
%%步骤二：对指标进行正向化处理  
disp('····················进行正向化处理····················');  
Type=input('请按顺序输入各列指标类型：1.极大型 2.极小型 3.中间型 4.区间型:'); 
for i = 1:c  
    if Type(i)==1  
        disp(['第' num2str(i) '列是极大型，无需正向化'] );  
        disp('~~~~~~~~~~~~~~~~~~~~分界线~~~~~~~~~~~~~~~~~~~~');  
    elseif Type(i)==2  
        disp(['第' num2str(i) '列是极小型，进行正向化'] );  
        Maxx=max(X);                          %找出最大值  
        for j = 1:r                           %进行正向化  
            X(j,i)=Maxx(i)-X(j,i);  
        end  
        disp('~~~~~~~~~~~~~~~~~~~~分界线~~~~~~~~~~~~~~~~~~~~');  
    elseif Type(i)==3  
        disp(['第' num2str(i) '列是中间型，进行正向化'] );  
        best=input('请输入最优值：');                                       %7  
        M=max(abs(X(:,i)-best));             %找出距离最优值最远距离  
        for j = 1:r                          %进行正向化  
            X(j,i)=1-abs(X(j,i)-best)/M;  
        end  
        disp('~~~~~~~~~~~~~~~~~~~~分界线~~~~~~~~~~~~~~~~~~~~');  
    elseif Type(i)==4  
        disp(['第' num2str(i) '列是区间型，进行正向化'] );  
        L=input('请输入最优区间下界：');                                    %10  
        R=input('请输入最优区间上界：');                                    %20  
        M=0;  
        for j = 1:r                         %找出距离最优区间最远距离  
            if X(j,i)<L  
                M=max(M,L-X(j,i));  
            elseif X(j,i)>R  
                M=max(M,X(j,i)-R);  
            end  
        end    
        for j = 1:r                         %进行正向化  
            if X(j,i)<L  
                X(j,i)=1-(L-X(j,i))/M;  
            elseif X(j,i)>R  
                X(j,i)=1-(X(j,i)-R)/M;  
            else  
                X(j,i)=1;  
            end  
        end    
        disp('~~~~~~~~~~~~~~~~~~~~分界线~~~~~~~~~~~~~~~~~~~~');  
    else  
        disp('没有预设处理该类型的指标，请检查输入是否正确。');  
    end  
end  
disp('····················正向化处理完成····················');  
disp('··················正向化处理后矩阵为···················');  
disp(X);  
%%步骤三：处理指标权重  
judge_flag=input('如果需要对指标加入权重输入1，否则输入0：');            %0  
if judge_flag==1  
    weight=input('请按顺序输入每个指标的权重(注意权重和应为1)：');             %[0.2,0.2,0.3,0.3]  
    flag=0;  
    while flag==0                               %判断指标权重是否合法 
        if(abs(sum(weight)-1)<0.0000001 && size(weight,1)==1 && size(weight,2)==c )  
            flag=1;  
        else  
            weight=input('输入有误，请重新输入：');  
        end  
    end  
else  
    weight=ones(1,c)./c;  
end  
%%步骤四：化为标准化矩阵  
disp('··················标准化处理后矩阵为···················');  
Z=X./repmat(sum(X.*X) .^ 0.5,r,1);              %将矩阵标准化处理  
disp(Z);  
%%步骤五：计算得分  
D_max=sum([ (Z - repmat(max(Z),r,1)) .^ 2 ] .* repmat(weight,r,1) ,2) .^0.5;  
D_min=sum([ (Z - repmat(min(Z),r,1)) .^ 2 ] .* repmat(weight,r,1) ,2) .^0.5;  
Grade=D_min./(D_max+D_min);                     %计算出未归一化得分  
Grade=Grade./sum(Grade);                        %将得分归一化  