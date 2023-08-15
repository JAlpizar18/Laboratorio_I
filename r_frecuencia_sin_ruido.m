% Nombres de los archivos WAV
archivo_audio_celular = 'barrido desde celular.wav';
archivo_audio_laptop = 'barrido desde laptop.wav';
archivo_ruido_1 = 'ruido_ambiente_desde_celular.wav';
archivo_ruido_2 = 'ruido ambiente laptop.wav';

try
    % Cargar los archivos WAV
    [audio_celular, fs_celular] = audioread(archivo_audio_celular);
    [audio_laptop, fs_laptop] = audioread(archivo_audio_laptop);
    [ruido_1, fs_ruido_1] = audioread(archivo_ruido_1);
    [ruido_2, fs_ruido_2] = audioread(archivo_ruido_2);

    % Asegurarse de que las longitudes sean iguales
    min_length = min([length(audio_celular), length(audio_laptop), length(ruido_1), length(ruido_2)]);
    
    % Restar el ruido a las señales de audio
    audio_celular_sin_ruido = audio_celular(1:min_length) - ruido_1(1:min_length);
    audio_laptop_sin_ruido = audio_laptop(1:min_length) - ruido_2(1:min_length);

    % Calcular la respuesta en frecuencia utilizando la Transformada de Fourier
    n_celular = length(audio_celular_sin_ruido);
    f_celular = (0:(n_celular/2)) * fs_celular / n_celular;
    audio_fft_celular = fft(audio_celular_sin_ruido);
    respuesta_frecuencia_celular = abs(audio_fft_celular(1:n_celular/2+1));

    n_laptop = length(audio_laptop_sin_ruido);
    f_laptop = (0:(n_laptop/2)) * fs_laptop / n_laptop;
    audio_fft_laptop = fft(audio_laptop_sin_ruido);
    respuesta_frecuencia_laptop = abs(audio_fft_laptop(1:n_laptop/2+1));

    % Graficar la respuesta en frecuencia en escala logarítmica para celular
    figure;
    semilogx(f_celular, 20*log10(respuesta_frecuencia_celular));
    title('Respuesta en Frecuencia de celular sin ruido');
    xlabel('Frecuencia (Hz)');
    ylabel('Magnitud (dB)');
    xlim([20, 20000]);
    grid on;

    % Graficar la respuesta en frecuencia en escala logarítmica para laptop
    figure;
    semilogx(f_laptop, 20*log10(respuesta_frecuencia_laptop));
    title('Respuesta en Frecuencia de laptop sin ruido');
    xlabel('Frecuencia (Hz)');
    ylabel('Magnitud (dB)');
    xlim([20, 20000]);
    grid on;

catch exception
    disp(['Error: ' exception.message]);
end

