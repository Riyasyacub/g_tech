module ApplicationHelper

  def flash_style(type)
    color = {
      success: "green",
      error:   "red",
      info:    "blue",
      warning: "yellow",
      alert:   "red",
      notice:  "green"
    }[type.to_sym] || "blue"

    "text-#{color}-800 border-t-4 border-#{color}-300 bg-#{color}-50 dark:text-#{color}-400 dark:bg-gray-800 dark:border-#{color}-800"
  end

end
