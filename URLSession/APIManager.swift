//
//  APIManager.swift
//  URLSession
//
//  Created by Dayeon Jung on 2021/07/09.
//

import Foundation

class API {
    enum APIError: LocalizedError {
        case urlNotSupport
        case noData(String?)
        case unknown(String?)

        var errorDescription: String? {
            switch self {
            case .urlNotSupport: return "URL not supported"
            case .noData(let message): return "has no data" + (message ?? "")
            case .unknown(let message): return "unknown error occured. " + (message ?? "")
            }
        }
    }
    
    static let shared: API = API()
    
    private lazy var session = URLSession(configuration: .default)
    
    private init() { }

    func load<T>(resource: Resource<T>,
                      completionHandler: @escaping (Result<T, APIError>) -> Void) {
        
        guard let _ = resource.urlRequest?.url else {
            completionHandler(.failure(.urlNotSupport))
            return
        }
        
        session.load(resource) { parsed, error in
            guard let parsed = parsed else { completionHandler(.failure(.noData(error)))
                return
            }
            
            completionHandler(.success(parsed))
        }
    }
    
    func delete<T>(resource: Resource<T>,
                   completionHandler: @escaping (Result<T?, APIError>) -> Void) {
        
        guard let _ = resource.urlRequest?.url else {
            completionHandler(.failure(.urlNotSupport))
            return
        }
        
        session.load(resource) { data, error in
            if let error = error, !error.isEmpty {
                completionHandler(.failure(.noData(error)))
            } else {
                completionHandler(.success(data))
            }
        }
        
    }
    
    // Data 원형이 필요
    func getData(from url: URL, completionHandler: @escaping (Result<Data?, APIError>) -> ()) {
        session.loadData(from: url) { data, error in
            if let error = error {
                completionHandler(.failure(.unknown(error.description)))
                return
            }
            
            completionHandler(.success(data))
        }
    }

}
