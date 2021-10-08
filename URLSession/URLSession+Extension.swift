//
//  URLSession+Extension.swift
//  URLSession
//
//  Created by Dayeon Jung on 2021/07/09.
//

import Foundation

extension URLSession {
    func load<T>(_ resource: Resource<T>, completion: @escaping (T?, String?) -> Void) {
        dataTask(with: resource.urlRequest!) { data, response, error in
            if let response = response as? HTTPURLResponse,
                (200..<300).contains(response.statusCode) {
                if let safeData = data,
                   let parsedData = resource.parse(safeData) {
                    completion(parsedData, nil)
                } else {
                    completion(nil, "failed parsing")
                }
                
            } else {
                completion(nil, error?.localizedDescription)
            }
        }.resume()
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, String?) -> ()) {
        dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse,
                (200..<300).contains(response.statusCode) {
                completion(data, nil)
            } else {
                completion(nil, error?.localizedDescription)
            }
        }.resume()
    }
}
