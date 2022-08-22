N = 1000; % ����� ������������ ���
x = randint(N, 1); % �������� ���������
M = 2; % �������� �����������
Fd = 250; % ���������� ��������
Fs = 10000; % ������� �������������
f0 = 750; % ������� ������
f1 = 1500; % ������� ���������
Fc = (f0 + f1) / 2; % ������� �������
tone = f1 - f0; % ������ ������
s = dmod(x, Fc, Fd, Fs, 'fsk', M, tone); % ���������������� ������
snr = -10:10; % ������ ��������� �/� (� ���������)
for k = 1:length(snr)
sn = awgn(s, snr(k), 'measured'); % ��������� ���
% ����������� �����������
y_c = ddemod(sn, Fc, Fd, Fs, 'fsk', M, tone);
% ������������� �����������
y_nc = ddemod(sn, Fc, Fd, Fs, 'fsk/noncoherence', M, tone);
% ������ ������������ ������
[n_err, er_c(k)] = symerr(x, y_c);
[n_err, er_nc(k)] = symerr(x, y_nc);
end
% ����� �������
semilogy(snr, er_c, snr, er_nc)

