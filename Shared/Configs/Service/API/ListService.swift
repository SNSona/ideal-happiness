//
//  ListService.swift
//  GlowingCollage (iOS)
//
//  Created by Sona Sargsyan on 04.06.22.
//

import Foundation
import Combine

// MARK: - ListService

typealias listPublisher = AnyPublisher< [ImageData], APIError>

protocol ListService: CancelableStore {
    var request: ListRequest<ImageList> { get set }
    func loadImages() -> AnyPublisher< [ImageData], APIError>
}

// MARK: - ListServiceImpl

final class ListServiceImpl: ListService {
    
    static let shared: ListServiceImpl = .init()
    
    private init() {}
    
    var request: ListRequest<ImageList> = ListRequest()
    
    private var listClient: APIService {
        return APIService()
    }
    
    func loadImages() -> AnyPublisher< [ImageData], APIError> {
        return listClient.publisher(for: request, decoder: newJSONDecoder())
    }
}

// MARK: - ListServiceRequest

struct ListRequest<T: Decodable>: APIRequestCreator {
    
    var perPage = 0
    var limitCount = 20
    var method: NetworkMethod { .get }
    var path: String { EndPoint.imageList.rawValue }
    
    func urlRequest() -> URLRequest {
        var request = URLRequest(url: baseURL)
        
        switch method {
            
        case .post(let data), .put(let data):
            request.httpBody = data
            
        case .get:
            let url = baseURL.appendingPathComponent(path)
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = [
                URLQueryItem(name: "page", value: "\(perPage)"),
                URLQueryItem(name: "limit", value: "\(limitCount)")
            ]
            guard let url = components?.url else { preconditionFailure("Invalid URL format...") }
            request = URLRequest(url: url)
        }
        
        request.allHTTPHeaderFields = headers()
        request.httpMethod = method.name
        return request
    }
    
    func headers() -> [String : String]? { ["User-Agent" : "iPhone"] }
}
