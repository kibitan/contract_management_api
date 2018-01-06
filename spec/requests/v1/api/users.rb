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

  pending 'with empty full_name paramers' do
    let(:full_name) { '' }
    let(:email)     { Faker::Internet.email }
    let(:password)  { Faker::Internet.password }

    # TODO: test error message “Full Name should not be empty”
    it { is_expected.to validate(:post, '/users', 400, params) }
  end

  pending 'with empty email paramers' do
    let(:full_name) { Faker::Name.name }
    let(:email)     { '' }
    let(:password)  { Faker::Internet.password }

    # TODO: test error message “Email should not be empty”
    it { is_expected.to validate(:post, '/users', 400, params) }
  end

  pending 'with empty password paramers' do
    let(:full_name) { Faker::Name.name }
    let(:email)     { Faker::Internet.email }
    let(:password)  { '' }

    # TODO: test error message “Password should not be empty”
    it { is_expected.to validate(:post, '/users', 400, params) }
  end

  pending 'with duplicated email paramers' do
    let(:full_name) { Faker::Name.name }
    let(:email)     { Faker::Internet.email }
    let(:password)  { Faker::Internet.password }

    before { 'call UserFactory here' }

    # TODO: test error message “Email is already taken”
    it { is_expected.to validate(:post, '/users', 409, params) }
  end
end
