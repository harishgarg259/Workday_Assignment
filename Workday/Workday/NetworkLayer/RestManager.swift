//
//  RestManager.swift
//  Workday
//
//  Created by Harish Garg on 26/08/23.
//

import Foundation

enum Result<T: Codable> {
    case success(T)
    case failure(WebError)
}

class RestManager<T: Codable> {
    
    // MARK: - Properties
    var requestHttpHeaders: [String:String] = [:]
    var response: [String:Any] = [:]
    
    // MARK: - Public Methods
    func makeRequest(request : URLRequest, completion: @escaping (_ result: Result<T>) -> Void) {

        var urlRequest = request
      
        DispatchQueue.global(qos: .background).async {
            
            /*HTTP REQUEST*/
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let response = response as? HTTPURLResponse else {
                        if (error?.localizedDescription) != nil {
                            completion(.failure(.other(error?.localizedDescription ?? "")))
                            return
                        }
                        completion(.failure(.networkLost))
                        return
                    }
                    
                    /*RESPONSE*/
                    /***********************************************/
                    var statusCode : Int = response.statusCode
                    if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)  {
                        print("response: \(json)")
                        print("URL: \(request.url?.absoluteString ?? "")")
                        if let result = json as? [String:Any] {
                            self.response = result
                        }
                    } else {
                        if let responseData = data
                        {
                            let str = String(decoding: responseData, as: UTF8.self)
                            print(str)
                        }
                    }
                    
                    switch statusCode  {
                    case (200..<300):
                        guard let model = Response<T>().parceModel(data: data) else {
                            completion(.failure(WebError.parse))
                            return
                        }
                        completion(.success(model))
                    case (300...600):
                        guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {
                            completion(.failure(.other((error?.localizedDescription) ?? "Internal server error")))
                            return
                        }
                        let message = json["reason"] as? String ?? WebError.unauthorized.description
                        completion(.failure(.other(message)))
                    default:
                        break
                    }
                }
            }
            task.resume()
        }
    }
}


// MARK: - RestManager Parce Model
extension RestManager {
    
    fileprivate struct Response<T: Codable> {
        
        func parceModel(data: Data?) -> T? {
            guard let data = data else {
                return nil
            }
            let mappedData = try? JSONDecoder().decode(T.self, from: data)
            return mappedData
        }
    }
}
