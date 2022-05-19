//
//  DataService.swift
//  Coding Challenge
//
//  Created by Wattpad Cuong on 2022-04-28.
//

import Foundation

public protocol APIProviderInterface {
    func fetchStories() async
    func fetchUsers() async
}

public class DataService: APIProviderInterface {
    public static let shared = DataService()
    
    public func fetchStories() async {
        let url = Endpoint.getStoriesEndpoint().url
        
        guard let dataURL = url else {
            print("URL creation failed...")
            return
        }
        do {
            let dataWithPagination = try await getRequest(withURL: dataURL)
            for story in dataWithPagination.stories {
                print("\(story)\n")
            }
            print(dataWithPagination.nextUrl)
        } catch {
            print("Request failed with error: \(error)")
        }
        
        
//        URLSession.shared.dataTask(with: dataURL) {
//            (data, response, error) in
//            guard let validData = data, error == nil else {
//                print("API error \(error!.localizedDescription)")
//                return
//            }
//
//            do {
//                let dataWithPagination = try JSONDecoder().decode(DataWithPagination.self, from: validData)
//                for story in dataWithPagination.stories {
//                    print("\(story)\n")
//                }
//                print(dataWithPagination.nextUrl)
//            } catch let serializationError {
//                print("Fail to decode")
//                print(serializationError.localizedDescription)
//            }
//        }.resume()
        
        
    }
    
    public func fetchUsers() async {
        /// no -op
    }
}

extension DataService {
    func getRequest(withURL url: URL) async throws -> DataWithPagination {
        // chnage implementation in one place fro UrlSession to AlamoFire
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(DataWithPagination.self, from: data)
    }

    /// put,
}
