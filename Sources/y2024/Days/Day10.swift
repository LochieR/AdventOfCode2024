import SharedAoC

public final class Day10: Day {

    private let _input: String
    private var _map: [(pos: Vec2, height: Int)]
    private var _max: Vec2

    public init(input: String) {
        self._input = input
        self._map = []
        self._max = Vec2(x: 0, y: 0)

        parse()
    }

    public func runP1() -> CodeResult<Int> {
        var total = 0

        for (pos, height) in _map {
            if height == 0 {
                total += bfs(start: pos)
            }
        }

        return .Success(result: total)
    }

    public func runP2() -> CodeResult<Int> {
        var total = 0
        
        for (pos, height) in _map {
            if height == 0 {
                total += calculateRating(start: pos)
            }
        }
        
        return .Success(result: total)
    }

    private func height(at pos: Vec2) -> Int? {
        guard pos.X >= 0, pos.Y >= 0, pos.X < _max.X, pos.Y < _max.Y else { return nil }
        return _map[pos.Y * _max.X + pos.X].height
    }

    private func neighbors(of pos: Vec2) -> [Vec2] {
        let vecs: [Vec2] = [
            Vec2(x: pos.X + 1, y: pos.Y), // right
            Vec2(x: pos.X - 1, y: pos.Y), // left
            Vec2(x: pos.X, y: pos.Y + 1), // down
            Vec2(x: pos.X, y: pos.Y - 1)  // up
        ]
        return vecs.filter { $0.X >= 0 && $0.Y >= 0 && $0.X < _max.X && $0.Y < _max.Y }
    }

    private func bfs(start: Vec2) -> Int {
        var queue: [Vec2] = [start]
        var visited: Set<Vec2> = [start]
        var foundNines: Set<Vec2> = []

        while !queue.isEmpty {
            let pos = queue.removeFirst()
            guard let currentHeight = height(at: pos) else { continue }
            
            if currentHeight == 9 {
                foundNines.insert(pos)
            }
            
            for neighbor in neighbors(of: pos) {
                let npos = neighbor
                guard !visited.contains(npos) else { continue }
                
                if let nextHeight = height(at: npos), nextHeight == currentHeight + 1 {
                    queue.append(npos)
                    visited.insert(npos)
                }
            }
        }
        
        return foundNines.count
    }

    private func calculateRating(start: Vec2) -> Int {
        var queue: [(pos: Vec2, path: [Vec2])] = [(start, [start])]
        var foundPaths: Set<[Vec2]> = []
        
        while !queue.isEmpty {
            let (pos, path) = queue.removeFirst()
            guard let currentHeight = height(at: pos) else { continue }
            
            if currentHeight == 9 {
                foundPaths.insert(path)
            }
            
            for neighbor in neighbors(of: pos) {
                let npos = neighbor
                if !path.contains(npos) {
                    if let nextHeight = height(at: npos), nextHeight == currentHeight + 1 {
                        queue.append((npos, path + [npos]))
                    }
                }
            }
        }
        
        return foundPaths.count
    }

    private func parse() {
        let lines = _input.split(separator: "\n").map { String($0) }
        let rowCount = lines.count
        let colCount = lines[0].count

        for row in 0..<rowCount {
            for col in 0..<colCount {
                let index = lines[row].index(lines[row].startIndex, offsetBy: col)
                _map.append((pos: Vec2(x: col, y: row), height: Int(String(lines[row][index])) ?? 0))
            }
        }

        _max = Vec2(x: colCount, y: rowCount)
    }

}
