require 'helper'
 
describe 'configuration' do
 
  describe '.api_key' do
    it 'should return default key' do
      Prosperent.api_key.must_equal Prosperent::Configuration::DEFAULT_API_KEY
    end
  end
 
  describe '.format' do
    it 'should return default format' do
      Prosperent.format.must_equal Prosperent::Configuration::DEFAULT_FORMAT
    end
  end
 
  describe '.user_agent' do
    it 'should return default user agent' do
      Prosperent.user_agent.must_equal Prosperent::Configuration::DEFAULT_USER_AGENT
    end
  end
 
  describe '.method' do
    it 'should return default http method' do
      Prosperent.method.must_equal Prosperent::Configuration::DEFAULT_METHOD
    end
  end

  after do
    Prosperent.reset
  end
 
  describe '.configure' do
    Prosperent::Configuration::VALID_CONFIG_KEYS.each do |key|
      it "should set the #{key}" do
        Prosperent.configure do |config|
          config.send("#{key}=", key)
          Prosperent.send(key).must_equal key
        end
      end
    end
  end

  Prosperent::Configuration::VALID_CONFIG_KEYS.each do |key|
    describe ".#{key}" do
      it 'should return the default value' do
        Prosperent.send(key).must_equal Prosperent::Configuration.const_get("DEFAULT_#{key.upcase}")
      end
    end
  end
  
end