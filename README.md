# Mogrify

This is a wrapper for ImageMagick's mogify utility

## Usage

Modify an image in-place for faster performance

    iex> image = Mogrify.new("path/to/image.png")
    iex> image = Mogrify.resize(image, "50x50")
    iex> IO.puts image.path

You can also create a copy of the image if you don't want to overwrite
the original by opening file using `Mogrify.open/1`

    iex> image = Mogrify.open("path/to/image.png")
    iex> image = Mogrify.resize(image, "50x50")
    iex> IO.puts image.path
