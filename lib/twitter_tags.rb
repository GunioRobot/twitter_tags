module TwitterTags
  include Radiant::Taggable

  desc "Creates an context for the twitter functionality" 
  tag "twitter" do |tag|
    # we need a user in the user attribute
    raise StandardError::new('the twitter-tag needs a username in the user attribute') if tag.attr['user'].blank?
    tag.expand
  end

  desc "Creates the loop for the tweets - takes count and order optionally"
  tag "twitter:tweets" do |tag|
    count = (tag.attr['count'] || 10).to_i # reminder: "foo".to_i => 0
    order = (tag.attr['order'] || 'desc').downcase
    
    raise StandardError::new('the count attribute should be a positive integer') unless count > 0
    raise StandardError::new('the order attribute should be "asc" or "desc"') unless %w{asc desc}.include?(order)

    # iterate over the tweets
    result = []
    count.times do |tweet|
      tag.locals.tweet = tweet
      result << tag.expand
    end
    
    result
  end
  
  desc "Creates the context within which the tweet can be examined"
  tag "twitter:tweets:tweet" do |tag|
    tag.expand
  end
end