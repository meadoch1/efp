defmodule Ex1 do
  def main(args) do
    args
    |> parse_args
    |> process
  end

  def process([ex: 1]) do
    IO.puts "What is your name?"
    name = IO.read(:line) |> String.rstrip
    IO.puts "Hello, #{name}, nice to meet you!"
  end

  def process([ex: 2]) do
    IO.puts "What is your name?"
    IO.puts "Hello, #{IO.read(:line) |> String.rstrip }, nice to meet you!"
  end

  def process([ex: 3]) do
    IO.puts "What is your name?"
    name = IO.read(:line) |> String.rstrip
    IO.puts "Hello, #{name}, #{ greetings(name) }!"
  end

  def process([ex: n]) do
    IO.puts "Got #{n}"
  end

  def process([]) do
    IO.puts "Please supply an argument for what step to run."
  end

  def greetings(name) do
    %{ :Chris => "good to see you again", :Joe => "you're the man"}[String.to_atom name] || "nice to meet you"
  end

  def parse_args(args) do
    {options, _, _} = OptionParser.parse(args, switches: [ex: :integer])
    options
  end

end
