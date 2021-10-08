//
//  ResponseData.swift
//  URLSession
//
//  Created by Dayeon Jung on 2021/07/09.
//

import Foundation

struct UserData: Codable {
    let userID: Int
    let id: Int
    let title: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id
        case title
        case body
    }
    
}


struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
//    let body: String
}

