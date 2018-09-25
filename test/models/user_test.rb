require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name:"michel", email:"test@test.fr")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "nom should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 255 + "@exemple.fr"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    adresses_valides = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp justine+jean@baz.cn]
      adresses_valides.each do |adresse_valide|
        @user.email = adresse_valide
        assert @user.valid?, "#{adresse_valide.inspect} doit être valide."
      end
    end

    test "email validation should reject invalid addresses" do
      adresses_invalides = %w[user@example,com user_at_foo.org user.name@example.
        foo@bar_baz.com foo@bar+baz.com]
        adresses_invalides.each do |adresse_invalide|
          @user.email = adresse_invalide
          assert_not @user.valid?, "#{adresse_invalide.inspect} doit être invalide."
        end
      end

      test "Email adresses shoumd be unique" do
        utilisateur_duplique = @user.dup
        utilisateur_duplique.email = @user.email.upcase
        @user.save
        assert_not utilisateur_duplique.valid?
      end

    end
