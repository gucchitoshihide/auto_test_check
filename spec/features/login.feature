Feature: User can start using application by applying infromation.

  Background:
    Given The accounts of user registered

  Scenario Outline: The user can login.
    Given I access the login page

    When I try to login with "<name>" and "<password>"
    Then I can see button "スキルプロフィール" and "設定" on the "welcome" page

    Examples:
      | name      | password |
      | testmatsu | testpass |
