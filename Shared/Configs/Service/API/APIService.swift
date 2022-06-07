//
//  APIService.swift
//  GlowingCollage (iOS)
//
//  Created by Sona Sargsyan on 05.06.22.
//

import Foundation
import Combine

// MARK: - APIGenericRequest

protocol APIProtocol {
    func publisher<T: Decodable>(for request: APIRequestCreator,
                                 decoder: JSONDecoder) -> AnyPublisher<T, APIError>
}

struct APIService: APIProtocol {
    
    typealias ID = UUID
    
    enum Model {}
    
    static let target = Target()
    
    func publisher<T>(for request: APIRequestCreator, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, APIError> where T : Decodable {
        URLSession.shared.dataTaskPublisher(for: request.urlRequest())
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .mapError(APIError.network)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .mapError(APIError.decoding)
            .eraseToAnyPublisher()
    }
}
