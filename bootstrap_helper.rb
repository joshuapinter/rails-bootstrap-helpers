# Creats an icon wrapper based on Bootstrap.
#
# @param [String] name Icon name from Bootstrap's Glyphicons. Automatically prefixes the name
#   with 'icon-' if not done already.
# @param [Hash] options 
#
# @option options [Boolean] white (false) Set to false if you want to use the black icon.
#
# @return [HTML]
#
# @see http://twitter.github.com/bootstrap/base-css.html#icons Bootstrap Icons
#
def icon_tag name, options = {}
  options.reverse_merge!( white: false )
  
  name.insert( 0, 'icon-' ) unless name.starts_with?( 'icon-' )  # Add prefix for bootstrap.
  
  klass = [name]
  klass << 'icon-white' if options[:white]
  
  content_tag :i, nil, class: klass.join( ' ' )
end

# Creates a tooltip alla Twitter Bootstrap.
#
# @param [String] anchor Anchor that people will hover over.
# @param [String] tip Tooltip text to show when people hover over the `text`.
# @param [String] link Optionally pass in a link for when people click on the anchor text. We use
#   this in Emission Central where we tell them that a feature is PRO feature and then clicking
#   on the link creates an email to our support account.
#
# @return [HTML] link_to formatted correctly.
#
# @example Tooltip for an image.
#   tooltip image_tag( 'lock_icon.png', size: '10x14', class: 'lock' ), t('folder.private')
#
def tooltip anchor, tip, link = '#'
  link_to anchor, link, "data-original-title" => tip, rel: 'tooltip'
end

# Creates a tooltip alla Twitter Bootstrap but instead of creating a link, it uses an image.
#
# @param [String] source Image location. Same as image_tag source.
# @param [Hash] options 
#
# @option [String] tip ('') Tip to be displayed on hover.
#
# @see #tooltip
# @see #image_tag
#
def image_tag_with_tooltip source, options = {}
  options.reverse_merge!( tip: '' )
  options.merge_nicely!( rel: 'tooltip', "data-original-title" => options.delete(:tip) )
  
  image_tag source, options
end


# Generates an alert alla Bootstrap.
#
# @param [String, HTML] msg Alert message to display.
# @param [String, Symbol, Array<String,Symbol>] classes Extra alert classes to apply. Classes will
#   automatically be prefixed with 'alert-' so no need to put that in there.
#
# @return [HTML]
#
# @see http://twitter.github.com/bootstrap/components.html#alerts Bootstrap Alerts
# 
def alert msg, classes = nil
  # Prefix classes with 'alert-' and format to string.
  classes = Array( classes ).collect{ |c| "alert-#{c}" }.join(' ')
  
  content_tag( :div, { :class => "alert #{classes}" } ) do
    link_to( 'x', '#', { 'class' => 'close' } ) +
    raw( msg )
  end
end