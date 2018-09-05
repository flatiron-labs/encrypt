defmodule EncryptTest do
  use ExUnit.Case
  doctest Encrypt

  @key "ld9p1COMK3VogmdlfCVwKw=="
  @encrypted_fixture "./test/fixtures/top_secret_encrypted.txt"
  @plain_text_fixture "./test/fixtures/top_secret.txt"
  @base64_encoded "1vFGOGj+Mr7q1Y9r2cLTD21l+9koC8hHaYegKVSvfw6xm/ew5RSneSLgA8t8"

  describe "generate secret" do
    test "generates a secret key" do
      secret = :base64.decode(Encrypt.execute_action([action: "generate_secret"]))
      assert byte_size(secret) == 16
      assert is_binary(secret) == true
    end
  end

  describe "encrypt file" do
    setup do
      on_exit fn ->
        {:ok, file_pid } = File.open(@plain_text_fixture, [:write])
        IO.binwrite(file_pid, "Secret info.\n")
        File.close(file_pid)
      end
    end
    test "it encrypts and base64 encodes a file" do
      assert :ok == Encrypt.execute_action([file: @plain_text_fixture, action: "encrypt", key: @key])
      assert File.read!(@plain_text_fixture) != "Secret info."
    end
  end

  describe "decrypt file" do
    setup do
      on_exit fn ->
        {:ok, file_pid } = File.open(@encrypted_fixture, [:write])
        IO.binwrite(file_pid, @base64_encoded)
        File.close(file_pid)
      end
    end
    test "it decrypts and base64 encodes a file" do
      assert :ok == Encrypt.execute_action([file: @encrypted_fixture, action: "decrypt", key: @key])
      assert File.read!(@encrypted_fixture) == "Secret info.\n"
    end
  end
end
