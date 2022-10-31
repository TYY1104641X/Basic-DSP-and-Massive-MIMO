clc;
close all;
clear;

%% Parameter Initializing
M=100;                                                       % The number of antennas
K=8;                                                         % The number of users
L=5;                                                         % The length of data string
N = 1e5;                                                     % each turn 10^5 bits
N2 = 20;                                                     % Repeat for 10 times
SNR_range=linspace(-10,20,11);                                 % The testing range of SNR
Len=length(SNR_range);                                       % The length of testing
BER_ZF40=zeros(Len,1);
BER_MRT40=zeros(Len,1);
BER_MMSE40=zeros(Len,1);
Thesh_D=0.3;                                                 % The threshold of distance

%% Large-scale fading matrix 
 if K>1
      %beta=ones(1,K);                                         % large-scale fading factors
      beta=rand(1,K);         
      beta(find(beta<Thesh_D))=0.3;                            % The low bound of large scale fading factor is 0.3                         
      D_beta=diag(sqrt(beta));                                 % large-scale fading matrix
 end

%% Ber analysis
for i=1:1:Len
    SNR=SNR_range(i);
    [H,~ ] = channel_model( M,K,L);                                % Obtain the channel matrix
    [ BER_ZF40(i) ] = trans_receiver_ZFBF( N2,N,SNR,H,D_beta );           % Calculate the BER of MIMO with ZFBF
    [ BER_MRT40(i) ] = trans_receiver_MRT( N2,N,SNR,H,D_beta );           % The BER of MIMO with MRT
    [ BER_MMSE40(i) ] = trans_receiver_MMSE( N2,N,SNR,H,D_beta );         % The BER of MIMO with MMSE
    fprintf('--------------------------Finish %d dB----------------------------\n',SNR);
end 


%% PLot the figure
figure(2);
semilogy(SNR_range,BER_ZF40,'k-o');
hold on;
semilogy(SNR_range,BER_MRT40,'b-s');
semilogy(SNR_range,BER_MMSE40,'r-*');
grid on;
legend('ZFBF N=100','MFBF N=100','RZFBF N=100');
xlabel('SNR [dB]'),ylabel('BER');
title(['BER-SNR analysis of MU-MIMO system']);
%xlabel('信噪比 [dB]'),ylabel('误码率');
%title(['Massive MIMO的信噪比和误码率分析']);
axis([-10 20 1e-6 1e-0]);
hold off;

%% 64 antennas
M=200;
BER_ZF64=zeros(Len,1);
BER_MRT64=zeros(Len,1);
BER_MMSE64=zeros(Len,1);

%% Ber analysis
for i=1:1:Len
    SNR=SNR_range(i);
    [H,~ ] = channel_model( M,K,L);                                     % Obtain the channel matrix
    [ BER_ZF64(i) ] = trans_receiver_ZFBF( N2,N,SNR,H,D_beta );           % Calculate the BER of MIMO with ZFBF
    [ BER_MRT64(i) ] = trans_receiver_MRT( N2,N,SNR,H,D_beta );           % The BER of MIMO with MRT
    [ BER_MMSE64(i) ] = trans_receiver_MMSE( N2,N,SNR,H,D_beta );         % The BER of MIMO with MMSE
    fprintf('--------------------------Finish %d dB----------------------------\n',SNR);
end 




%% PLot the figure
figure(1);
semilogy(SNR_range,BER_ZF40,'k-o');
hold on;
semilogy(SNR_range,BER_MRT40,'b-s');
semilogy(SNR_range,BER_MMSE40,'r-*');
semilogy(SNR_range,BER_ZF64,'k-+');
semilogy(SNR_range,BER_MRT64,'b-^');
semilogy(SNR_range,BER_MMSE64,'r->');
grid on;
legend('ZFBF N=100','MFBF N=100','RZFBF N=100','ZFBF N=200','MFBF N=200','RZFBF N=200');
xlabel('SNR [dB]'),ylabel('BER');
title(['BER-SNR analysis of MU-MIMO system']);
%xlabel('信噪比 [dB]'),ylabel('误码率');
%title(['Massive MIMO的信噪比和误码率分析']);
axis([-10 20 1e-7 1e-0]);
hold off;
