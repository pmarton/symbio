Feature: Order a menu item
  In order to stay strong
  As a hard-working employee
  I want to order a healthy meal

  @javascript
  Scenario: Order a salad, but only if the deadline has not yet passed
    Given a user exists
    And the following salad exists:
    | Date       |
    | 2011-06-27 |
    And the current time is "2011-06-26 21:59:59"
    When I go to the homepage
    And I log in as a user
    Then I should see a link called "Gemischter Salat mit Kernöldressing"
    And I should see "(0)"
    When I follow "Gemischter Salat mit Kernöldressing"
    Then I should see "(1)"
    Given the current time is "2011-06-26 22:00:01"
    Then I should not see a link called "Gemischter Salat mit Kernöldressing"
