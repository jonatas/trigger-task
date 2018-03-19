RSpec.describe Trigger::Task do

  let(:template) { <<~TEMPLATE }
    invite %s to slack at one day before today
    add %s to our team at today
    pair programming with %s at next day
  TEMPLATE

  it 'has a version number' do
    expect(Trigger::Task::VERSION).not_to be nil
  end

  describe '.parse' do
    subject do
      Trigger::Task.parse template
    end

    specify do
      is_expected.to eq(
        'invite %s to slack' => Chronic.parse('one day before today'),
        'add %s to our team' => Chronic.parse('today'),
        'pair programming with %s' => Chronic.parse('next day')
      )
    end
  end

  describe '.slack_reminders_for' do
    subject do
      Trigger::Task.slack_reminders_for('@someone',
        'invite %s to slack'=> Time.mktime(2018,01,15)
      )
    end

    specify do
      is_expected.to eq ['/remind me to invite @someone to slack on 01/15/2018']
    end
  end

  describe '.load_reminders' do
    subject do
      Trigger::Task.load_reminders('@user', template, now: Time.mktime(2018,1,16))
    end

    specify do
      is_expected.to eq([
        '/remind me to invite @user to slack on 01/15/2018',
        '/remind me to add @user to our team on 01/16/2018',
        '/remind me to pair programming with @user on 01/17/2018'
      ])
    end
  end

  describe '.reminders_for' do
    before do
      File.open('newcomer.txt', 'w+') do |file|
        file.puts template
      end
    end
    after { File.delete('newcomer.txt') }

    subject do
      described_class.reminders_for('newcomer.txt', '@someone', now: Time.mktime(2018,1,21))
    end

    specify do
      is_expected.to eq([
        '/remind me to invite @someone to slack on 01/20/2018',
        '/remind me to add @someone to our team on 01/21/2018',
        '/remind me to pair programming with @someone on 01/22/2018'
      ])
    end
  end
end
