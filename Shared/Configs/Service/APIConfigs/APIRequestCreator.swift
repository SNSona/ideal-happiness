//
//  APIRequestBuilder.swift
//  GlowingCollage (iOS)
//
//  Created by Sona Sargsyan on 05.06.22.
//

import Foundation

// MARK: - URLResqueestApplay

public enum NetworkMethod: Equatable {
    case get
    case put(Data?)
    case post(Data?)
    
    var name: String {
        switch self {
        case .get: return "GET"
        case .put: return "PUT"
        case .post: return "POST"
        }
    }
}

public typealias Parameters = [String: Any]

public protocol APIRequestCreator {
    
    var baseURL: URL { get }
    var path: String { get }
    var method: NetworkMethod { get }
    
    func urlRequest() -> URLRequest
    func sampleData() -> Data?
    func parameters() -> Parameters?
    func headers() -> [String: String]?
}

extension APIRequestCreator {
    
    var baseURL: URL {
        guard let url = URL(string: Target.current.host) else {
            fatalError("Unable to configure base url")
        }
        return url
    }
    
    func sampleData() -> Data? {
        return Data()
    }
    
    func urlRequest() -> URLRequest {
        var request = URLRequest(url: baseURL)
        
        switch method {
        case .post(let data), .put(let data):
            request.httpBody = data
        case .get:
            let url = baseURL.appendingPathComponent(path)
            request = URLRequest(url: url)
        }
        
        request.allHTTPHeaderFields = headers()
        request.httpMethod = method.name
        return request
    }
    
    func parameters() -> Parameters? {
        return nil
    }
    
    func headers() -> [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
