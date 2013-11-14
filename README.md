# Mogrify

This is a wrapper for ImageMagick's mogify utility

## Usage

  iex> image = Mogrify.new("path/to/image.png")
  iex> image = Mogrify.resize(image, "50x50")
  iex> IO.puts image.path
