import SharedAoC

struct PageRule {
    let X: Int
    let Y: Int
}

public final class Day05: Day {

    private let _input: String
    private var _rules: [PageRule]
    private var _updates: [[Int]]
    private var _incorrectlyOrdered: [[Int]]

    public init(input: String) {
        self._input = input
        _rules = []
        _updates = []
        _incorrectlyOrdered = []

        parse()
    }

    public func runP1() -> CodeResult<Int> {
        var total = 0

        for update in _updates {
            var valid = true

            for i in 0..<update.count - 1 {
                for j in (i + 1)..<update.count {
                    if !checkRules(x: update[i], y: update[j]) {
                        valid = false
                    }
                }
            }

            if valid {
                total += update[update.count / 2]
            } else {
                _incorrectlyOrdered.append(update)
            }
        }

        return .Success(result: total)
    }

    public func runP2() -> CodeResult<Int> {
        var total = 0

        for update in _incorrectlyOrdered {
            let sorted = update.sorted(by: checkRules(x:y:))
            total += sorted[sorted.count / 2]
        }

        return .Success(result: total)
    }

    private func checkRules(x: Int, y: Int) -> Bool {
        for rule in _rules {
            if rule.X == x && rule.Y == y {
                return true
            }
        }
        return false
    }

    public func parse() {
        let lines = _input.split(separator: "\n").map { String($0) }

        for line in lines {
            if line.contains("|") {
                // rule

                let parts = line.split(separator: "|").map { Int(String($0)) ?? 0 }
                _rules.append(PageRule(X: parts[0], Y: parts[1]))
            }
            else if line.contains(",") {
                // update

                let parts = line.split(separator: ",").map { Int(String($0)) ?? 0 }
                _updates.append(parts)
            }
        }
    }

}
