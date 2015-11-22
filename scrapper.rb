require 'mechanize'

class Scrapper
  HOST = 'https://www.service-client.veoliaeau.fr'

  def run
    @username = ENV['veo_usr']
    @password = ENV['veo_pwd']

    if @username.nil? || @password.nil?
      $stderr.puts "You need to give your username and password in ENV veo_usr and veo_pwd"
      exit 1
    end

    agent = Mechanize.new
    # home + login
    page = agent.get(HOST + '/home.html')
    form = page.forms.find { |f| f.name == 'loginBoxform_identification' }
    form.fields.find { |f| f.name == 'veolia_username' }.value = @username
    form.fields.find { |f| f.name == 'veolia_password' }.value = @password
    page = form.submit

    # after login@
    page = page.links.find { |l| l.href =~ /consommation/ }.click
    page = page.links.find { |l| l.href =~ /releves/ }.click
    form = page.forms.find { |f| f.name == 'formulaireConso_releve' }
    form.radiobuttons.find { |rb| rb.value == 'donnees' }.click
    page = form.submit

    # fetch data
    Hash[*page.search('.graphe td').map { |n| t = n.text; Date.strptime(t, '%d/%m/%Y ').to_s rescue { val: t.to_i, est: !!(n.attr('class') =~ /estimee/) }}].to_a.sort { |a,b| a[0] <=> b[0] }
  end

end
if File.identical?(__FILE__, $0)
  puts Scrapper.new.run.to_json
end
