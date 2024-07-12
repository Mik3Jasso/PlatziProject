//
//  Network.swift
//  PlatziProject
//
//  Created by Mike Jasso on 10/07/24.
//

import Foundation
import RealmSwift

class Network {
    
    let baseURL = "https://api.pexels.com/videos"
    let authToken = "0uRdtEt1OW33GuqX4IpTmp6sPLLoTcQYt043Zl3FTDqRh0qf4XNRcjFL"

    func fetchVideos(_ value: String) async throws -> Videos {
        guard let url = URL(string: "\(baseURL)/search?query=\(value)&per_page=10") else {
            throw HTTPRequestError.invalidURL
        }

        let videos: Videos = try await performGETRequest(url: url)
        return videos
    }
  
    func fetchPopularVideos() async throws -> Videos {
    
        guard let url = URL(string: "\(baseURL)/popular?per_page=10") else {
            throw HTTPRequestError.invalidURL
        }

        let videos: Videos = try await performGETRequest(url: url)
        return videos
    }
    
    func getVideo(_ id : String) async throws -> Video {
        guard let url = URL(string: "\(baseURL)/videos/\(id)") else {
            throw HTTPRequestError.invalidURL
        }

        let video: Video = try await performGETRequest(url: url)
        return video
    }
    
    private func performGETRequest<T>(url: URL) async throws -> T where T: Decodable {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("\(authToken)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPRequestError.invalidResponse
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw HTTPRequestError.requestFailed(statusCode: httpResponse.statusCode)
        }
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw HTTPRequestError.invalidData
        }
    }
}

enum HTTPRequestError: Error{
    case invalidURL 
    case invalidResponse
    case requestFailed(statusCode: Int)
    case invalidData
}
