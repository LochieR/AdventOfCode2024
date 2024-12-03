import Foundation
import SharedAoC

enum InstructionType {
    case Do
    case Dont
    case Mul
}

struct Instruction {
    let InstructType: InstructionType
    let LHS: Int
    let RHS: Int
}

public final class Day03: Day {

    private let _input: String
    private var _instructions: [Instruction]

    public init(input: String) {
        self._input = input
        self._instructions = []

        parse()
    }

    public func runP1() -> CodeResult<Int> {
        let total = _instructions.reduce(0) { $0 + ($1.InstructType == .Mul ? $1.LHS * $1.RHS : 0) }

        return .Success(result: total)
    }

    public func runP2() -> CodeResult<Int> {
        var enabled = true

        var total = 0

        for instruction in _instructions {
            switch instruction.InstructType {
                case .Do:
                    enabled = true
                    break
                case .Dont:
                    enabled = false
                    break
                case .Mul:
                    if enabled {
                        total += instruction.LHS * instruction.RHS
                    }
                    break
            }
        }

        return .Success(result: total)
    }

    private func parse() {
        let pattern =  #"(do\(\)|don't\(\)|mul\((\d+),(\d+)\))"#

        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(_input.startIndex..<_input.endIndex, in: _input)

        regex.enumerateMatches(in: _input, options: [], range: range) { [unowned self] match, _, _ in
            guard let match = match else {
                return
            }

            let matchRange = match.range(at: 0)
            guard let range = Range(matchRange, in: _input) else {
                return
            }

            let matchText = String(_input[range])

            if matchText == "do()" {
                _instructions.append(Instruction(InstructType: .Do, LHS: 0, RHS: 0))
            } else if matchText == "don't()" {
                _instructions.append(Instruction(InstructType: .Dont, LHS: 0, RHS: 0))
            } else if matchText.hasPrefix("mul") {
                let lhsRange = match.range(at: 2)
                let rhsRange = match.range(at: 3)

                if let lhsRange = Range(lhsRange, in: _input),
                   let rhsRange = Range(rhsRange, in: _input),
                   let lhs = Int(_input[lhsRange]),
                   let rhs = Int(_input[rhsRange]) {
                    _instructions.append(Instruction(InstructType: .Mul, LHS: lhs, RHS: rhs))
               }
            }
        }
    }

    private func numberLength(start: String.Index, _ input: String) -> Int {
        var i = start
        var count = 0
        while input[i].isNumber {
            i = input.index(i, offsetBy: 1)
            count += 1
        }

        return count
    }

}
