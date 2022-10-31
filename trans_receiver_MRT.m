function [ BER ] = trans_receiver_MRT( N2,N,SNR,H,D)
% The BER analysis of MRT
% N——the nubmer of bits sent at the transmitter each turen
% SNR——The signal to noise ratio
% M  ——The number of antennas at the BS
% K ——the number of users

%% 部分参数设置
   sigma_2=1;                                % The variance of noise
   Pt=sigma_2*10^(SNR/10);                   % The total power at the BS
   [M,K]=size(H);
 %  Power=ones(K,1)*sqrt(Pt/K);                     % The transmission power 
   Power=ones(M,1)*sqrt(Pt/M);                     % The transmission power 
   
%% 模拟收发系统
  sum_err = zeros(1,N2);                                          % error_sum = 0;  the number of error bits
  for j=1:1:N2                                                    % send message N2 times, each time N bits
      %% 产生发送信息
        info_ready = randi([0 1],K,N);                             % original information bits
        trans_bits = pskmod(info_ready,2);                         % BPSK modulation, the output symbols are +1,-1
         
       %% the channel model      

         Power1=diag(Power);                                          % The transmission power
        [H,~ ] = channel_model( M,K,N);    
         H=H*D;
        % H_mrt=H;                                                     % Channel with MRT         
        % H_mrt=H_mrt/norm(H_mrt);    
         W_mrt=H;
        alpha_norm=trace(W_mrt'*W_mrt);                                 % The normalization factor
         H_mrt=W_mrt/sqrt(alpha_norm);
     %% Receive signal
         n= sqrt(1/2) * ( randn(K,N) + sqrt(-1)*  randn(K,N));         %  Additional Gaussian noise with variance 1
         %y =H'*Power1*H_mrt*trans_bits + n;                           %
         y =sqrt(Pt/K)*H'*H_mrt*trans_bits + n;                                %  y=hx+n the received signal vector at K users
        %% 接收信号处理 
        decision_bits = sign(real(y));                          % obatin the decision symbols at the real part
        demod_bits = pskdemod(decision_bits,2);                 %BPSK demodulation
        sum_err(j) = sum(sum(info_ready~=demod_bits));          %Compare with the information at the sender          
       
  end
  error_sum = sum(sum_err);                                     %Total number of error bits
  BER=error_sum/N/N2/K;                                         %The BER

end



