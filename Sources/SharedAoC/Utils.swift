import Foundation

public func quicksort<T: Comparable>(_ a: [T]) -> [T] {
    var array = a
    quicksortInPlace(&array, low: 0, high: array.count - 1)
    return array
}

private func quicksortInPlace<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let pivotIndex = partition(&a, low: low, high: high)
        quicksortInPlace(&a, low: low, high: pivotIndex - 1)
        quicksortInPlace(&a, low: pivotIndex + 1, high: high)
    }
}

private func partition<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let pivot = a[high]
    var i = low - 1
    for j in low..<high {
        if a[j] < pivot {
            i += 1
            a.swapAt(i, j)
        }
    }
    a.swapAt(i + 1, high)
    return i + 1
}
