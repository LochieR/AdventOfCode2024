import SharedAoC

public class y2024 {

    private static let _days: [Day.Type] = [Day01.self, Day02.self, Day03.self, Day04.self]

    public static func runDay(day: Int) -> (CodeResult<Int>, CodeResult<Int>) {
        if day > 25 || day < 1 {
            return (.Error(string: "Day must be between 1 and 25"), .Error(string: "Day must be between 1 and 25"))
        }

        if day > _days.count {
            return (.Error(string: "Day not implemented"), .Error(string: "Day not implemented"))
        }

        let inputResult = Network.downloadInput(year: 2024, day: day)
        var input: String
        switch inputResult {
            case .Success(let result):
                input = result
                break
            case .Error(_):
                return (.forward(inputResult), .forward(inputResult))
        }

        let dayType = _days[day - 1]

        let instance = dayType.init(input: input)
        let result1 = instance.runP1()
        let result2 = instance.runP2()

        return (result1, result2)
    }

}
