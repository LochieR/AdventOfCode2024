import SharedAoC

public final class Day01: Day {

    private let _input: String
    private var _lhs: [Int] = []
    private var _rhs: [Int] = []

    public init(input: String) {
        self._input = input

        parse()
    }

    public func runP1() -> CodeResult<Int> {
        let leftSorted = quicksort(_lhs)
        let rightSorted = quicksort(_rhs)

        let differences = zip(leftSorted, rightSorted).map { abs($0 - $1) }
        let sum = differences.reduce(0) { $0 + $1 }

        return .Success(result: sum)
    }

    public func runP2() -> CodeResult<Int> {
        var total = 0

        for num in _lhs {
            total += num * _rhs.reduce(0) { $0 + ($1 == num ? 1 : 0) }
        }

        return .Success(result: total)
    }

    private func parse() {
        let lines = _input.split(separator: "\n").map { String($0) }

        for line in lines {
            let numbers = line.split(separator: " ").map { Int(String($0)) ?? 0 }
            
            _lhs.append(numbers[0])
            _rhs.append(numbers[1])
        }
    }

}
