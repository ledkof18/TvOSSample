//
//  ApiService.swift
//  FeatureSet
//
//  Created by Luis Enrique Diaz Ramirez on 25/04/23.
//

import Foundation

protocol HTTPClientProtocol{
    func fetch<T: Codable>(url: URL) async throws -> T
    func fetch<T: Codable>(url: URL, completion:@escaping(_ response: T) -> ())
}

class ApiService: NSObject, HTTPClientProtocol{
    
    func fetch<T: Codable>(url: URL) async throws -> T{
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
            throw HTTPError.badResponse
        }
        
        guard let object = try? JSONDecoder().decode(T.self, from: data) else {
            throw HTTPError.errorDecodingData
        }
        return object
    }
    
    func fetch<T: Codable>(url: URL, completion:@escaping(_ response: T) -> ()){
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else{
                print("error downloading data, Code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                return
            }
            
            guard let object = try? JSONDecoder().decode(T.self, from: data) else {
                return
            }
            completion(object)
        }.resume()
    }
}

enum ServiceResponse<T>{
    case success(Any)
    case error(ErrorManager)
}

class ErrorManager{
    func processError() -> ErrorManager{
        return ErrorManager()
    }
}

enum HTTPError: Error{
    case badURL, badResponse, errorDecodingData
}
