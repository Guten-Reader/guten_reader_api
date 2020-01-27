class UserSettingSerializer
  def initialize(user)
    @id = user.id
    @username = user.username
    @music_genre = user.music_genre
    @dyslexic_font = user.dyslexic_font
    @dark_mode = user.dark_mode
    @font_size = user.font_size
  end
end
