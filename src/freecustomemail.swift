import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URLSession {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: URLError(.unknown))
                }
            }
            task.resume()
        }
    }
}


public class Freecustomemail {
    private let api = "https://www.freecustom.email/api"
    private var headers: [String: String]
    
    public init() {
        self.headers = [
        "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
        "Host":"www.freecustom.email",
        "Connection":"keep-alive",
        "Accept-Encoding":"deflate, zstd",
        "Accept-Language":"en-US,en;q=0.9",
        "User-Agent":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36"
        ]

    }

    public func auth() async throws -> Any {
        guard let url = URL(string: "\(api)/auth") else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: [:], options: [])
    
        let (data, _) = try await URLSession.shared.data(for: request)
        let json = try JSONSerialization.jsonObject(with: data)
    
        if let dict = json as? [String: Any],
           let token = dict["token"] as? String {
            headers["Authorization"] = "Bearer \(token)"
        }
    
        return json
    }

    public func create_email(email: String) async throws -> Any {
        guard let url = URL(string: "\(api)/ws-ticket") else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = ["mailbox": email]
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
    
        let (data, _) = try await URLSession.shared.data(for: request)
        let json = try JSONSerialization.jsonObject(with: data)
    
        if let dict = json as? [String: Any],
           let token = dict["token"] as? String {
            headers["Authorization"] = "Bearer \(token)"
        }
    
        return json
    }

    public func get_domains() async throws -> Any {
        guard let url = URL(string: "\(api)/domains") else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        headers["x-fce-client"] = "web-client"
        request.allHTTPHeaderFields = headers
        let (data, _) = try await URLSession.shared.data(for: request)
        let json =  try JSONSerialization.jsonObject(with: data)
        return json
    }
    
    public func get_messages(email: String) async throws -> Any {
        guard let url = URL(string: "\(api)/public-mailbox?fullMailboxId=\(email)") else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        headers["x-fce-client"] = "web-client"
        request.allHTTPHeaderFields = headers
        let (data, _) = try await URLSession.shared.data(for: request)
        return  try JSONSerialization.jsonObject(with: data)
    }
    
    public func get_stats() async throws -> Any {
        guard let url = URL(string: "\(api)/stats") else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        headers["x-fce-client"] = "web-client"
        request.allHTTPHeaderFields = headers
        let (data, _) = try await URLSession.shared.data(for: request)
        return  try JSONSerialization.jsonObject(with: data)
    }
    
    public func get_message_by_id(email: String,message_id: String) async throws -> Any {
        guard let url = URL(string: "\(api)/public-mailbox?fullMailboxId=\(email)&messageId=\(message_id)") else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        headers["x-fce-client"] = "web-client"
        request.allHTTPHeaderFields = headers
        let (data, _) = try await URLSession.shared.data(for: request)
        return  try JSONSerialization.jsonObject(with: data)
    }
}
