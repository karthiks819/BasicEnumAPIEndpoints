//
//  EnumAPI.swift
//  EnumAPIHeaders
//
//  Created by Karthik on 04/06/21.
//

import Foundation
let SERVER_URL = "baseURL"


enum Users {
    case get(id: Int)
    case all(sort: UserSort, limit: Int, last_id: Int?)
    
    
    var httpMethod: String {
        get {
            return "get"
        }
    }
    // The endpoint for this User
    func endpoint() -> String {
        let base = "\(SERVER_URL)/api/users";
        
        switch self {
        case .get(let id):
            return "\(base)/\(id)"
        case .all(_, _, _):
            return "\(base)/all"
        }
    }
    
    // The URL for this Endpoint
    func url() -> URL {
        switch self {
        case .get(_):
            return URL(string: self.endpoint())!
        case .all(let sort, let limit, let last_id):
            var components = URLComponents(string: self.endpoint())!
            
            var queryItems: [URLQueryItem] = []
            queryItems.append(contentsOf: sort.queryItems)
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"));
            
            if let id = last_id {
                queryItems.append(URLQueryItem(name: "last_id", value: "\(id)"));
            }
            
            components.queryItems = queryItems
            
            return components.url!
        }
    }
    var request: URLRequest {
        get {
            var request = URLRequest(url: self.url())
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpMethod = self.httpMethod
            return request
        }
    }
}



enum UserSort {
    case newest(Order)
    case alpha(Order)
    
    // The name of this Sort method.
    var name: String {
        get {
            switch self{
            case .newest(_): return "newest"
            case .alpha(_): return "alpha"
            }
        }
    }
    
    // The Order for this sort method.
    var order: Order {
        get {
            switch self{
            case .newest(let order): return order
            case .alpha(let order): return order
            }
        }
    }
    
    // The Qcomponents.urluery Items for this sort method.
    var queryItems: [URLQueryItem] {
        get {
            return [URLQueryItem(name: "sort", value: "\(self.name)"),
                    URLQueryItem(name: "order", value: "\(self.order)")]
        }
    }
}

enum Order: String {
    case desc
    case asc
}


//MARK:- refer:- https://medium.com/swlh/modeling-rest-endpoints-with-enums-in-swift-18965f30ee94
//MARK:- Posts Enum


enum Posts {
    case get(id: Int)
    case delete(id: Int)
    case all(sort: PostSort, limit: Int, last_id: Int?)
    
    
    var httpMethod: String {
        get {
            switch self {
            case .delete: return "delete"
            default: return "get"
            }
        }
    }
    
    var request: URLRequest {
        get {
            var request = URLRequest(url: self.getURL())
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpMethod = self.httpMethod
            return request
        }
    }
    // The endpoint for this post.
    func endpoint() -> String {
        let base = "\(SERVER_URL)/api/posts";
        
        switch self {
        case .get(let id):
            return "\(base)/\(id)"
        case .delete(let id):
            return "\(base)/\(id)"
        case .all(_, _, _):
            return "\(base)/all"
        }
    }
    
    func getURL() -> URL{
        switch self {
        case .get(_):
            return URL(string: self.endpoint())!
        case .delete(_):
            return URL(string: self.endpoint())!
        case .all(let sort, let limit, let last_id):
            var components = URLComponents(string: self.endpoint())!
            
            var queryItems: [URLQueryItem] = []
            queryItems.append(contentsOf: sort.queryItems);
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"));
            
            if let id = last_id {
                queryItems.append(URLQueryItem(name: "last_id", value: "\(id )"));
            }
            
            components.queryItems = queryItems
            
            return components.url!
        }
    }
}

enum PostSort {
    case newest(Order)
    case likes(Order)
    
    var name: String {
        get {
            switch self{
            case .newest(_): return "newest"
            case .likes(_): return "likes"
            }
        }
    }
    
    var order: Order {
        get {
            switch self{
            case .newest(let order): return order
            case .likes(let order): return order
            }
        }
    }
    // The Query Items for this sort method.
    var queryItems: [URLQueryItem] {
        get {
            return [URLQueryItem(name: "sort", value: "\(self.name)"),
                    URLQueryItem(name: "order", value: "\(self.order)")]
        }
    }
}
