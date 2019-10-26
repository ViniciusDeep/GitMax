//
//  Providey.swift
//  ios-recruitment
//
//  Created by Vinicius Mangueira on 16/10/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//

import Foundation

public struct Providey<T: Decodable> {
    func request(router: ProvideyRouter, withMethod method: ProvideyMethod, params: [String : Any]?, completion: @escaping (Result<T, Error>) -> () ) {
        method.request(router: router, params: params) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let refund = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {completion(.success(refund))}
                } catch {
                    DispatchQueue.main.async {completion(.failure(error))}
                }
            }
        }
    }
}

public enum ProvideyMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

extension ProvideyMethod {
    public func request(router: ProvideyRouter, params: [String: Any]?, completion: @escaping (Result<Data, Error>)-> ()) {
        guard let url = URL(string: router.endpoint) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = rawValue
        
        do {
        
            if let dicParams = params {
                let data = try JSONSerialization.data(withJSONObject: dicParams, options: .init())
                urlRequest.httpBody = data
                urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            }
            
           URLSession.shared.dataTask(with: urlRequest) { (data, _, err) in
                if let error = err { completion(.failure(error))}
                guard let data = data else {return print("Does not load data")}
                completion(.success(data))
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
}

public enum ProvideyRouter: ProvideyEndpoint {
    
    var basePath: String {
        return "https://api.github.com/"
    }
    case users
    case searchUser(_ : String)
    
    case completedUser(_ : String)
    
    public var endpoint: String{
        switch self {
        case .users:
            return "\(basePath)users"
        case .searchUser(let userName):
            return "\(basePath)users/\(userName)"
        case .completedUser(let completedUrl):
            return completedUrl
        }
    }
}

public protocol ProvideyEndpoint{
    var endpoint: String{get}
}

