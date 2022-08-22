N = 1000; % число передаваемых бит
x = randint(N, 1); % цифровое сообщение
M = 2; % двоична€ манипул€ци€
Fd = 250; % символьна€ скорость
Fs = 10000; % частота дискретизации
f0 = 750; % частота Унул€Ф
f1 = 1500; % частота УединицыФ
Fc = (f0 + f1) / 2; % средн€€ частота
tone = f1 - f0; % разнос частот
s = dmod(x, Fc, Fd, Fs, 'fsk', M, tone); % манипулированный сигнал
snr = -10:10; % вектор отношений —/Ў (в децибелах)
for k = 1:length(snr)
sn = awgn(s, snr(k), 'measured'); % добавляем шум
% когерентная демодуляция
y_c = ddemod(sn, Fc, Fd, Fs, 'fsk', M, tone);
% некогерентная демодуляция
y_nc = ddemod(sn, Fc, Fd, Fs, 'fsk/noncoherence', M, tone);
% расчет вероятностей ошибок
[n_err, er_c(k)] = symerr(x, y_c);
[n_err, er_nc(k)] = symerr(x, y_nc);
end
% вывод графика
semilogy(snr, er_c, snr, er_nc)

