import Foundation

public enum CodeResult<TResult> {
    case Success(result: TResult)
    case Error(string: String)

    public static func forward<T>(_ networkResult: NetworkResult<T>) -> CodeResult<TResult> {
        switch networkResult {
            case .Success(let result):
                return .Error(string: "Improperly handled result (tried to forward a successful result)")
            case .Error(let error):
                return .Error(string: "Network error: \(error)")
        }
    }
}

public protocol Day {
    init(input: String)
    
    func runP1() -> CodeResult<Int>
    func runP2() -> CodeResult<Int>
}
