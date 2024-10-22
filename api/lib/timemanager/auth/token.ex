defmodule Timemanager.Auth.Token do
  use Joken.Config

  @secret_key (System.get_env("JWT_SECRET") || "batman")

  def generate_cxsrf_token do
    :crypto.strong_rand_bytes(50) |> Base.encode64()
  end

  def generate_jwt(user) do
    c_xsrf_token = generate_cxsrf_token()

    claims = %{
      "c-xsrf-token" => c_xsrf_token,
      "user_id" => user.id,
      "user_role" => user.role,
      "exp" => Joken.current_time() + (30 * 24 * 60 * 60)
    }

    signer = Joken.Signer.create("HS256", @secret_key)


    {:ok, token, _claims} = Joken.encode_and_sign(claims, signer)

    {token, c_xsrf_token}
  end

  def verify_n_validate(jwt) do
    signer = Joken.Signer.create("HS256", @secret_key)
    Joken.verify_and_validate(%{}, jwt, signer)
  end
end
