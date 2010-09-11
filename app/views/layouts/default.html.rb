class Layouts::Default < Minimal::Template
  def to_html
    self << doctype
    html do
      content_tag(:head) { head }
      content_tag :body do
        div :id => 'page' do
          div :id => 'header' do
            h1 do
              a 'Globalize<span>for Ruby on Rails</span>', :href => '/'
            end
                
            ul :id => 'menu' do
              li :class => "first" do
                a 'All Pages', :href => "/wikipages"
              end
              #<!--li><a href="/recent_activity">Recent</a></li-->
              #<!--li><a href="/authors">Authors</a></li-->
              #<!--li><a href="/home.atom">Atom Feed</a></li-->
              li do
                a 'Admin', :href => "/admin"
              end
              li do
                a 'Login', :href => "/login"
              end
            end

            h2 "Webapplication Internationalization that doesn't hurt"
            #<!--p>Globalize is a Ruby on Rails plugin designed to support multilingual applications. It’s under the MIT License, same as Ruby on Rails.</p-->
            ul :id => 'main-nav' do
              li '<h3><a href="/">What is Globalize?</a></h3>' do
                a 'News', :href => "#news"
                a 'Overview for busy people', :href => "#overview"
                a 'Screencast', :href => "#screencast"
              end
              li '<h3><a href="/wikipages/features">Features</a></h3>' do
                a 'Overview', :href => "/wikipages/features#overview"
                a 'Comparsion to others', :href => "/wikipages/features#comparsion"
              end
              li '<h3><a href="/wikipages/getting-started">Get started</a></h3>' do
                a 'Download & install', :href => "/wikipages/getting-started#install"
                a 'Walkthroughs', :href => "/wikipages/getting-started#walkthroughs"
              end
              li '<h3><a href="/wikipages/documentation">Documentation</a></h3>' do
                a 'FAQ', :href => "/wikipages/frequently-asked-questions"
                a 'API', :href => "/wikipages/documentation#api"
                a 'Howtos', :href => "/wikipages/documentation#howtos"
                a 'Overviews', :href => "/wikipages/documentation#overviews"
                a 'Recipes', :href => "/wikipages/documentation#recipes"
              end
              li '<h3><a href="/wikipages/community">Community</a></h3>' do
                a 'Mailinglist', :href => "/wikipages/community#mailinglist"
                a 'Issue tracker', :href => "/wikipages/community#issues"
                a 'Team &amp; Acknowledgements', :href => "/wikipages/community#team"
              end
            end
            # h2 current_site.subtitle
            login_links
            section_links
            # self << Menus::Sections.new.build(self).root.render(:id => 'sections')
            # yield :header
          end
        #  div :id => 'page' do
          div :id => 'content' do
#= render :partial => 'shared/flash'
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
    super(current_site.title)
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
  
  def login_links
    p :id => 'login_links', :class => 'navigation' do
      link_to :'.sign_in', new_user_session_path(:return_to => request.fullpath), :id => 'login_link'
      link_to :'.sign_up', new_user_registration_path, :id => 'signup_link'
    end
    p :id => 'logout_links', :class => 'navigation', :style => 'display: none;' do
      self << t(:'.logged_in_as', :user => '<span class="user_name"></span>')
      link_to :'.sign_out', destroy_user_session_path(:return_to => request.fullpath), :id => 'logout_link'
    end
  end
  
  def section_links
    ul :id => 'sections' do
      current_site.sections.each do |section|
        li link_to(section.title, section)
      end
    end
  end
  
  def content
    block.call
  end

  def sidebar
    block.call :sidebar
  end
end
