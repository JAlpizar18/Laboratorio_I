import numpy as np
import soundfile as sf
import matplotlib.pyplot as plt
import sounddevice as sd

# Parámetros del tono
frecuencia = 1000  # 1 kHz
duracion = 10  # segundos
amplitud = 0.5  # entre 0 y 1

# Generar el tiempo para la señal
tiempo = np.linspace(0, duracion, int(duracion * 200000), False)

# Generar el tono
tono = amplitud * np.sin(2 * np.pi * frecuencia * tiempo)

# Guardar el tono en formato WAV
nombre_archivo_wav = "tono_1khz.wav"
sf.write(nombre_archivo_wav, tono, 200000)

print(f"Tono guardado como '{nombre_archivo_wav}'")

# Mostrar la gráfica del tono
plt.figure()
plt.plot(tiempo, tono)
plt.title('Tono de 1 kHz')
plt.xlabel('Tiempo (s)')
plt.ylabel('Amplitud')
plt.grid(True)
plt.show()

# Reproducir el tono
print("Reproduciendo el tono...")
sd.play(tono, 200000)
sd.wait()
print("Reproducción completa")