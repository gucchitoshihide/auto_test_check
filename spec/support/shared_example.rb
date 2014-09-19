shared_examples_for 'a successful response' do |controller_action|
  before do
    @expected_action_name = controller_action.split('.').last
  end
  its(:content_type)  { should eq Mime::HTML }
  its(:status)        { should eq 200 }
  let(:body)          { Nokogiri::HTML(subject.body) }
  it "has the #{controller_action} page html in the body" do
    expect(body.title).to eq t("las.#{controller_action}.title")
  end
  it "rendered the #{@action} template" do
    expect(subject).to render_template(@expected_action_name)
  end
end

shared_examples_for 'a successful redirection to' do |expected_path|
  its(:content_type)  { should eq Mime::HTML }
  its(:status)        { should eq 302 }
  let(:body)          { Nokogiri::HTML(subject.body) }
  let(:path)          { body.at('a').attributes['href'].value.gsub(/#{Settings[:admin][:redirection][:regexp]}/, '') }
  it 'redirected to the "#{path}"' do
    expect(expected_path).to eq path
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

shared_examples_for 'a successful rendered' do |action|
  its(:content_type)  { should eq Mime::HTML }
  its(:status)        { should eq 200 }
  let(:body)          { Nokogiri::HTML(subject.body) }
  it "rendered the #{action} template" do
    expect(subject).to render_template(action)
  end
end

shared_examples_for 'a failure response status with' do |status|
  its(:content_type)  { should eq Mime::HTML }
  its(:status)        { should eq status }
end

shared_examples_for 'a prohibited request and return 401' do
  its(:content_type)  { should eq Mime::HTML }
  its(:status)        { should eq 401 }
end
