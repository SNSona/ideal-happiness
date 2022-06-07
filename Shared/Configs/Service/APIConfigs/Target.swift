//
//  Target.swift
//  GelatoTaskSwift
//
//  Created by Sona Sargsyan on 02.06.22.
//

import Foundation

enum Target: String, Codable, CaseIterable {
    case production
    case development
    
    static var current: Target = APIService.target
    
    var title: String {
        self.rawValue
    }
    
    var host: String {
        switch self {
        case .production: return "https://picsum.photos"
        case .development: return "https://picsum.photos"
        }
    }
    
    func url(_ endPoint: EndPoint) -> String {
        host + endPoint.rawValue
    }
    
    init() {
        #if PRODUCTION
        self = .production
        #else
        self = .development
        #endif
    }
}

enum EndPoint: String {
    case imageList = "/v2/list"
    case image = "/id"
}
