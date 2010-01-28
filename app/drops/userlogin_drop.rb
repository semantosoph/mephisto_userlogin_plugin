class UserloginDrop < BaseDrop
  include Mephisto::Liquid::UrlMethods
  
  liquid_attributes << :login
  
  def initialize(source)
    super source
  end
  
  def pages
    @pages ||= @source.sites.split(',').map{|s| s.strip}
  end
end
