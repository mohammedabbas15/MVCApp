//
//  NetworkManager.swift
//  MVCApp
//
//  Created by iAskedYou2nd on 6/30/21.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
}

extension NetworkManager {
    
    func getPage(urlStr: String, completion: @escaping (Result<PageResult, Error>) -> Void) {
        
        guard let url = URL(string: urlStr) else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        self.session.dataTask(with: url) { (data, response, error) in
            // This is now in a background thread
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.badData))
                return
            }
            
            do {
                let page = try JSONDecoder().decode(PageResult.self, from: data)
                completion(.success(page))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
        
        
    }
    
    
    func getRawData(urlStr: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: urlStr) else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        self.session.dataTask(with: url) { (data, response, error) in
            // This is now in a background thread
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.badData))
                return
            }
            
            completion(.success(data))
            
        }.resume()
        
        
    }
    
    
}


