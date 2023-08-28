//
//  WebAPI.swift
//  Workday
//
//  Created by Harish Garg on 27/08/23.
//

import Foundation

extension WebAPI {
    enum HttpMethod: String {
        case get
        case post
        case put
        case patch
        case delete
    }
}

class WebAPI {
    
    var requestHttpHeaders: [String:String] = [:]

    //MARK: - Prepare URL REQUEST
    private func prepareRequest(withURL url: String, params: [String:Any], httpMethod: HttpMethod, specialPUTParams: String? = nil, specialGETParams: String? = nil) -> URLRequest? {
        
        guard let url = URL(string: url) else { return nil }
        var urlRequest = URLRequest(url: url) // initialize with url
        urlRequest.httpMethod = httpMethod.rawValue // set http method
        
        /*set http body*/
        switch httpMethod {
        case .post, .put, .delete:
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            
            if let params = specialPUTParams {
                let newParams = "\(params)"
                let urlString = urlRequest.url!.absoluteString + newParams
                urlRequest.url = URL(string: urlString)
            } else if let getParams = specialGETParams {
                let urlString = urlRequest.url!.absoluteString + getParams
                urlRequest.url = URL(string: urlString)
            }
        case .get:
            var queryParameters = "?"
            let sortedKeys = params.keys.sorted(by: { $0 < $1 })
            
            for k in sortedKeys {
                if let v = params[k] {
                    var stringValue = v as? String
                    stringValue = stringValue?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?.replacingOccurrences(of: ":", with: "%3A")
                    queryParameters += k + "=\(stringValue ?? v)"
                    queryParameters += "&"
                }
            }
            
            queryParameters.removeLast()
            
            var urlString = urlRequest.url!.absoluteString + queryParameters
            if let specialGETParams =  specialGETParams {
                urlString += params.isEmpty ? "?" : "&"
                urlString += specialGETParams
            }
            urlRequest.url = URL(string: urlString)
        default:
            break
        }
        
        /*set authorization header*/
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        for (header, value) in requestHttpHeaders {
            urlRequest.setValue(value, forHTTPHeaderField: header)
        }

        return urlRequest
    }
}


extension WebAPI{
    
    enum NasaRequest
    {
        case searchImages
    }
    
    //MARK: - Create Nasa's Request
    public func createNasaRequest(params: [String:Any] = [:], type : NasaRequest, specialPUTParams: String? = nil, specialGETParams: String? = nil) -> URLRequest? {
        
        var requestURL : String?
        var httpMethod : HttpMethod = .post
        
        switch type {
        case .searchImages:
            requestURL = RequestUrl.searchImages.url
            httpMethod = .get
        }
        
        guard let request = self.prepareRequest(withURL: requestURL!, params: params, httpMethod: httpMethod, specialPUTParams: specialPUTParams, specialGETParams: specialGETParams) else {
            return nil
        }

        return request
    }
}
