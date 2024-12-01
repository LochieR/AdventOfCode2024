import Foundation
import FoundationNetworking

public enum NetworkResult<TResult> {
    case Success(result: TResult)
    case Error(string: String)
}

public class Network {

    private static let _sessionCookie: String = getSession()

    public static func downloadInput(year: Int, day: Int) -> NetworkResult<String> {
        if _sessionCookie.isEmpty {
            return .Error(string: "Invalid session. Please refer to user/README.md on how to create a valid session.cookie file")
        }

        let urlString = "https://adventofcode.com/\(year)/day/\(day)/input"
        
        guard let url = URL(string: urlString) else {
            return .Error(string: "Invalid URL")
        }

        var request = URLRequest(url: url)
        request.addValue("session=\(_sessionCookie)", forHTTPHeaderField: "Cookie")

        let semaphore = DispatchSemaphore(value: 0)

        var sessionResult: NetworkResult<String> = .Error(string: "No data set")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                sessionResult = .Error(string: error.localizedDescription)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                sessionResult = .Error(string: "Server error or invalid response")
                return
            }

            guard let data = data else {
                sessionResult = .Error(string: "No data received from response")
                return
            }

            let result = String(decoding: data, as: UTF8.self)

            if result.isEmpty {
                sessionResult = .Error(string: "Empty result")
                return
            }

            sessionResult = .Success(result: result)

            semaphore.signal()
        }

        task.resume()
        _ = semaphore.wait(timeout: .distantFuture)

        return sessionResult
    }

    private static func getSession() -> String {
        do {
            let sessionString = try String(contentsOf: URL(filePath: "user/session.cookie"), encoding: .utf8)

            return sessionString.trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            print("Error reading session.cookie file: \(error)")
        }

        return ""
    }

}
