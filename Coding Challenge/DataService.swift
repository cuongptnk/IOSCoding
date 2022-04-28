//
//  DataService.swift
//  Coding Challenge
//
//  Created by Wattpad Cuong on 2022-04-28.
//

import Foundation

class DataService {
    static let shared = DataService()
    
    func fetchStories() {
        var componentURL = URLComponents()
        componentURL.scheme = "https"
        componentURL.host = "www.wattpad.com"
        componentURL.path = "/api/v3/stories"
        componentURL.queryItems = [
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "fields", value: "stories(id,title,cover,user)"),
            URLQueryItem(name: "filter", value: "new")
        ]
        
        guard let dataURL = componentURL.url else {
            print("URL creation failed...")
            return
        }
        
        URLSession.shared.dataTask(with: dataURL) {
            (data, response, error) in
            guard let validData = data, error == nil else {
                print("API error \(error!.localizedDescription)")
                return
            }
            
            do {
                let dataWithPagination = try JSONDecoder().decode(DataWithPagination.self, from: validData)
                for story in dataWithPagination.stories {
                    print("\(story)\n")
                }
                print(dataWithPagination.nextUrl)
            } catch let serializationError {
                print("Fail to decode")
                print(serializationError.localizedDescription)
            }
        }.resume()
    }
}