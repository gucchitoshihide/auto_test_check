shared_examples_for 'a successfully response' do |page_name|
  its(:content_type)  { should eq Mime::HTML }
  its(:status)        { should eq 200 }
  let(:body)          { Nokogiri::HTML(subject.body) }
  it "has the #{page_name} page html in the body" do
    expect(body.title).to eq t("las.#{page_name}.title")
  end
end

shared_examples_for 'a no redirection response' do |original_page, suspect_page|
  its(:content_type)  { should eq Mime::HTML }
  its(:status)        { should eq 200 }
  let(:body)          { Nokogiri::HTML(subject.body) }
  it "has the #{original_page}, not a #{suspect_page}" do
    expect(body.title).to     eq t("las.#{original_page}.title")
    expect(body.title).not_to eq t("las.#{suspect_page}.title")
  end
end

shared_examples_for 'a successfully redirection response(302)' do |page_name|
  its(:content_type)  { should eq Mime::HTML }
  its(:status)        { should eq 302}
end

shared_examples_for 'a successfully rendered' do |action|
  its(:content_type)  { should eq Mime::HTML }
  its(:status)        { should eq 200 }
  let(:body)          { Nokogiri::HTML(subject.body) }
  it "rendered the #{page_name} template" do
    expect.to render_template(action)
  end
end

