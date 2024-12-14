import SharedAoC
import Foundation

public class y2024 {

    private static let _days: [Day.Type] = [Day01.self, Day02.self, Day03.self, Day04.self, Day05.self, Day06.self, Day07.self, Day08.self, Day09.self, Day10.self, Day11.self]

    public static func runDay(day: Int) -> (CodeResult<Int>, Double, CodeResult<Int>, Double) {
        if day > 25 || day < 1 {
            return (.Error(string: "Day must be between 1 and 25"), 0.0, .Error(string: "Day must be between 1 and 25"), 0.0)
        }

        if day > _days.count {
            return (.Error(string: "Day not implemented"), 0.0, .Error(string: "Day not implemented"), 0.0)
        }

        let inputResult = Network.downloadInput(year: 2024, day: day)
        var input: String
        switch inputResult {
            case .Success(let result):
                input = result
                break
            case .Error(_):
                return (.forward(inputResult), 0.0, .forward(inputResult), 0.0)
        }

        let dayType = _days[day - 1]

        let instance = dayType.init(input: input)
        
        var startTime = Date()
        let result1 = instance.runP1()
        var endTime = Date()
        let timeElapsed1 = endTime.timeIntervalSince(startTime) * 1000.0

        startTime = Date()
        let result2 = instance.runP2()
        endTime = Date()
        let timeElapsed2 = endTime.timeIntervalSince(startTime) * 1000.0

        return (result1, timeElapsed1, result2, timeElapsed2)
    }

}
