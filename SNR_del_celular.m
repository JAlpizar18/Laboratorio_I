% Carga las señales de audio
[senal_original, fs] = audioread('tono_1khz_desde_celular.wav');
[senal_ruido, ~] = audioread('ruido_ambiente_desde_celular.wav');

% Asegura que ambas señales tengan la misma longitud
min_length = min(length(senal_original), length(senal_ruido));
senal_original = senal_original(1:min_length);
senal_ruido = senal_ruido(1:min_length);

% Define las muestras a considerar
inicio_muestra = 28000; 
fin_muestra = 33000;    

% Toma las muestras de las señales
muestra_original = senal_original(inicio_muestra:fin_muestra);
muestra_ruido = senal_ruido(inicio_muestra:fin_muestra);

% Calcula la energía de la señal y el ruido en las muestras
energia_senal = sum(muestra_original.^2);
energia_ruido = sum(muestra_ruido.^2);

% Calcula la SNR en dB
snr_db = 10 * log10(energia_senal / energia_ruido + eps);

% Grafica las muestras de las señales
t = (inicio_muestra:fin_muestra) / fs; % Vector de tiempo
subplot(2,1,1);
plot(t, muestra_original);
title('Muestra de Señal Original');
xlabel('Tiempo (s)');
ylabel('Amplitud');

subplot(2,1,2);
plot(t, muestra_ruido);
title('Muestra de Señal de Ruido del celular');
xlabel('Tiempo (s)');
ylabel('Amplitud');

% Muestra el valor de SNR
fprintf('SNR: %.2f dB\n', snr_db);