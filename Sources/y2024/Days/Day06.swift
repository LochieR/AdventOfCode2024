import Foundation
import SharedAoC

enum Direction {
    case Up
    case Down
    case Left
    case Right
}

public final class Day06: Day {

    private let _input: String
    private var _obstaclePositions: [(x: Int, y: Int)]
    private var _position: (x: Int, y: Int)
    private var _visitedPositions: [(x: Int, y: Int)]
    private var _maxPosition: (x: Int, y: Int)
    private let _minPosition: (x: Int, y: Int)

    public init(input: String) {
        self._input = input
        self._obstaclePositions = []
        self._position = (x: 0, y: 0)
        self._visitedPositions = []
        self._maxPosition = (x: 0, y: 0)
        self._minPosition = (x: -1, y: -1)

        parse()
    }

    public func runP1() -> CodeResult<Int> {
        var direction: Direction = .Up

        var running = true
        var position = _position

        while running {
            loop(&running, &position, &direction, true, _obstaclePositions)
        }

        return .Success(result: _visitedPositions.count)
    }

    public func runP2() -> CodeResult<Int> {
        let obstaclePositionsTemp = _obstaclePositions

        var results: [Int] = []
        for _ in 0..<_visitedPositions.count {
            results.append(0)
        }

        DispatchQueue.concurrentPerform(iterations: _visitedPositions.count) { index in
            let visitedPosition = _visitedPositions[index]

            if visitedPosition == _position {
                return
            }

            //print("\(index)/\(_visitedPositions.count) on thread \(Thread.current)")

            var direction: Direction = .Up
            var running = true
            var position = _position
            var pastPositionDirs: [(x: Int, y: Int, d: Direction)] = []

            var obstaclePositions = obstaclePositionsTemp
            obstaclePositions.append(visitedPosition)
            while running {
                loop(&running, &position, &direction, false, obstaclePositions)
                if !pastPositionDirs.contains(where: { $0.x == position.x && $0.y == position.y && $0.d == direction }) {
                    pastPositionDirs.append((x: position.x, y: position.y, d: direction))
                } else {
                    running = false
                    results[index] += 1
                }
            }
        }

        let count = results.reduce(0) { $0 + $1 }

        // for visitedPosition in _visitedPositions {
        //     if visitedPosition == _position {
        //         continue
        //     }

        //     print("\(n)/\(_visitedPositions.count)")
        //     n += 1

        //     var direction: Direction = .Up
        //     var running = true
        //     var position = _position
        //     var pastPositionDirs: [(x: Int, y: Int, d: Direction)] = []

        //     _obstaclePositions.append(visitedPosition)
        //     while running {
        //         loop(&running, &position, &direction, false)
        //         if !pastPositionDirs.contains(where: { $0.x == position.x && $0.y == position.y && $0.d == direction }) {
        //             pastPositionDirs.append((x: position.x, y: position.y, d: direction))
        //         } else {
        //             running = false
        //             count += 1
        //         }
        //     }
        //     _obstaclePositions.removeAll { $0 == visitedPosition }
        // }

        return .Success(result: count)
    }

    private func loop(_ running: inout Bool, _ position: inout (x: Int, y: Int), _ direction: inout Direction, _ appendPosition: Bool, _ obstaclePositions: [(x: Int, y: Int)]) {
        switch direction {
                case .Up:
                    if obstacleExists(x: position.x, y: position.y - 1, obstaclePositions) {
                        direction = .Right
                        break
                    } else {
                        position.y -= 1

                        if position.y == _minPosition.y {
                            running = false
                            break
                        }

                        if appendPosition && !_visitedPositions.contains(where: { $0.x == position.x && $0.y == position.y }) {
                            _visitedPositions.append(position)
                        }
                        break
                    }
                case .Down:
                    if obstacleExists(x: position.x, y: position.y + 1, obstaclePositions) {
                        direction = .Left
                        break
                    } else {
                        position.y += 1

                        if position.y == _maxPosition.y {
                            running = false
                            break
                        }

                        if appendPosition && !_visitedPositions.contains(where: { $0.x == position.x && $0.y == position.y }) {
                            _visitedPositions.append(position)
                        }
                        break
                    }
                case .Left:
                    if obstacleExists(x: position.x - 1, y: position.y, obstaclePositions) {
                        direction = .Up
                        break
                    } else {
                        position.x -= 1

                        if position.x == _minPosition.x {
                            running = false
                            break
                        }

                        if appendPosition && !_visitedPositions.contains(where: { $0.x == position.x && $0.y == position.y }) {
                            _visitedPositions.append(position)
                        }
                        break
                    }
                case .Right:
                    if obstacleExists(x: position.x + 1, y: position.y, obstaclePositions) {
                        direction = .Down
                        break
                    } else {
                        position.x += 1

                        if position.x == _maxPosition.x {
                            running = false
                            break
                        }

                        if appendPosition && !_visitedPositions.contains(where: { $0.x == position.x && $0.y == position.y }) {
                            _visitedPositions.append(position)
                        }
                        break
                    }
            }
    }

    private func obstacleExists(x: Int, y: Int, _ obstaclePositions: [(x: Int, y: Int)]) -> Bool {
        for obstacle in obstaclePositions {
            if obstacle.x == x && obstacle.y == y {
                return true
            }
        }
        return false
    }

    private func parse() {
        let lines = _input.split(separator: "\n").map { String($0) }
        let rowCount = lines.count
        let colCount = lines[0].count

        for row in 0..<rowCount {
            for col in 0..<colCount {
                let index = lines[row].index(lines[row].startIndex, offsetBy: col)
                if lines[row][index] == "#" {
                    _obstaclePositions.append((x: col, y: row))
                } else if lines[row][index] == "^" {
                    _position = (x: col, y: row)
                }
            }
        }

        _visitedPositions.append(_position)
        _maxPosition = (x: colCount, y: rowCount)
    }

}
