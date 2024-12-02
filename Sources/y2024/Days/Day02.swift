import SharedAoC

struct Report {
    var Levels: [Int]
}

public final class Day02: Day {

    private let _input: String
    private var _reports: [Report]

    public init(input: String) {
        self._input = input
        self._reports = []

        parse()
    }

    public func runP1() -> CodeResult<Int> {
        let count = _reports.reduce(0) { $0 + (isValid(report: $1) ? 1 : 0) }

        return .Success(result: count)
    }

    public func runP2() -> CodeResult<Int> {
        var count = 0

        for report in _reports {
            if (isValid(report: report)) {
                count += 1
            } else {
                let originalLevels = report.Levels
                
                for i in 0..<originalLevels.count {
                    var newLevels = originalLevels
                    newLevels.remove(at: i)
                    let newReport = Report(Levels: newLevels)

                    if (isValid(report: newReport)) {
                        count += 1
                        break
                    }
                }
            }
        }

        return .Success(result: count)
    }

    private func isValid(report: Report) -> Bool {
        var increasing = true
        var valid = true
        
        for i in 0..<report.Levels.count - 1 {
            let difference = report.Levels[i] - report.Levels[i + 1]
            if i == 0 && difference < 0 {
                increasing = false
            }

            let absDifference = abs(difference)

            if (absDifference < 1 || absDifference > 3 || (increasing && difference < 0) || (!increasing && difference > 0)) {
                valid = false
                break
            }
        }

        return valid
    }

    private func parse() {
        let lines = _input.split(separator: "\n").map { String($0) }

        for line in lines {
            let levels = line.split(separator: " ").map { Int(String($0)) ?? 0 }

            _reports.append(Report(Levels: levels))
        }
    }

}
