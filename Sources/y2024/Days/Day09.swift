import SharedAoC

enum DiskSpaceType {
    case File
    case Free
}

struct Entry {
    var ID: Int
    var EntryType: DiskSpaceType
    var Size: Int
}

public final class Day09: Day {

    private let _input: String
    private var _entries: [Entry]
    private var _disk: [Int]

    public init(input: String) {
        self._input = input
        self._entries = []
        self._disk = []

        parse()
    }

    public func runP1() -> CodeResult<Int> {
        for i in stride(from: _disk.count - 1, to: 0, by: -1) {
            if _disk[i] == -1 {
                continue
            }

            for j in 0..<_disk.count {
                if _disk[j] == -1 && j < i {
                    _disk[j] = _disk[i]
                    _disk[i] = -1
                }
            }
        }

        var checksum = 0
        var pos = 0
        for data in _disk {
            if data == -1 {
                pos += 1
                continue
            }

            checksum += data * pos
            pos += 1
        }

        return .Success(result: checksum)
    }

    public func runP2() -> CodeResult<Int> {
        var i = _entries.count - 1
        while i != 0 {
            if _entries[i].EntryType == .Free {
                i -= 1
                continue
            }

            for j in 0..<_entries.count {
                if _entries[j].EntryType != .Free {
                    continue
                }

                if j >= i {
                    break
                }

                if _entries[j].Size < _entries[i].Size {
                    continue
                } else if _entries[j].Size == _entries[i].Size {
                    _entries[j].ID = _entries[i].ID
                    _entries[j].EntryType = .File
                    _entries[i].ID = -1
                    _entries[i].EntryType = .Free
                    break
                } else if _entries[j].Size > _entries[i].Size {
                    _entries.insert(Entry(ID: -1, EntryType: .Free, Size: _entries[j].Size - _entries[i].Size), at: j + 1)
                    i += 1
                    _entries[j].ID = _entries[i].ID
                    _entries[j].EntryType = .File
                    _entries[j].Size = _entries[i].Size
                    _entries[i].ID = -1
                    _entries[i].EntryType = .Free
                    break
                }
            }

            i -= 1
        }

        var disk: [Int] = []
        for entry in _entries {
            for _ in 0..<entry.Size {
                disk.append(entry.ID)
            }
        }

        var checksum = 0
        var pos = 0
        for data in disk {
            if data == -1 {
                pos += 1
                continue
            }

            checksum += data * pos
            pos += 1
        }

        return .Success(result: checksum)
    }

    private func parse() {
        var id = 0
        var isFile = true
        for c in _input {
            _entries.append(Entry(ID: isFile ? id : -1, EntryType: isFile ? .File : .Free, Size: Int(String(c)) ?? 0))
            if isFile {
                id += 1
            }
            isFile = !isFile
        }

        for entry in _entries {
            for _ in 0..<entry.Size {
                _disk.append(entry.ID)
            }
        }
    }

}
