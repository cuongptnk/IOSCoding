//
//  URLProvider.swift
//  
//
//  Created by Saim Zahid on 2022-05-19.
//

import Foundation

fileprivate struct Constants {
    static let baseURL = "www.wattpad.com"
    static let https = "https"
    static let version3 = "v3"
    static var stories: String {
        return "/api/\(Constants.version3)/stories"
    }
    
    static var users: String {
        return "/api/\(Constants.version3)/users"
    }
    
    static func user(witID id: Int) -> String {
        return "/api/\(Constants.version3)/users/\(id)"
    }
}

fileprivate struct Params {
    static let zero = "0"
    static let id = "id"
}

/// https://www.wattpad.com/api/v3/stories?id=1
struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem]
    
    var url: URL? {
        var componentURL = URLComponents()
        componentURL.scheme = Constants.https
        componentURL.host = Constants.baseURL
        componentURL.path = path
        componentURL.queryItems = queryItems
        
        return componentURL.url
    }
}

//protocol StoriesEndpoints {
//    func getStoriesEndpoint() -> Endpoint
//    func getStoryEndpoint(withID id: Int) -> Endpoint
//}



/// Stories
extension Endpoint {
    static func getStoriesEndpoint(withOffset offset: String = Params.zero,
                                   limit: String = "10",
                                   fields: String = "stories(\(Params.id),title,cover,user)",
                                   filter: String = "new") -> Endpoint {
        return Endpoint(path: Constants.stories, queryItems: [URLQueryItem(name: "offset", value: offset),
                                                              URLQueryItem(name: "limit", value: limit),
                                                              URLQueryItem(name: "fields", value: fields),
                                                              URLQueryItem(name: "filter", value: filter)])
    }
    
//    static func getStoryEndpoint(withID id: Int) -> Endpoint {
//
//    }
}

////Users
//extension Endpoint {
//    static func getUsersEndpoint() -> Endpoint {
//        
//    }
//    
//    static func getUserEndpoint(withID id: Int) -> Endpoint {
//        
//    }
//}
