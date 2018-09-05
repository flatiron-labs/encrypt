defmodule Encrypt do
  @moduledoc """
  Documentation for Encrypt.
  """
  @aad "AES256GCM"

  def execute_action([action: "generate_secret"]) do
    :crypto.strong_rand_bytes(16)
    |> :base64.encode
  end

  def execute_action([file: file, action: action, key: key]) do
    file_contents = File.read!(file)
    apply(__MODULE__,String.to_atom(action), [file_contents, key])
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


  def encrypt(val, key) do
    iv = :crypto.strong_rand_bytes(16)
    {ciphertext, tag} =
      :crypto.block_encrypt(:aes_gcm, decode_key(key), iv, {@aad, to_string(val), 16})
    iv <> tag <> ciphertext
  end

  def decrypt(ciphertext, key) do
    ciphertext = :base64.decode(ciphertext)
    <<iv::binary-16, tag::binary-16, ciphertext::binary>> = ciphertext
    :crypto.block_decrypt(:aes_gcm, decode_key(key), iv, {@aad, ciphertext, tag})
  end

  def decode_key(key) do
    :base64.decode(key)
  end
end
