import numpy as np
import soundfile as sf
import matplotlib.pyplot as plt
import sounddevice as sd

# Parámetros del tono
frecuencia = 1000  # 1 kHz
duracion = 10  # segundos
amplitud = 0.5  # entre 0 y 1

# Generar el tiempo para la señal
tiempo = np.linspace(0, duracion, int(duracion * 44100), False)

# Generar el tono
tono = amplitud * np.sin(2 * np.pi * frecuencia * tiempo)

# Guardar el tono en formato FLAC
nombre_archivo = "tono_1khz.flac"
sf.write(nombre_archivo, tono, 44100)

print(f"Tono guardado como '{nombre_archivo}'")

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
sd.play(tono, 44100)
sd.wait()
print("Reproducción completa")