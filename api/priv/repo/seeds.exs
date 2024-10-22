alias Timemanager.Accounts
alias Timemanager.Repo

# Vérification et création des rôles
role_admin = Repo.get_by(Accounts.Role, name: "admin") ||
  case Accounts.create_role(%{name: "admin"}) do
    {:ok, role} -> role
    {:error, _changeset} -> IO.puts("Role admin already exists"); Repo.get_by!(Accounts.Role, name: "admin")
  end

role_manager = Repo.get_by(Accounts.Role, name: "manager") ||
  case Accounts.create_role(%{name: "manager"}) do
    {:ok, role} -> role
    {:error, _changeset} -> IO.puts("Role manager already exists"); Repo.get_by!(Accounts.Role, name: "manager")
  end

role_employee = Repo.get_by(Accounts.Role, name: "employee") ||
  case Accounts.create_role(%{name: "employee"}) do
    {:ok, role} -> role
    {:error, _changeset} -> IO.puts("Role employee already exists"); Repo.get_by!(Accounts.Role, name: "employee")
  end

# Création des utilisateurs avec leur rôle
Accounts.create_user(%{
  firstname: "Admin",
  lastname: "User",
  email: "admin@example.com",
  password: "adminpassword",
  role_id: role_admin.id
})

Accounts.create_user(%{
  firstname: "Manager",
  lastname: "User",
  email: "manager@example.com",
  password: "managerpassword",
  role_id: role_manager.id
})

Accounts.create_user(%{
  firstname: "Employee",
  lastname: "User",
  email: "employee@example.com",
  password: "employeepassword",
  role_id: role_employee.id
})
