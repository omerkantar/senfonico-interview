//
//  ServiceManager.swift
//  senfonico
//
//  Created by omer kantar on 22.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

// MARK: - Eger external library kullanabilseydim Network layer icin Moya/Alamofire frameworkleri kullanacaktim
//

typealias NetworkSuccessBlock = (_ response: ResponseModel) -> Void
typealias NetworkFailureBlock  = (_ error: Error?, _ response: ResponseModel?) -> Void

class ServiceManager: NSObject {

    static func request(target: APITarget, success: NetworkSuccessBlock?, failure: NetworkFailureBlock?) {
        
        guard let urlRequest = target.urlRequest else {
            if let failure = failure {
                failure(nil, nil)
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                if let failure = failure {
                    failure(error, nil)
                }
                return
            }
            
            guard let data = data else {
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            
            let model = ResponseModel(json: [String: Any]())
            if let httpResponse = response as? HTTPURLResponse {
                model.httpResponse = httpResponse
                model.statusCode = httpResponse.statusCode
            }
            
            if let object = json as? [String: Any] {
                model.mapping(json: object)
            } else if json is Array<Any> {
                model.object = json
            }
            
            if model.statusCode >= 400 ||
                model.isSuccess == false {
                if let failure = failure {
                    failure(nil, model)
                }
            } else if let success = success {
                success(model)
            }
        }
        
        task.resume()

    }
}
