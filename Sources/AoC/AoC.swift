import y2024

let (resultP1, resultP2) = y2024.runDay(day: 1)

switch resultP1 {
    case .Success(let result):
        print("Part 1 success! Result: \(result)")
        break
    case .Error(let string):
        print("An error occurred during part 1.\n\(string)")
        break
}

switch resultP2 {
    case .Success(let result):
        print("Part 2 success! Result: \(result)")
        break
    case .Error(let string):
        print("An error occurred during part 2.\n\(string)")
        break
}