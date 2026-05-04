from PIL import Image

width = 64
height = 64

with open("out.hex") as f:
    data = [int(line.strip(), 16) for line in f]

img = Image.new("L", (width, height))
img.putdata(data)
img.save("output.jpg")

print("Output image generated!")
