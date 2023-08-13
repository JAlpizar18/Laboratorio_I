% Nombres de los archivos WAV
archivo_tono_laptop = 'tono 1kHz desde laptop.wav';
archivo_ruido_laptop = 'ruido ambiente laptop.wav';


archivo_tono_celular = 'tono 1kHz desde celular.wav';
archivo_ruido_celular = 'ruido_ambiente_desde_celular.wav';
try
    % Cargar los archivos WAV
    [tono_laptop, fs_tono_laptop] = audioread(archivo_tono_laptop);
    [ruido_laptop, fs_ruido_laptop] = audioread(archivo_ruido_laptop);

    [tono_celular, fs_tono_celular] = audioread(archivo_tono_celular);
    [ruido_celular, fs_ruido_celular] = audioread(archivo_ruido_celular);

    % Calcular la PSD del tono y el ruido
    [pxx_tono_laptop, f_tono_laptop] = pwelch(tono_laptop, [], [], [], fs_tono_laptop);
    [pxx_ruido_laptop, f_ruido_laptop] = pwelch(ruido_laptop, [], [], [], fs_ruido_laptop);

    [pxx_tono_celular, f_tono_celular] = pwelch(tono_celular, [], [], [], fs_tono_celular);
    [pxx_ruido_celular, f_ruido_celular] = pwelch(ruido_celular, [], [], [], fs_ruido_celular);

    % Obtener índices para el ancho de banda deseado
    idx_tono = (f_tono_laptop >= 20) & (f_tono_laptop <= 20000);
    idx_ruido = (f_ruido_laptop >= 20) & (f_ruido_laptop <= 20000);

    % Calcular la potencia promedio del tono y el ruido en el ancho de banda
    potencia_tono_laptop = trapz(f_tono_laptop(idx_tono), pxx_tono_laptop(idx_tono));
    potencia_ruido_laptop = trapz(f_ruido_laptop(idx_ruido), pxx_ruido_laptop(idx_ruido));

    potencia_tono_celular = trapz(f_tono_celular(idx_tono), pxx_tono_celular(idx_tono));
    potencia_ruido_celular = trapz(f_ruido_celular(idx_ruido), pxx_ruido_celular(idx_ruido));

    % Calcular el SNR en dB
    snr_db_laptop = 10 * log10(potencia_tono_laptop / potencia_ruido_laptop);
    snr_db_celular = 10 * log10(potencia_tono_celular / potencia_ruido_celular);

    % Mostrar los resultados en la consola
    fprintf('Potencia promedio del tono en el laptop: %.6f\n', potencia_tono_laptop);
    fprintf('Potencia promedio del ruido en el laptop: %.6f\n', potencia_ruido_laptop);
    fprintf('SNR en laptop: %.2f dB\n\n', snr_db_laptop);

    fprintf('Potencia promedio del tono en el laptop: %.6f\n', potencia_tono_celular);
    fprintf('Potencia promedio del ruido en el laptop: %.6f\n', potencia_ruido_celular);
    fprintf('SNR en laptop: %.2f dB\n', snr_db_celular);

    % Graficar la PSD del tono y el ruido en escala logarítmica y el ancho de banda deseado
    figure;
    semilogx(f_tono_laptop(idx_tono), 10*log10(pxx_tono_laptop(idx_tono)), 'b');
    hold on;
    semilogx(f_ruido_laptop(idx_ruido), 10*log10(pxx_ruido_laptop(idx_ruido)), 'r');
    hold off;
    title('Densidad Espectral de Potencia (PSD) - Tono y Ruido en laptop');
    xlabel('Frecuencia (Hz)');
    ylabel('PSD (dB/Hz)');
    legend('Tono', 'Ruido');
    grid on;

    figure;
    semilogx(f_tono_celular(idx_tono), 10*log10(pxx_tono_celular(idx_tono)), 'b');
    hold on;
    semilogx(f_ruido_celular(idx_ruido), 10*log10(pxx_ruido_celular(idx_ruido)), 'r');
    hold off;
    title('Densidad Espectral de Potencia (PSD) - Tono y Ruido en celular');
    xlabel('Frecuencia (Hz)');
    ylabel('PSD (dB/Hz)');
    legend('Tono', 'Ruido');
    grid on;

catch exception
    disp(['Error: ' exception.message]);
end



