shared_examples 'current_user endpoint' do
  let(:headers) do
    {
      'X-User-Token': user_token
    }
  end

  let!(:user) do
    ucs = User::CreateService.new(
      full_name: Faker::Name.name,
      email:     Faker::Internet.email,
      password:  Faker::Internet.password
    )
    ucs.call
    ucs.user
  end

  context 'with valid user_token' do
    let(:user_token) { user.token }

    specify do
      is_expected.to validate(:get, '/current_user', 200, params)
      expect(subject.response.parsed_body['user_id']).to     eq user.id.to_s
      expect(subject.response.parsed_body['full_name']).to   eq user.full_name
      expect(subject.response.parsed_body['email']).to       eq user.email
    end
  end

  context 'with invalid user_token' do
    let(:user_token) { user.token + 'fake' }

    it { is_expected.to validate(:get, '/current_user', 401, params) }
  end

  context 'with empty user_token' do
    let(:headers) { Hash.new }

    it { is_expected.to validate(:get, '/current_user', 401, params) }
  end
end
