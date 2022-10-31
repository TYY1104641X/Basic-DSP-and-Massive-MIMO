clc;
close all;
clear;

%% Parameter Initializing
M_range=linspace(20,160,8);                                % The range of the number of antennas at the BS
K=8;                                                         % The number of users
L=5;                                                         % The length of data string
N = 1e5;                                                     % The number of bits each time
N2 = 20;                                                     % repeat sending 10 times
SNR=10;                                                      % The SNR at the BS
%SNR_range=linspace(0,20,11);                                 % The testing range of SNR
Len=length(M_range);                                       % The length of testing
BER_ZF=zeros(Len,1);
BER_MRT=zeros(Len,1);
BER_MMSE=zeros(Len,1);
Thesh_D=0.3;                                                 % The threshold of distance

%% Large-scale fading matrix 
 if K>1
      beta=rand(1,K);                                         %  Large-scale matrix
      beta(find(beta<Thesh_D))=0.3;                            % The low bound of large scale fading factor is 0.3      
      D_beta=diag(sqrt(beta));                                   
 end

%% Ber analysis
for i=1:1:Len
    M=M_range(i);
    [H,~ ] = channel_model( M,K,L);                                % Obtain the channel matrix
    [ BER_ZF(i) ] = trans_receiver_ZFBF( N2,N,SNR,H,D_beta );           % Calculate the BER of MIMO with ZFBF
    [ BER_MRT(i) ] = trans_receiver_MRT( N2,N,SNR,H,D_beta );           % The BER of MIMO with MRT
    [ BER_MMSE(i) ] = trans_receiver_MMSE( N2,N,SNR,H,D_beta );         % The BER of MIMO with MMSE
    fprintf('--------------------------Finish %d number of antennas----------------------------\n',M);
end 


%% PLot the figure
figure(1);
semilogy(M_range,BER_ZF,'k-o');
hold on;
semilogy(M_range,BER_MRT,'b-s');
semilogy(M_range,BER_MMSE,'r-*');
grid on;
legend('ZFBF SNR=10','MFBF SNR=10','RZFBF SNR=10');
xlabel('Number of antennas [N]'),ylabel('BER');
title(['BER-N analysis of MU-MIMO system']);
%xlabel('信噪比 [dB]'),ylabel('误码率');
%title(['Massive MIMO的信噪比和误码率分析']);
axis([20 160 1e-6 1e-0]);
hold off;
