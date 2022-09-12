#deviseによるエラーメッセージをbootstrapに対応させるヘルパー

module DeviseHelper
    def bootstrap_alert(key)
      case key
      when "warning"
        "warning"
      when "success"
        "success"
      when "danger"
        "danger"

      when "alert"
        "warning"
      when "notice"
        "success"
      when "error"
        "danger"
      end
    end

    def toast_alert(key)
      case key
      when "warning"
        "warning"
      when "success"
        "success"
      when "danger"
        "error"

      when "alert"
        "warning"
      when "notice"
        "success"
      when "error"
        "error"
      end
    end
  end