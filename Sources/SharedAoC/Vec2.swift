import Foundation

public struct Vec2: Hashable {
    public var X: Int
    public var Y: Int

    public init() {
        self.X = 0
        self.Y = 0
    }

    public init(_ x: Int, _ y: Int) {
        self.X = x
        self.Y = y
    }

    public init(x: Int, y: Int) {
        self.X = x
        self.Y = y
    }
}
