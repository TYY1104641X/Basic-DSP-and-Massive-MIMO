function [H,n ] = channel_model( M,K,N)
%   创建适合实际环境的信道
%   M——基站天线数量；k——单天线用户数量；t——CSI获取时的误差参数
% clc;
% clear all;
% 
% %% 初始化发端和手段的天线数量
% M=20;
% k=4;   
% t=0.3;                                                     % CSI获取是的误差参数

%% 产生独立同分布的循环对称高斯信道；
h = sqrt(1/2) * ( randn(M,K) + sqrt(-1)*  randn(M,K) );      %产生Mxk，方差为1，均值为0的信道矩阵
% seta=2*pi*rand(M,k);                                           %均匀相位
% seta=cos(seta)+sqrt(-1)*sin(seta);
% mode=randn(M,k);                                               %信道的模
% h=mode.*seta;                                                  %循环对称高斯信道

%% 相干性参数初始化
% Phy=zeros(M,M);                                                % 相干性发送矩阵初始化
% for i=1:M
%     for j=1:M
%         if i<j
%           Phy(i,j)=rho^(abs(j-i)); 
%         else 
%           Phy(i,j)=(rho^(abs(j-i)))';   
%         end 
%     end 
% end
% Tm=sqrtm(Phy);

% h = sqrt(1/2) * ( randn(M,k) + sqrt(-1)*  randn(M,k) );      %产生Mxk，方差为1，均值为0的信道矩阵
%  h=orth(h);                                                   %矩阵正交化
% if K>1
%      beta=rand(1,K);                                         % 生成大尺度衰落矩阵的对角元素
%      D_beta=diag(beta);                                      % 生成大尺度衰落矩阵
%      h=h*sqrt(D_beta)  ;                                     % 多用户信道矩阵
% end
% % h=orth(h);                                                   %矩阵正交化
%% 产生想干信道
% h=Tm*h;                                                         % 获得想干信道
        
  %% 引入的信道误差矩阵
%                                            %信道的模
% e=mode.*seta; 
%  
% %  e=sqrt(1/2) * ( randn(M,k) + sqrt(-1)*  randn(M,k) );
%  [p,q]=size(e);
%  for i=1:q
%      e(:,i)=e(:,i)/norm(e(:,i));                             %对误差矩阵的每一列进行归一化处理。
%  end
%  
 %% 基于MMSE算法，基站获得的CSI
% H=sqrt(1-t^2)*h+t*e;                                        %BS获取的CSI 
% %  H=orth(H);                                               %矩阵正交化        
% 
% 
 %% 噪声产生
seta=2*pi*rand(K,N);                                           %均匀相位
seta=cos(seta)+sqrt(-1)*sin(seta);
mode=randn(K,N);                                               %信道的模
n=mode.*seta;  
H=h;

end

