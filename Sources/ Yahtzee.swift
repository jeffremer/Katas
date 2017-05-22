import Foundation

struct Dice {
  static func roll (_ count: Int) -> [Int] {
    return (0..<count).map { _ in
      return Int(arc4random_uniform(6)) + 1
    }
  }
}

protocol Pattern {
  func matches(_ dice: [Int]) -> Bool
  func score(_ dice: [Int]) -> Int
}

struct Singles : Pattern {
  let pip: Int

  func matches(_ dice: [Int]) -> Bool {
    return findMatchingPips(dice).count > 0
  }

  func score(_ dice: [Int]) -> Int {
    return findMatchingPips(dice).reduce(0, +)
  }

  private func findMatchingPips(_ dice: [Int]) -> [Int] {
    return dice.filter { $0 == self.pip }
  }
}

protocol Repetition : Pattern {
  var minimum: Int { get }

}

protocol SumScore {}
extension SumScore where Self : Pattern {
  func score(_ dice: [Int]) -> Int  {
    return matches(dice) ? dice.reduce(0, +) : 0
  }
}

extension Repetition {
  private func counts(_ dice: [Int]) -> [Int: Int] {
    var counts: [Int: Int] = [:]
    dice.forEach {
      counts[$0] = (counts[$0] ?? 0) + 1
    }
    return counts
  }

  func matches(_ dice: [Int]) -> Bool {
    return counts(dice).filter({_, count in count >= minimum }).first != nil
  }
}

struct ThreeOfAKind : Repetition, SumScore {
  var minimum: Int { return 3 }
}

struct FourOfAKind : Repetition, SumScore {
  var minimum: Int { return 4 }
}

protocol StaticScore {
    var possibleScore: Int { get }
}
extension StaticScore where Self : Pattern {
  func score(_ dice: [Int]) -> Int {
      return matches(dice) ? possibleScore : 0
  }
}

struct Yahtzee : Repetition, StaticScore {
  var possibleScore: Int { return 50 }
  var minimum: Int { return 5 }
}
