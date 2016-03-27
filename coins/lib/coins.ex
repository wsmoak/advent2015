defmodule Coins do

  def mine5(secret) do
    mine5(secret,0)
  end

  def mine5(secret,val) do
    mine5(secret, val, hex_hash(secret,val))
  end

  def mine5(_secret,val,"00000" <> _rest) do
    val
  end

  def mine5(secret,val,_hash) do
    mine5(secret,val+1)
  end

  def mine6(secret) do
    mine6(secret,0)
  end

  def mine6(secret,val) do
    mine6(secret, val, hex_hash(secret,val))
  end

  def mine6(_secret,val,"000000"<>_rest) do
    val
  end

  def mine6(secret,val,_hash) do
    mine6(secret,val+1)
  end

  def hex_hash(secret,val) do
    secret <> to_string(val)
    |> :erlang.md5
    |> Base.encode16
  end

end
