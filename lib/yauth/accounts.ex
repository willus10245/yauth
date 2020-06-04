defmodule Yauth.Accounts do
  @auth_server Application.get_env(:yauth, :auth_server)
  @accounts_module Application.get_env(:yauth, :accounts_module)
  @auth_task_supervisor Application.get_env(:yauth, :auth_task_supervisor)

  def get_or_register(%Ueberauth.Auth{} = params) do
    spawn_task(:get_or_register, [params])
  end

  def register(%Ueberauth.Auth{provider: :identity} = params) do
    spawn_task(:register, [params])
  end

  def register(%Ueberauth.Auth{} = params) do
    spawn_task(:register, [params])
  end

  def get_account(id) do
    spawn_task(:get_account, [id])
  end

  def get_by_email(email) do
    spawn_task(:get_by_email, [email])
  end

  def change_account() do
    spawn_task(:change_account, [])
  end

  defp spawn_task(fun, args) do
    @auth_server
    |> remote_supervisor()
    |> Task.Supervisor.async(@accounts_module, fun, args)
    |> Task.await()
  end

  defp remote_supervisor(recipient) do
    {@auth_task_supervisor, recipient}
  end
end
