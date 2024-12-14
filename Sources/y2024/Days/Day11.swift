import SharedAoC

struct Stone {
    public var Value: Int
    
    public func digitCount() -> Int {
        String(Value).count
    }

    public func firstDigits() -> Int {
        let str = String(Value)
        let startIndex = str.startIndex
        let endIndex = str.index(str.startIndex, offsetBy: str.count / 2)
        let digits = String(str[startIndex..<endIndex])
        return Int(digits) ?? 0
    }

    public func lastDigits() -> Int {
        let str = String(Value)
        let startIndex = str.index(str.startIndex, offsetBy: str.count / 2)
        let endIndex = str.endIndex
        let digits = String(str[startIndex..<endIndex])
        return Int(digits) ?? 0
    }
}

public final class Day11: Day {

    private let _input: String
    private var _stones: [Stone]

    public init(input: String) {
        self._input = input
        self._stones = []

        parse()
    }

    public func runP1() -> CodeResult<Int> {
        var stoneCounts: [Int: Int] = [:]

        for stone in _stones {
            stoneCounts[stone.Value, default: 0] += 1
        }

        for i in 0..<25 {
            var newStoneCounts: [Int: Int] = [:]
            
            for (value, count) in stoneCounts {
                if value == 0 {
                    newStoneCounts[1, default: 0] += count
                } else if String(value).count % 2 == 0 {
                    let first = Stone(Value: value).firstDigits()
                    let last = Stone(Value: value).lastDigits()
                    newStoneCounts[first, default: 0] += count
                    newStoneCounts[last, default: 0] += count
                } else {
                    let newValue = value * 2024
                    newStoneCounts[newValue, default: 0] += count
                }
            }
            
            stoneCounts = newStoneCounts
        }

        let totalStones = stoneCounts.values.reduce(0, +)
        return .Success(result: totalStones)
    }

    public func runP2() -> CodeResult<Int> {
        var stoneCounts: [Int: Int] = [:]

        for stone in _stones {
            stoneCounts[stone.Value, default: 0] += 1
        }

        for i in 0..<75 {
            var newStoneCounts: [Int: Int] = [:]
            
            for (value, count) in stoneCounts {
                if value == 0 {
                    newStoneCounts[1, default: 0] += count
                } else if String(value).count % 2 == 0 {
                    let first = Stone(Value: value).firstDigits()
                    let last = Stone(Value: value).lastDigits()
                    newStoneCounts[first, default: 0] += count
                    newStoneCounts[last, default: 0] += count
                } else {
                    let newValue = value * 2024
                    newStoneCounts[newValue, default: 0] += count
                }
            }
            
            stoneCounts = newStoneCounts
        }

        let totalStones = stoneCounts.values.reduce(0, +)
        return .Success(result: totalStones)
    }

    private func parse() {
        let stoneStrs = _input.split(separator: " ").map { String($0) }

        _stones = stoneStrs.map { Stone(Value: Int($0.trimmingCharacters(in: .whitespacesAndNewlines))!) }
    }

}
