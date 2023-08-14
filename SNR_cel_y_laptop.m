% Nombres de los archivos WAV
archivo_tono_laptop = 'tono_1khz_desde_laptop.wav';
archivo_ruido_laptop = 'ruido_ambiente_laptop.wav';


archivo_tono_celular = 'tono_1khz_desde_celular.wav';
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

    % Convertir potencias a dB
    potencia_tono_laptop_db = 10 * log10(potencia_tono_laptop);
    potencia_ruido_laptop_db = 10 * log10(potencia_ruido_laptop);
    potencia_tono_celular_db = 10 * log10(potencia_tono_celular);
    potencia_ruido_celular_db = 10 * log10(potencia_ruido_celular);

    % Calcular el SNR en dB
    snr_db_laptop = 10 * log10(potencia_tono_laptop / potencia_ruido_laptop);
    snr_db_celular = 10 * log10(potencia_tono_celular / potencia_ruido_celular);

    % Mostrar los resultados en la consola
    fprintf('Potencia del tono en el laptop: %.6f dB\n', potencia_tono_laptop_db);
    fprintf('Potencia del ruido en el laptop: %.6f dB\n', potencia_ruido_laptop_db);
    fprintf('SNR en laptop: %.2f dB\n\n', snr_db_laptop);

    fprintf('Potencia del tono en el celular: %.6f dB\n', potencia_tono_celular_db);
    fprintf('Potencia del ruido en el celular: %.6f dB\n', potencia_ruido_celular_db);
    fprintf('SNR en celular: %.2f dB\n', snr_db_celular);

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
    
    % Crear gráfico de barras para potencia del tono y potencia de ruido en laptop y celular
    figure;
    bar([potencia_tono_laptop_db, potencia_ruido_laptop_db; ...
         potencia_tono_celular_db, potencia_ruido_celular_db])
    title('Potencia del Tono y Potencia de Ruido en Laptop y Celular');
    xlabel('Tipo de Potencia');
    ylabel('Potencia (dB)');
    xticks([1 2 4 6]);
    xticklabels({'Con laptop', 'Con celular'});
    legend('Tono', 'Ruido');
    grid on;

catch exception
    disp(['Error: ' exception.message]);
end



