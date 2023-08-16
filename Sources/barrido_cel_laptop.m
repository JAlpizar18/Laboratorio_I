% Nombre del archivo WAV
archivo_audio_celular = 'barrido desde celular.wav';
archivo_audio_laptop = 'barrido desde laptop.wav';

try
    % Cargar el archivo WAV
    [audio_celular, fs_celular] = audioread(archivo_audio_celular);
    [audio_laptop, fs_laptop] = audioread(archivo_audio_laptop);

    % Calcular la respuesta en frecuencia utilizando la Transformada de
    % Fourier para celular
    n_celular = length(audio_celular);
    f_celular = (0:(n_celular/2)) * fs_celular / n_celular;
    audio_fft_celular = fft(audio_celular);
    respuesta_frecuencia_celular = abs(audio_fft_celular(1:n_celular/2+1));

    % Calcular la respuesta en frecuencia utilizando la Transformada de
    % Fourier para laptop
    n_laptop = length(audio_laptop);
    f_laptop = (0:(n_laptop/2)) * fs_laptop / n_laptop;
    audio_fft_laptop = fft(audio_laptop);
    respuesta_frecuencia_laptop = abs(audio_fft(1:n_laptop/2+1));

    % Graficar la respuesta en frecuencia en escala logarítmica para
    % celular
    figure;
    semilogx(f_celular, 20*log10(respuesta_frecuencia_celular));
    title('Respuesta en Frecuencia de celular');
    xlabel('Frecuencia (Hz)');
    ylabel('Magnitud (dB)');
    xlim([20, 20000]);
    grid on;

    % Graficar la respuesta en frecuencia en escala logarítmica para
    % laptop
     figure;
    semilogx(f_laptop, 20*log10(respuesta_frecuencia_laptop));
    title('Respuesta en Frecuencia de laptop');
    xlabel('Frecuencia (Hz)');
    ylabel('Magnitud (dB)');
    xlim([20, 20000]);
    grid on;


catch exception
    disp(['Error: ' exception.message]);
end
