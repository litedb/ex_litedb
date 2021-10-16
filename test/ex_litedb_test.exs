defmodule ExLitedbTest do
  use ExUnit.Case
  doctest ExLitedb

  describe "path_for" do
    test "works" do
      ExLitedb.extensions() |> Enum.map(fn(ext)->
        assert ExLitedb.path_for(ext) |> IO.inspect()
      end)
    end
  end
end
