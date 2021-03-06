import XCTest
@testable import Katas

class YahtzeeTest: XCTestCase {
    func testDiceRolls() {
      let dice = Dice.roll(5)
      XCTAssertEqual(5, dice.count)

      let dice2 = Dice.roll(100)
      for d in dice2 {
        XCTAssert(d >= 1 && d <= 6)
      }
    }

    func testScoringOnes() {
      let dice = [1, 1, 3, 4, 5]
      let expected = 2
      let score = Singles(pip: 1).score(dice)
      XCTAssertEqual(expected, score)
    }

    func testScoringTwos() {
      let dice = [1, 1, 2, 4, 5]
      let expected = 2
      let score = Singles(pip: 2).score(dice)
      XCTAssertEqual(expected, score)
    }

    func testThreeOfAKind() {
      let dice = [1, 1, 1, 4, 5]
      let expected = 12
      let score = ThreeOfAKind().score(dice)
      XCTAssertEqual(expected, score)
    }

    func testYahtzee() {
      let dice = [1, 1, 1, 1, 1]
      let expected = 50
      let score = Yahtzee().score(dice)
      XCTAssertEqual(expected, score)
    }

    func testSmallStraight() {
      let dice = [1, 2, 3, 4, 1]
      let expected = 30
      let score = SmallStraight().score(dice)
      XCTAssertEqual(expected, score)
    }
}
