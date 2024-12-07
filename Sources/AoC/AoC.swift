import y2024

let (resultP1, timeElapsed1, resultP2, timeElapsed2) = y2024.runDay(day: 7)

switch resultP1 {
    case .Success(let result):
        print("Part 1 result: \(result) in \(String(format: "%.2f", timeElapsed1))ms")
        break
    case .Error(let string):
        print("An error occurred during part 1.\n\(string)")
        break
}

switch resultP2 {
    case .Success(let result):
        print("Part 2 result: \(result) in \(String(format: "%.2f", timeElapsed2))ms")
        break
    case .Error(let string):
        print("An error occurred during part 2.\n\(string)")
        break
}
