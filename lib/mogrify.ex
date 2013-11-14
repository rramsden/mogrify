defmodule Mogrify do
  defrecord Image, path: nil

  @doc """
  Copy the original image for image modification

  ## Example

      iex> Mogrify.open("/path/to/image.png")
  """
  def open(path) do
    tmp_dir = System.tmp_dir
    [name, ext] = String.split(Path.basename(path), ".")

    tmp_file = Path.join(tmp_dir, "#{name}_#{random}.#{ext}")
    Image.new(path: tmp_file)
  end

  @doc """
  Use the working copy of the image for modification
  """
  def new(path) do
    Image.new(path: path)
  end

  @doc """
  Resizes a the image given at the path in the Image record

  ## Example

      iex> image = Mogrify.new("path/to/image.png")
      iex> image = Mogrify.resize(image, "50x50")
  """
  def resize(image, opts) when is_record(image, Image) do
    System.cmd "mogrify -resize #{opts} #{image.path}"
  end

  defp random(seed // :erlang.now) do
    :random.seed(seed)
    {number, _} = Integer.parse("#{:math.pow(2, 32-1)}")
    :random.uniform(number)
  end
end
