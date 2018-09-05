defmodule Encrypt.Cli do
  @moduledoc """
  Documentation for Encrypt.Cli.
  """
  @doc """
  Will be called by the escript when you execute from the command line:
  ```
  > ~/.mix/encrypt --file path_to_file --action encrypt/decrypt --key secret_key
  ```
  Or
  ```
  > ~/.mix/encrypt --action generate_secret
  ```
  """
  def main(args \\ []) do
    args
    |> parse_args
    |> output_message
    |> handle_execution
    IO.puts IO.ANSI.green() <> "🧙 ‍done!" <> IO.ANSI.reset
  end


  def parse_args(args) do
    case OptionParser.parse(args, switches: [file: :string, action: :string, key: :string]) do
      {[file: file, action: action, key: key], [], []} -> [file: file, action: action, key: key]
      {[action: action], [], []} -> [action: action]
    end
  end

  def output_message([file: file, action: action, key: key]) do
    IO.puts IO.ANSI.green() <> "Starting to #{action}...✨" <> IO.ANSI.reset
    [file: file, action: action, key: key]
  end

  def output_message([action: action]) do
    IO.puts IO.ANSI.green() <> "Starting to #{action}...✨" <> IO.ANSI.reset
    [action: action]
  end

  def handle_execution([action: "generate_secret"]) do
    IO.puts IO.ANSI.blue() <> "🗝️ SECRET: 🗝️" <> IO.ANSI.blue
    IO.puts Encrypt.execute_action([action: "generate_secret"])
  end

  def handle_execution(args), do: Encrypt.execute_action(args)
end
