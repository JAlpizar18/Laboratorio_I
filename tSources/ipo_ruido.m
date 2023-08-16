% Carga los archivos de audio
[audio_data1, sample_rate1] = audioread('ruido_ambiente_desde_celular.wav');
[audio_data2, sample_rate2] = audioread('ruido ambiente laptop.wav');

% Configuración para el cálculo del espectrograma
window_size = 512;
overlap = 256;
nfft = 1024;

% Calcula los espectrogramas
[spectrogram1, frequencies1, times1] = spectrogram(audio_data1, hamming(window_size), overlap, nfft, sample_rate1);
[spectrogram2, frequencies2, times2] = spectrogram(audio_data2, hamming(window_size), overlap, nfft, sample_rate2);

% Grafica los espectrogramas
figure;

subplot(2, 1, 1);
imagesc(times1, frequencies1, 10 * log10(abs(spectrogram1)));
axis xy;
title('Espectrograma - Ruido desde Celular');
xlabel('Tiempo (s)');
ylabel('Frecuencia (Hz)');
colorbar;

subplot(2, 1, 2);
imagesc(times2, frequencies2, 10 * log10(abs(spectrogram2)));
axis xy;
title('Espectrograma - Ruido desde Laptop');
xlabel('Tiempo (s)');
ylabel('Frecuencia (Hz)');
colorbar;

colormap jet;







