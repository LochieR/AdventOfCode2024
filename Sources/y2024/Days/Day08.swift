import SharedAoC

public final class Day08: Day {

    private let _input: String
    private var _antennas: [(x: Int, y: Int, freq: Int)]
    private var _antinodes: [(x: Int, y: Int)]
    private var _maxPosition: (x: Int, y: Int)
    private let _minPosition: (x: Int, y: Int)

    private typealias Vector = (x: Int, y: Int)

    public init(input: String) {
        self._input = input
        self._antennas = []
        self._antinodes = []
        self._maxPosition = (x: 0, y: 0)
        self._minPosition = (x: 0, y: 0)

        parse()
    }

    public func runP1() -> CodeResult<Int> {
        for i in 0..<_antennas.count {
            for j in 0..<_antennas.count {
                if i == j {
                    continue
                }

                let antenna1 = _antennas[i]
                let antenna2 = _antennas[j]

                if antenna1.freq != antenna2.freq {
                    continue
                }

                let vector = Vector(x: antenna2.x - antenna1.x, y: antenna2.y - antenna1.y) // from 1 to 2
                let antinodePosition = (x: antenna1.x - vector.x, y: antenna1.y - vector.y)

                _antinodes.append(antinodePosition)
            }
        }

        var seen: [(Int, Int)] = []
        let uniqueAntinodes = _antinodes.filter { antinode in
            if antinode.x > _maxPosition.x || antinode.y > _maxPosition.y || antinode.x < _minPosition.x || antinode.y < _minPosition.y {
                return false
            }

            if seen.contains(where: { $0 == antinode }) {
                return false
            } else {
                seen.append(antinode)
                return true
            }
        }

        return .Success(result: uniqueAntinodes.count)
    }

    public func runP2() -> CodeResult<Int> {
        for i in 0..<_antennas.count {
            for j in 0..<_antennas.count {
                if i == j {
                    continue
                }

                let antenna1 = _antennas[i]
                let antenna2 = _antennas[j]

                if antenna1.freq != antenna2.freq {
                    continue
                }

                let vector = Vector(x: antenna2.x - antenna1.x, y: antenna2.y - antenna1.y) // from 1 to 2
                var antinodePosition = (x: antenna1.x - vector.x, y: antenna1.y - vector.y)
                
                _antinodes.append((x: antenna1.x, y: antenna1.y))
                _antinodes.append((x: antenna2.x, y: antenna2.y))

                while antinodePosition.x <= _maxPosition.x && antinodePosition.y <= _maxPosition.y && antinodePosition.x >= _minPosition.x && antinodePosition.y >= _minPosition.y {
                    _antinodes.append(antinodePosition)
                    antinodePosition = (x: antinodePosition.x - vector.x, y: antinodePosition.y - vector.y)
                }
            }
        }

        var seen: [(Int, Int)] = []
        let uniqueAntinodes = _antinodes.filter { antinode in
            if antinode.x > _maxPosition.x || antinode.y > _maxPosition.y || antinode.x < _minPosition.x || antinode.y < _minPosition.y {
                return false
            }

            if seen.contains(where: { $0 == antinode }) {
                return false
            } else {
                seen.append(antinode)
                return true
            }
        }

        return .Success(result: uniqueAntinodes.count)
    }

    private func parse() {
        let lines = _input.split(separator: "\n").map { String($0) }
        let rowCount = lines.count
        let colCount = lines[0].count

        for row in 0..<rowCount {
            for col in 0..<colCount {
                let index = lines[row].index(lines[row].startIndex, offsetBy: col)
                if lines[row][index] != "." {
                    _antennas.append((x: col, y: row, freq: Int(lines[row][index].asciiValue ?? 0)))
                }
            }
        }

        _maxPosition = (x: colCount - 1, y: rowCount - 1)
    }

}
