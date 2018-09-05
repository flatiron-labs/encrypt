defmodule Encrypt do
  @moduledoc """
  Documentation for Encrypt.
  """
  @aad "AES256GCM"
  @encryption_key System.get_env("ENCRYPTION_SECRET")

  def execute_action([action: "generate_secret"]) do
    :crypto.strong_rand_bytes(16)
    |> :base64.encode
  end

  def execute_action([file: file, action: action]) do
    file_contents = File.read!(file)
    apply(__MODULE__,String.to_atom(action), [file_contents])
    |> write_to_file(file, action)
  end


  def write_to_file(contents, file, "encrypt") do
    {:ok, file_pid } = File.open(file, [:write])
    IO.binwrite(file_pid, :base64.encode(contents))
    File.close(file_pid)
  end

  def write_to_file(contents, file, "decrypt") do
    {:ok, file_pid } = File.open(file, [:write])
    IO.binwrite(file_pid, contents)
    File.close(file_pid)
  end


  def encrypt(val) do
    iv = :crypto.strong_rand_bytes(16)
    {ciphertext, tag} =
      :crypto.block_encrypt(:aes_gcm, get_key(), iv, {@aad, to_string(val), 16})
    iv <> tag <> ciphertext
  end

  def decrypt(ciphertext) do
    ciphertext = :base64.decode(ciphertext)
    <<iv::binary-16, tag::binary-16, ciphertext::binary>> = ciphertext
    :crypto.block_decrypt(:aes_gcm, get_key(), iv, {@aad, ciphertext, tag})
  end

  def get_key do
    IO.puts "KEY"
    IO.puts @encryption_key
    :base64.decode(@encryption_key)
  end
end
