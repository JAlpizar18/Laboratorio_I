import numpy as np
import sounddevice as sd
import matplotlib.pyplot as plt
import soundfile as sf

def generate_sweep(start_freq, end_freq, duration, sample_rate):
    t = np.linspace(0, duration, int(sample_rate * duration), endpoint=False)
    freqs = np.linspace(start_freq, end_freq, len(t))
    signal = np.sin(2 * np.pi * freqs * t)
    return signal, t

def play_audio(audio_signal, sample_rate):
    sd.play(audio_signal, samplerate=sample_rate)
    sd.wait()

if __name__ == "__main__":
    start_freq = 50  # Hz
    end_freq = 5000  # Hz (5 kHz)
    duration = 10  # seconds
    sample_rate = 200000  # Hz (standard audio sample rate)

    audio_signal, t = generate_sweep(start_freq, end_freq, duration, sample_rate)

    # Gráfico de la forma de onda
    plt.figure(figsize=(10, 4))
    plt.plot(t, audio_signal, label='Barrido de frecuencia')
    plt.xlabel('Tiempo (s)')
    plt.ylabel('Amplitud')
    plt.title('Barrido de frecuencia desde 50 Hz hasta 5 kHz')
    plt.grid(True)
    plt.legend()
    plt.show()

    play_audio(audio_signal, sample_rate)
    output_file = "sonido_de_barrido.wav"
    sf.write(output_file, audio_signal, sample_rate)
    print(f"Sound saved to {output_file}")
