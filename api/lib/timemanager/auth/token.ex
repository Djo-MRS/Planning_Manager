# lib/auth/token.ex

defmodule TimeManager.Auth.Token do
  use Joken.Config

   # Récupérer la clé secrète depuis les variables d'environnement
  @secret_key System.get_env("JWT_SECRET") || "batman"

  # Fonction pour générer un c-xsrf-token
  def generate_cxsrf_token do
    :crypto.strong_rand_bytes(50) |> Base.encode64()
  end

  # Fonction pour générer le JWT
  def generate_jwt(user) do
    c_xsrf_token = generate_cxsrf_token()

    # Création du JWT avec les données requises
    {token, _claims} =
      %{}
      |> Joken.Config.create_token()
      |> Joken.with_signer(Joken.hs256(@secret_key)) #modifier pour mettre une clé en variable d'env !!!
      |> Joken.with_claim("c-xsrf-token", c_xsrf_token)
      |> Joken.with_claim("user_id", user.id)
      |> Joken.with_claim("user_role", user.role)
      |> Joken.with_exp(30 * 24 * 60 * 60) # 30 jours en secondes
      |> Joken.sign()

    {token, c_xsrf_token}
  end

   # Fonction pour vérifier et valider le JWT
   def verify_n_validate(jwt) do
    Joken.verify_and_validate(jwt, @secret_key)
  end

end
