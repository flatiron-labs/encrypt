defmodule EncryptTest do
  use ExUnit.Case
  doctest Encrypt

  test "greets the world" do
    assert Encrypt.hello() == :world
  end
end
