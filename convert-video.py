import tkinter as tk
from tkinter import filedialog
import subprocess, os, shutil, sys

root = tk.Tk()
root.withdraw()

if not shutil.which("ffmpeg"):
    print("FFmpeg is not installed.")
    sys.exit(1)

video = filedialog.askopenfilename(title="Alege videoclipul", filetypes=[("Videoclipuri", "*.mp4 *.avi *.mkv *.mov"), ("Toate fisierele", "*.*")])

if not video:
    sys.exit(0)

output = os.path.join(os.path.dirname(video), "video.rgb565")
print("Se converteste...")
print("Din:", video)
print("In:", output)

subprocess.run(["ffmpeg", "-y", "-i", video, "-vf", "scale=320:240,fps=30", "-pix_fmt", "rgb565le", "-f", "rawvideo", output], check=True)
print("GATA! video.rgb565 a fost creat.")
