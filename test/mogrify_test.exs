defmodule MogrifyTest do
  use ExUnit.Case

  test "resizes an image" do
    source = Path.join(fixture_dir, "image.png")
    image = Mogrify.new(source)
    image = Mogrify.resize(image, "50x50")

    assert is_record(image, Mogrify.Image)
  end

  test "parses extension" do
    source = Path.join(fixture_dir, "image.png")
    image = Mogrify.new(source)
    assert image.ext == "png"
  end

  test "allows passing of extension" do
    source = Path.join(fixture_dir, "image.png")
    image = Mogrify.new(source, "jpg")
    assert image.ext == "jpg"
  end

  test "copies image when using open/1" do
    source = Path.join(fixture_dir, "image.png")
    image = Mogrify.open(source)

    assert image.path != source
  end

  defp fixture_dir do
    Path.dirname(__FILE__) |> Path.join("fixtures")
  end
end
