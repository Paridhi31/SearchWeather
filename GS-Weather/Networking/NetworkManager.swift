//
//  NetworkManager.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 02/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import Foundation

class NetworkManager: NetworkManagerProtocol {
    
    typealias T = BaseRequestProtocol
    
    let session = URLSession.shared
    
    func enqueueRequest<T>(_ request: T) where T : BaseRequestProtocol {
        
        let finalURLRequest = prepareRequestWithMethod(request.method, url: request.url ?? "", endpoint: request.endPoint ?? "", parameters: request.parameters, headers: nil)
        
        session.dataTask(with: finalURLRequest) { (data, response, error) in
            guard let _ = data, error == nil else {
                request.jsonErrorBlock?(error.debugDescription)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    
                    let responseErrorCode = response as? HTTPURLResponse
                    var errorCode: GSErrorCodes?
                                        
                    switch responseErrorCode?.statusCode {
                    case 404:
                        errorCode = GSErrorCodes.GSFileNotFoundErrorCode
                    case 500:
                        errorCode = GSErrorCodes.GSInternalServerErrorCode
                    case 401:
                        errorCode = GSErrorCodes.GSAuthorizationErrorCode
                    case .none:
                        break
                    case .some(_):
                        errorCode = GSErrorCodes.GSUnknownError
                    }
                    request.jsonErrorBlock?(errorCode?.errorDescription())
                    return
            }
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            print(json as Any)

            request.jsonParserBlock?(data)
            
        }.resume()
    }
    
    func prepareRequestWithMethod(_ method: String?, url: String, endpoint: String, parameters: [AnyHashable: Any]?, headers:[AnyHashable: Any]?) -> URLRequest {
        let urlString: String = url + endpoint
        let urlStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let finalURL: URL = URL(string: urlStr!)!
        return URLRequest.init(url: finalURL)
    }
}
