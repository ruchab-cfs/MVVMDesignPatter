//
//  APIManager.swift
//  MVVMDesignPatter
//
//  Created by apple on 13/11/24.
//

import UIKit

//MARK: Singleton Design Pattern
//final - there is no chance of inheritance (its final)
enum DataError: Error{
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

typealias Handler = (Result<[Product], DataError>) -> Void

final class APIManager{
    
    static let shared = APIManager()
    private init() {}
    
    func fetchProducts(completion: @escaping Handler){
        guard let url = URL(string: Constant.API.productURL) else {
            return
        }
        //Background task
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                return
            }
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                return
            }
            
            do {
                let Products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(Products))
                print(Products)
            }catch {
                completion(.failure(.network(error)))
            }
            
        }.resume()
        print("Ended")
    }
}

//class A {
//    
//    func configuration() {
//        let manager = APIManager()
//        manager.temp()
//        
//        //APIManager.temp()
//        APIManager.shared.temp()
//    }
//}

//singletone - object created by singletone class outside of the class

//Singletone - singletone class cha object create nahi honar outside of the class
