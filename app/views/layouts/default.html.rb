class Layouts::Default < Minimal::Template
  def to_html
    self << doctype
    html do
      content_tag(:head) { head }
      content_tag :body do
        div :id => 'page' do
          div :id => 'header' do
            h1 do
              a 'Globalize<span>for Ruby on Rails</span>'.html_safe, :href => '/'
            end
                
            # ul :id => 'menu' do
            #   #<!--li><a href="/recent_activity">Recent</a></li-->
            #   #<!--li><a href="/authors">Authors</a></li-->
            #   #<!--li><a href="/home.atom">Atom Feed</a></li-->
            # end

            h2 "Webapplication Internationalization that doesn't hurt"
            #<!--p>Globalize is a Ruby on Rails plugin designed to support multilingual applications. It’s under the MIT License, same as Ruby on Rails.</p-->
            ul :id => 'main-nav' do
              li do
                h3 do
                  a 'What is Globalize?', :href => '/'
                end
                a 'News', :href => "#news"
                a 'Overview for busy people', :href => "#overview"
                a 'Screencast', :href => "#screencast"
              end
              li do
                h3 do
                  a 'Features', :href => "/pages/features"
                end
                a 'Overview', :href => "/pages/features#overview"
                a 'Comparsion to others', :href => "/pages/features#comparsion"
              end
              li do 
                h3 do
                  a 'Get started', :href => "/pages/getting-started"
                end
                a 'Download & install', :href => "/pages/getting-started#install"
                a 'Walkthroughs', :href => "/pages/getting-started#walkthroughs"
              end
              li do 
                h3 do
                  a 'Documentation', :href => "/pages/documentation"
                end
                a 'FAQ', :href => "/pages/frequently-asked-questions"
                a 'API', :href => "/pages/documentation#api"
                a 'Howtos', :href => "/pages/documentation#howtos"
                a 'Overviews', :href => "/pages/documentation#overviews"
                a 'Recipes', :href => "/pages/documentation#recipes"
              end
              li do
                h3 do
                  a 'Community', :href => "/pages/community"
                end
                a 'Mailinglist', :href => "/pages/community#mailinglist"
                a 'Issue tracker', :href => "/pages/community#issues"
                a 'Team & Acknowledgements', :href => "/pages/community#team"
              end
            end
            # h2 site.subtitle
            # self << Menus::Sections.new.build(self).root.render(:id => 'sections')
            # yield :header
          end
        #  div :id => 'page' do
          div :id => 'content' do
            yield
          end
            # yield(:footer) || render(:partial => 'shared/footer')
        #  end
        # yield :foot
        end
      end
    end
  end

  def head
    self << tag(:meta, :'http-equiv' => 'Content-Type', :content => 'text/html; charset=utf-8')
    self << tag(:meta, :'generator' => 'adva-cms2')
    # self << meta_tags(@article) if @article
    self << title
    self << stylesheets
    #self << javascripts
    # self << authorize_elements
    # self << block.call :head
  end

  def doctype
    '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'.html_safe
  end

  def title
    super(site.title)
  end

  def stylesheets
    stylesheet_link_tag "globalize"
  end

  def javascripts
    javascript_include_tag :common, :default
  end
  
  def body_class
    resource.class.name.singularize.underscore if resource
  end
  
  def content
    block.call
  end

  def sidebar
    block.call :sidebar
  end
end
