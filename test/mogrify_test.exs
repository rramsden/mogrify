defmodule MogrifyTest do
  use ExUnit.Case

  test "resizes an image" do
    source = Path.join(fixture_dir, "image.png")
    image = Mogrify.new(source)
    Mogrify.resize(image, "50x50")
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
