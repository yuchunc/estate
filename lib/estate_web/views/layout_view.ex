defmodule EstateWeb.LayoutView do
  use EstateWeb, :view

  def sidenav_item_color(controller_name, controller_name) do
    "group flex items-center px-2 py-2 text-base leading-6 font-medium rounded-md text-white bg-teal-700 focus:outline-none focus:bg-teal-500 transition ease-in-out duration-150"
  end

  def sidenav_item_color(_, _) do
    "group flex items-center px-2 py-2 text-base leading-6 font-medium rounded-md text-teal-100 hover:text-white hover:bg-teal-500 focus:outline-none focus:bg-teal-500 transition ease-in-out duration-150"
  end
end
