defmodule EncryptTest do
  use ExUnit.Case
  doctest Encrypt
  @key Encrypt.execute_action([action: "generate_secret"])
  @fixture "./test/fixtures/top_secret.txt"
  describe "generate secret" do
    test "generates a secret key" do
      secret = :base64.decode(@key)
      assert byte_size(secret) == 16
      assert is_binary(secret) == true
    end
  end

  describe "encrypt file" do
    test "it encrypts and base64 encodes a file" do
      assert :ok == Encrypt.execute_action([file: @fixture, action: "encrypt", key: @key])
      assert File.read!("./test/fixtures/top_secret.txt") != "Secret info."
    end
  end

  describe "decrypt file" do
    test "it decrypts and base64 encodes a file" do
      assert :ok == Encrypt.execute_action([file: @fixture, action: "decrypt", key: @key])
      assert File.read!("./test/fixtures/top_secret.txt") == "Secret info.\n"
    end
  end
end
