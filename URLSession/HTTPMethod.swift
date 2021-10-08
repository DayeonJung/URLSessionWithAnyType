//
//  HTTPMethod.swift
//  URLSession
//
//  Created by Dayeon Jung on 2021/07/09.
//

import Foundation

enum HTTPMethod<Body> {
    case get
    case post(Body)
    case put(Body)
    case patch(Body)
    case delete(Body)
    
}

extension HTTPMethod {
    var method: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .patch: return "PATCH"
        case .delete: return "DELETE"
        }
    }
}
