//
//  Resource.swift
//  URLSession
//
//  Created by Dayeon Jung on 2021/07/09.
//

import Foundation

struct Resource<T> {
    var urlRequest: URLRequest?
    let parse: (Data) -> T?
}

extension Resource where T: Decodable {

    // Get Method + Parameters
    init(url: URLString, parameters: [String: String]? = nil) {
        
        var component = URLComponents(string: url.value)
        if let param = parameters, !param.isEmpty {
            var items = [URLQueryItem]()
            for (name, value) in param {
                if name.isEmpty { continue }
                items.append(URLQueryItem(name: name, value: value))
            }
            component?.queryItems = items
        }
        
        
        if let componentURL = component?.url {
            self.urlRequest = URLRequest(url: componentURL)
        } else if let stringURL = URL(string: url.value) {
            self.urlRequest = URLRequest(url: stringURL)
        }
        
        self.parse = { data in
            try? JSONDecoder().decode(T.self, from: data)
        }
    }
    
    // Get Method 이외에 Body와 함께 전달하는 Method
    init<Body: Encodable>(url: URLString, method: HTTPMethod<Body>) {
        guard let url = URL(string: url.value) else {
            self.urlRequest = nil
            self.parse = { _ in nil }
            return
        }
        
        self.urlRequest = URLRequest(url: url)
        self.urlRequest?.httpMethod = method.method

        switch method {
        case .post(let body), .delete(let body), .patch(let body), .put(let body):
            self.urlRequest?.httpBody = try? JSONEncoder().encode(body)
            self.urlRequest?.addValue("application/json", forHTTPHeaderField: "Content-Type")
            self.urlRequest?.addValue("application/json", forHTTPHeaderField: "Accept")
        default: break
        }
        
        self.parse = { data in
            try? JSONDecoder().decode(T.self, from: data)
        }
    }
    
}


/*
 
 // request parameter를 클래스/구조체 타입으로 넣어주고 싶을 때
 
 // 업로드할 모델(형태)
 struct UploadData: Codable {
     let name: String
     let job: String
 }
 
 // 실제 업로드할 (데이터)인스턴스 생성
 let uploadDataModel = UploadData(name: "Nicole", job: "iOS Developer")
 
 // 모델을 JSON data 형태로 변환
 guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
     print("Error: Trying to convert model to JSON data")
     return
 }
 
 // URL요청 생성
 var request = URLRequest(url: url)
 request.httpMethod = "PUT"
 request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 request.httpBody = jsonData

 */
