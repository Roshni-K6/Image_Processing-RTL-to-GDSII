from PIL import Image

img = Image.open("input.jpeg")
img = img.resize((64, 64))   
img = img.convert("RGB")

pixels = list(img.getdata())

with open("in.hex", "w") as f:
    for (r, g, b) in pixels:
        value = (r << 16) | (g << 8) | b
        f.write(f"{value:06x}\n")

print("HEX file generated!")
