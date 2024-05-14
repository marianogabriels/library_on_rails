require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Role" do
    let(:member) { User.create(email: 'member@example.com', password: 'password', role: 'member') }
    let(:librarian) { User.create(email: 'librarian@example.com', password: 'password', role: 'librarian') }

    it('#member?') { expect(member.member?).to be(true)  }
    it('#librarian?') { expect(librarian.librarian?).to be(true)  }
  end
end
