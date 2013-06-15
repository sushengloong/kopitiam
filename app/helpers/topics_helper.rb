module TopicsHelper
  # Stolen from http://stackoverflow.com/a/5909183
  def youtube_embed(youtube_url)
    if youtube_url[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end
    if youtube_id.blank?
      nil
    else
      %Q{<iframe id="preview-iframe" title="YouTube video player" width="640" height="390" src="http://www.youtube.com/embed/#{youtube_id}" frameborder="0" allowfullscreen></iframe>}.html_safe
    end
  end

  def preview_iframe link
    yt_embed = youtube_embed link
    yt_embed.present? ? yt_embed : %Q{<iframe id="preview-iframe" width="800" height="400" src="#{link}"></iframe>}.html_safe
  end
end
