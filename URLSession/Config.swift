//
//  Config.swift
//  URLSession
//
//  Created by Dayeon Jung on 2021/07/09.
//

import Foundation


struct Config {
    static let baseURL = "https://jsonplaceholder.typicode.com/"
}

enum URLString {
    case posts
    case post(Int)
    case commentInPost(Int)
    case comments
    
    var value: String {
        var path = ""
        switch self {
        case .posts: path = "posts"
        case .post(let num): path = "posts/\(num)"
        case .commentInPost(let num): path = "posts/\(num)/comments"
        case .comments: path = "comments"
        }
        
        return Config.baseURL + path
    }
}


