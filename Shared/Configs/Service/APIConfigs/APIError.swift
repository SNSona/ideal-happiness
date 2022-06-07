//
//  APIError.swift
//  GlowingCollage (iOS)
//
//  Created by Sona Sargsyan on 05.06.22.
//

import Foundation

// MARK: - APIErrorHandel

enum APIError: Swift.Error {
    case network(URLError)
    case decoding(Error)
}

extension APIError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .network(let error):
            return "Netwok error \(error.localizedDescription)"
        case .decoding(let error):
            return "Decoding error \(error.localizedDescription)"
        }
    }
}
