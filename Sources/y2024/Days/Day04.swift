import SharedAoC

public final class Day04: Day {

    private let _input: String

    public init(input: String) {
        self._input = input

        parse()
    }

    public func runP1() -> CodeResult<Int> {
        let lines = _input.split(separator: "\n").map { String($0) }
        let rowCount = lines.count
        let colCount = lines[0].count
        var xPositions: [(row: Int, col: Int)] = []

        for row in 0..<rowCount {
            for col in 0..<colCount {
                let index = lines[row].index(lines[row].startIndex, offsetBy: col)
                if lines[row][index] == "X" {
                    xPositions.append((row: row, col: col))
                }
            }
        }

        var count = 0

        func checkPosition(row: Int, col: Int, character: Character) -> Bool {
            row >= 0 && row < rowCount &&
                col >= 0 && col < colCount &&
                lines[row][lines[row].index(lines[row].startIndex, offsetBy: col)] == character
        }

        for (row, col) in xPositions {
            if checkPosition(row: row, col: col + 1, character: "M") &&
                checkPosition(row: row, col: col + 2, character: "A") &&
                checkPosition(row: row, col: col + 3, character: "S") {
                count += 1
            }

            if checkPosition(row: row, col: col - 1, character: "M") &&
                checkPosition(row: row, col: col - 2, character: "A") &&
                checkPosition(row: row, col: col - 3, character: "S") {
                count += 1
            }

            if checkPosition(row: row + 1, col: col, character: "M") &&
                checkPosition(row: row + 2, col: col, character: "A") &&
                checkPosition(row: row + 3, col: col, character: "S") {
                count += 1
            }

            if checkPosition(row: row - 1, col: col, character: "M") &&
                checkPosition(row: row - 2, col: col, character: "A") &&
                checkPosition(row: row - 3, col: col, character: "S") {
                count += 1
            }

            if checkPosition(row: row + 1, col: col + 1, character: "M") &&
                checkPosition(row: row + 2, col: col + 2, character: "A") &&
                checkPosition(row: row + 3, col: col + 3, character: "S") {
                count += 1
            }

            if checkPosition(row: row + 1, col: col - 1, character: "M") &&
                checkPosition(row: row + 2, col: col - 2, character: "A") &&
                checkPosition(row: row + 3, col: col - 3, character: "S") {
                count += 1
            }

            if checkPosition(row: row - 1, col: col + 1, character: "M") &&
                checkPosition(row: row - 2, col: col + 2, character: "A") &&
                checkPosition(row: row - 3, col: col + 3, character: "S") {
                count += 1
            }

            if checkPosition(row: row - 1, col: col - 1, character: "M") &&
                checkPosition(row: row - 2, col: col - 2, character: "A") &&
                checkPosition(row: row - 3, col: col - 3, character: "S") {
                count += 1
            }
        }

        return .Success(result: count)
    }

    public func runP2() -> CodeResult<Int> {
        let lines = _input.split(separator: "\n").map { String($0) }
        let rowCount = lines.count
        let colCount = lines[0].count
        var positions: [(row: Int, col: Int)] = []

        for row in 0..<rowCount {
            for col in 0..<colCount {
                positions.append((row: row, col: col))
            }
        }

        var count = 0

        func checkPosition(row: Int, col: Int, character: Character) -> Bool {
            row >= 0 && row < rowCount &&
                col >= 0 && col < colCount &&
                lines[row][lines[row].index(lines[row].startIndex, offsetBy: col)] == character
        }

        for (row, col) in positions {
            if checkPosition(row: row, col: col, character: "M") &&
               checkPosition(row: row + 1, col: col + 1, character: "A") &&
               checkPosition(row: row + 2, col: col + 2, character: "S") {
                let newCol = col + 2
                
                if checkPosition(row: row, col: newCol, character: "M") &&
                   checkPosition(row: row + 1, col: newCol - 1, character: "A") &&
                   checkPosition(row: row + 2, col: newCol - 2, character: "S") {
                    count += 1
                }

                if checkPosition(row: row, col: newCol, character: "S") &&
                   checkPosition(row: row + 1, col: newCol - 1, character: "A") &&
                   checkPosition(row: row + 2, col: newCol - 2, character: "M") {
                    count += 1
                }
            }

            if checkPosition(row: row, col: col, character: "S") &&
               checkPosition(row: row + 1, col: col + 1, character: "A") &&
               checkPosition(row: row + 2, col: col + 2, character: "M") {
                let newCol = col + 2
                
                if checkPosition(row: row, col: newCol, character: "M") &&
                   checkPosition(row: row + 1, col: newCol - 1, character: "A") &&
                   checkPosition(row: row + 2, col: newCol - 2, character: "S") {
                    count += 1
                }
                
                if checkPosition(row: row, col: newCol, character: "S") &&
                   checkPosition(row: row + 1, col: newCol - 1, character: "A") &&
                   checkPosition(row: row + 2, col: newCol - 2, character: "M") {
                    count += 1
                }
            }
        }

        return .Success(result: count)
    }

    private func parse() {

    }

}
