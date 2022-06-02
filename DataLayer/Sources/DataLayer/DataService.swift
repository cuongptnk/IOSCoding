//
//  DataService.swift
//  Coding Challenge
//
//  Created by Wattpad Cuong on 2022-04-28.
//

import Foundation

/**
 Result<TYPE, Error>
 to acces type write .success(TYPE)
 to acces erro write .failure(error)
 */

public enum NetworkError: Error {
    case invalidURL
    case invalidData
    case errorEncountered(error: Error)
}

public protocol APIProviderInterface {
    func fetchStories() async -> Result<[Story], NetworkError>
    func fetchUsers() async
}

public class DataService: APIProviderInterface {
    public static let shared = DataService()
    
    public func fetchStories() async -> Result<[Story], NetworkError> {
        let url = Endpoint.getStoriesEndpoint().url
        
        guard let dataURL = url else {
            return .failure(.invalidURL)
        }
        
        do {
            let result = try await getRequest(withURL: dataURL)
            
            switch result {
            case .success(let data):
                let dataWithPagination = try JSONDecoder().decode(DataWithPagination.self, from: data)
                
                for story in dataWithPagination.stories {
                    print(story)
                }
                
                return .success(dataWithPagination.stories)
            case .failure(let error):
                return .failure(error)
            }
        } catch {
            return .failure(.errorEncountered(error: error))
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
    func getRequest(withURL url: URL) async throws -> Result<Data, NetworkError> {
        // change implementation in one place fro UrlSession to AlamoFire
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            return .success(data)
        } catch {
            return .failure(.errorEncountered(error: error))
        }
    }
}
