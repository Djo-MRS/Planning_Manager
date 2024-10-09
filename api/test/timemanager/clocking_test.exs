defmodule Timemanager.ClockingTest do
  use Timemanager.DataCase

  alias Timemanager.Clocking

  describe "clocks" do
    alias Timemanager.Clocking.Clock

    import Timemanager.ClockingFixtures

    @invalid_attrs %{status: nil, user: nil, times: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Clocking.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Clocking.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, user: "some user", times: ~D[2024-10-07]}

      assert {:ok, %Clock{} = clock} = Clocking.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.user == "some user"
      assert clock.times == ~D[2024-10-07]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clocking.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, user: "some updated user", times: ~D[2024-10-08]}

      assert {:ok, %Clock{} = clock} = Clocking.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.user == "some updated user"
      assert clock.times == ~D[2024-10-08]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Clocking.update_clock(clock, @invalid_attrs)
      assert clock == Clocking.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Clocking.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Clocking.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Clocking.change_clock(clock)
    end
  end
end
