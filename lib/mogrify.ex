defmodule Mogrify do
  defrecord Image, path: nil, ext: nil

  @doc """
  Copy the original image for image modification

  ## Example

      iex> Mogrify.open("/path/to/image.png")
  """
  def open(path, ext // nil) do
    tmp_dir = System.tmp_dir
    ext = if ext == nil, do: parse_ext(path), else: ext
    name = Path.basename(path) |> String.replace(%r/\..+$/, "")

    tmp_file = Path.join(tmp_dir, "#{name}-#{random}")
    :ok = File.cp path, tmp_file

    Image.new(path: tmp_file, ext: ext)
  end

  @doc """
  Use the working copy of the image for modification
  """
  def new(path, ext // nil) do
    ext = if ext == nil, do: parse_ext(path), else: ext
    Image.new(path: path, ext: ext)
  end

  @doc """
  Resizes a the image given at the path in the Image record

  ## Example

      iex> image = Mogrify.new("path/to/image.png")
      iex> image = Mogrify.resize(image, "50x50")
  """
  def resize(image, opts) when is_record(image, Image) do
    System.cmd "mogrify -resize #{opts} #{image.path}"
    image
  end

  defp random(seed // :erlang.now) do
    :random.seed(seed)
    {number, _} = Integer.parse("#{:math.pow(2, 32-1)}")
    :random.uniform(number)
  end

  defp parse_ext(path) do
    [_, ext] = (Path.basename(path) |> String.split("."))
    ext
  end
end
