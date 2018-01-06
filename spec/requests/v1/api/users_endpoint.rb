shared_examples 'users endpoint' do
  let(:data_params) do
    {
      full_name: full_name,
      email:     email,
      password:  password
    }
  end

  context 'with valid paramers' do
    let(:full_name) { Faker::Name.name }
    let(:email)     { Faker::Internet.email }
    let(:password)  { Faker::Internet.password }

    it { is_expected.to validate(:post, '/users', 201, params) }
  end

  context 'with empty full_name paramers' do
    let(:full_name) { '' }
    let(:email)     { Faker::Internet.email }
    let(:password)  { Faker::Internet.password }

    specify do
      is_expected.to validate(:post, '/users', 400, params)
      expect(subject.response.parsed_body['error_messages']).to include 'Full Name should not be empty'
    end
  end

  context 'with empty email paramers' do
    let(:full_name) { Faker::Name.name }
    let(:email)     { '' }
    let(:password)  { Faker::Internet.password }

    specify do
      is_expected.to validate(:post, '/users', 400, params)
      expect(subject.response.parsed_body['error_messages']).to include 'Email should not be empty'
    end
  end

  context 'with empty password paramers' do
    let(:full_name) { Faker::Name.name }
    let(:email)     { Faker::Internet.email }
    let(:password)  { '' }

    specify do
      is_expected.to validate(:post, '/users', 400, params)
      expect(subject.response.parsed_body['error_messages']).to include 'Password should not be empty'
    end
  end

  context 'with empty paramers' do
    let(:data_params) { Hash.new }

    specify do
      is_expected.to validate(:post, '/users', 400, params)
      expect(subject.response.parsed_body['error_messages']).to include 'Full Name should not be empty'
      expect(subject.response.parsed_body['error_messages']).to include 'Email should not be empty'
      expect(subject.response.parsed_body['error_messages']).to include 'Password should not be empty'
    end
  end

  context 'with duplicated email paramers' do
    let(:full_name) { Faker::Name.name }
    let(:email)     { Faker::Internet.email }
    let(:password)  { Faker::Internet.password }

    before do
      User::CreateService.new(
        full_name: full_name,
        email:     email,
        password:  password
      ).call
    end

    specify do
      is_expected.to validate(:post, '/users', 409, params)
      expect(subject.response.parsed_body['error_messages']).to include 'Email is already taken'
    end
  end
end
