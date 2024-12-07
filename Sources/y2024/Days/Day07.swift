import SharedAoC
import Foundation

enum Operator {
    case Add
    case Mul
    case Cat
}

public final class Day07: Day {

    private let _input: String
    private var _calibrationEquations: [(result: Int, inputs: [Int])]

    public init(input: String) {
        self._input = input
        self._calibrationEquations = []

        parse()
    }

    public func runP1() -> CodeResult<Int> {
        var total = 0

        for equation in _calibrationEquations {
            var possible = false

            let operatorCount = equation.inputs.count - 1
            let totalPerms = 1 << operatorCount

            for i in 0..<totalPerms {
                var permutation: [Operator] = []
                
                for j in 0..<operatorCount {
                    let bit = (i >> j) & 1
                    permutation.append(bit == 0 ? .Add : .Mul)
                }

                if equation.result == calculate(inputs: equation.inputs, operators: permutation) {
                    possible = true
                    break
                }
            }

            if possible {
                total += equation.result
            }
        }

        return .Success(result: total)
    }

    public func runP2() -> CodeResult<Int> {
        var total = 0

        for equation in _calibrationEquations {
            var possible = false

            let operatorCount = equation.inputs.count - 1
            let totalPerms = pow(3, operatorCount)

            for i in 0..<totalPerms {
                var permutation: [Operator] = []
                var num = i

                for _ in 0..<operatorCount {
                    let operatorIndex = num % 3
                    num /= 3

                    switch operatorIndex {
                        case 0:
                            permutation.append(.Add)
                            break
                        case 1:
                            permutation.append(.Mul)
                            break
                        case 2:
                            permutation.append(.Cat)
                            break
                        default:
                            break
                    }
                }

                if equation.result == calculate(inputs: equation.inputs, operators: permutation) {
                    possible = true
                    break
                }
            }

            if possible {
                total += equation.result
            }
        }

        return .Success(result: total)
    }

    private func calculate(inputs: [Int], operators: [Operator]) -> Int {
        var result = inputs[0]

        for i in 0..<operators.count {
            let op = operators[i]
            let nextInput = inputs[i + 1]

            if op == .Add {
                result += nextInput
            } else if op == .Mul {
                result *= nextInput
            } else if op == .Cat {
                let resultString = String(result)
                let nextInputString = String(nextInput)
                result = Int(resultString + nextInputString) ?? 0
            }
        }

        return result
    }

    private func parse() {
        let lines = _input.split(separator: "\n").map { String($0) }

        for line in lines {
            let resultSplit = line.split(separator: ":")

            let lhs = Int(String(resultSplit[0])) ?? 0
            let inputsSplit = resultSplit[1].split(separator: " ").map { Int(String($0)) ?? 0 }

            _calibrationEquations.append((result: lhs, inputs: inputsSplit))
        }
    }

    private func pow(_ base: Int, _ exponent: Int) -> Int {
        if exponent == 0 {
            return 1
        }

        if exponent < 0 {
            return 1
        }
        
        var result = 1
        for _ in 0..<exponent {
            result *= base
        }
        
        return result
    }

}
