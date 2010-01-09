atom_feed do |feed|
  feed.title("Limi's Sphere of Influence - #{current_object.name} Feed")
  feed.updated(current_objects.first.created_at)

  current_objects.each do |post|
    feed.entry(post) do |entry|
      entry.title(post.title)
      entry.content(post.content, :type => 'html')
      entry.author { |author| author.name("Limi") }
    end
  end
end