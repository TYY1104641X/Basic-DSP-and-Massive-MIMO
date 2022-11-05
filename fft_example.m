
% fft example practive

clc;
clear all;
close all;


%% Initialize parameters  pSD by DFT^2



fs=120;
N=48;
ind=1:1:N;
x1=sin(2*pi*10*ind*1/fs);
x2=0.5*sin(2*pi*20*ind*1/fs);
%disp(x1)
figure(1);
plot(x1);
hold on;
plot(x2);
hold off;

x3=x1+x2;

%%
y1=fft(x1);
y1=fftshift(y1);
y2=fft(x2);
y2=fftshift(y2);

py2=real(y2).^2+imag(y2).^2;
py1=real(y1).^2+imag(y1).^2;
X=([1:1:N]-N/2-1)*fs/N;
figure(2);
plot(X,(py1+py2)/N^2);

%% power spectrum by DFT

y3=fft(x3);
py3=fftshift(abs(y3).^2);
figure(3)
plot(X,(py3)/N^2);


%% Power spectrum by autocorrelation
Rx3=[];
for i=1:1:N
    x3_s=zeros(1,N);
    x3_s(1:N-i)=x3(i+1:N);
    x3_s(N-i+1:N)=x3(1:i);
    c=conj(x3);
    d=x3_s.*c;
    %disp(d)
    R=sum(x3_s.*c);
   % disp(R)
    Rx3=[Rx3,R];
end 
figure(4);
py3_r=fft(Rx3);
plot(X, fftshift(abs(py3_r))/N^2);
%disp(Rx3);


