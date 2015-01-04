# coding: UTF-8

Plugin.create(:mikutter_command_style) {
  settings("スタイル") {
    5.times { |i|
      settings("スタイル#{i + 1}") {
        fontcolor("フォント", "style_font_face#{i + 1}".to_sym, "style_font_color#{i + 1}".to_sym)
        color("背景色", "style_background_color#{i + 1}".to_sym)
      }
    }
  }


  5.times { |i|
    command("apply_style#{i + 1}".to_sym,
            :name => _("スタイル#{i + 1}を適用"),
            :condition => lambda { |opt| Plugin::Command[:HasMessage] },
            :visible => false,
            :role => :timeline) { |opt|
      opt.messages.each { |message|
        message[:style] = i + 1 
      }
    }
  }


  filter_message_background_color { |message, color|
    num = message.message[:style]    

    if num && UserConfig["style_background_color#{num}".to_sym] && !message.selected
      color = UserConfig["style_background_color#{num}".to_sym]
    end

    [message, color]
  }

  filter_message_font_color { |message, color|
    num = message.message[:style]    

    if num && UserConfig["style_font_color#{num}".to_sym]
      color = UserConfig["style_font_color#{num}".to_sym]
    end

    [message, color]
  }

  filter_message_font { |message, font|
    num = message.message[:style]    

    if num && UserConfig["style_font_face#{num}".to_sym]
      font = UserConfig["style_font_face#{num}".to_sym]
    end

    [message, font]
  }
}
