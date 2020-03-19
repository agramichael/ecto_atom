defmodule Ecto.Atom do
  @moduledoc """
  Custom Ecto type used to store atoms.
  """

  @behaviour Ecto.Type

  #
  # BEHAVIOUR
  #

  def type, do: :string

  def cast(value) when is_binary(value) or is_atom(value) do
    {:ok, atomize(value)}
  end

  def cast(_), do: :error

  def load(string) when is_binary(string) do
    {:ok, atomize(string)}
  end

  def dump(atom) when is_atom(atom) do
    {:ok, stringify(atom)}
  end

  def dump(_), do: :error

  def embed_as(_) do
    :self
  end

  def equal?(atom1, atom2) do
    atom1 == atom2
  end

  #
  # PRIVATE
  #

  defp atomize(nil), do: nil
  defp atomize(string) when is_binary(string), do: String.to_atom(string)
  defp atomize(atom) when is_atom(atom), do: atom

  defp stringify(nil), do: nil
  defp stringify(string) when is_binary(string), do: string
  defp stringify(atom) when is_atom(atom), do: Atom.to_string(atom)
end
