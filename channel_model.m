function [H,n ] = channel_model( M,K,N)
%   �����ʺ�ʵ�ʻ������ŵ�
%   M������վ����������k�����������û�������t����CSI��ȡʱ��������
% clc;
% clear all;
% 
% %% ��ʼ�����˺��ֶε���������
% M=20;
% k=4;   
% t=0.3;                                                     % CSI��ȡ�ǵ�������

%% ��������ͬ�ֲ���ѭ���ԳƸ�˹�ŵ���
h = sqrt(1/2) * ( randn(M,K) + sqrt(-1)*  randn(M,K) );      %����Mxk������Ϊ1����ֵΪ0���ŵ�����
% seta=2*pi*rand(M,k);                                           %������λ
% seta=cos(seta)+sqrt(-1)*sin(seta);
% mode=randn(M,k);                                               %�ŵ���ģ
% h=mode.*seta;                                                  %ѭ���ԳƸ�˹�ŵ�

%% ����Բ�����ʼ��
% Phy=zeros(M,M);                                                % ����Է��;����ʼ��
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

% h = sqrt(1/2) * ( randn(M,k) + sqrt(-1)*  randn(M,k) );      %����Mxk������Ϊ1����ֵΪ0���ŵ�����
%  h=orth(h);                                                   %����������
% if K>1
%      beta=rand(1,K);                                         % ���ɴ�߶�˥�����ĶԽ�Ԫ��
%      D_beta=diag(beta);                                      % ���ɴ�߶�˥�����
%      h=h*sqrt(D_beta)  ;                                     % ���û��ŵ�����
% end
% % h=orth(h);                                                   %����������
%% ��������ŵ�
% h=Tm*h;                                                         % �������ŵ�
        
  %% ������ŵ�������
%                                            %�ŵ���ģ
% e=mode.*seta; 
%  
% %  e=sqrt(1/2) * ( randn(M,k) + sqrt(-1)*  randn(M,k) );
%  [p,q]=size(e);
%  for i=1:q
%      e(:,i)=e(:,i)/norm(e(:,i));                             %���������ÿһ�н��й�һ������
%  end
%  
 %% ����MMSE�㷨����վ��õ�CSI
% H=sqrt(1-t^2)*h+t*e;                                        %BS��ȡ��CSI 
% %  H=orth(H);                                               %����������        
% 
% 
 %% ��������
seta=2*pi*rand(K,N);                                           %������λ
seta=cos(seta)+sqrt(-1)*sin(seta);
mode=randn(K,N);                                               %�ŵ���ģ
n=mode.*seta;  
H=h;

end

