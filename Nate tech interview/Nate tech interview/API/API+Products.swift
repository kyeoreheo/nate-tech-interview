//
//  API+Products.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import Alamofire

extension API {
    struct DataResponse: Decodable {
        let data: Data
    }
    
    struct Data : Decodable {
        let products: [ProductResponse]
    }
    
    struct ProductResponse: Decodable {
        let id: String
        let title: String
        let images: [String]
        let url: String
        let merchant: String
        let createdAt: String
    }
    
    static func getProducts(completion: @escaping(DataResponse?) -> Void) {
        let url = API.baseURL
        
        let headers = [
            "Accept-Encoding": "gzip, deflate, br",
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Connection": "keep-alive",
            "DNT": "1"
        ]
        
        let body = ["query" : "{\n  products {\n    id\n    title\n    images\n    url\n    merchant\n  createdAt}\n}"]

        Alamofire.request(url, method: .get, parameters: body, headers: headers)
        .responseData { response in
            let decoder = JSONDecoder()
            switch response.result {
            case .success(let data):
                do {
                    let result = try decoder.decode(DataResponse.self, from: data)
                    completion(result)
                } catch {
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    
}
