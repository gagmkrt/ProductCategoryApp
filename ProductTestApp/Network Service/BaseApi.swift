//
//  BaseApi.swift
//  ProductTestApp
//
//  Created by Gago Mkrtchyan on 26.10.21.
//

import Foundation

class BaseApi {
    
    func executeRequest(with params: Dictionary<String, Any>?,
                        requestType: String,
                        headers: Dictionary<String, Any>?,
                        urlString: String,
                        completion:@escaping ([String: Any]?, Error?)->Void) {
        
            
        var request = URLRequest(url: URL(string: urlString) ?? URL(fileURLWithPath: ""))
        request.httpMethod = requestType
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("ios", forHTTPHeaderField: "platform")
        
        if let headers = headers {
            for key in headers.keys {
                request.setValue(headers[key] as? String ?? "", forHTTPHeaderField: key)
            }
        }
       
        
        if let params = params {
            if let data = try? JSONSerialization.data(withJSONObject: params, options: .fragmentsAllowed) {
                request.httpBody = data
            }
        }
        
        request.timeoutInterval = 60
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, responce, error) in
            DispatchQueue.main.async {

                if error != nil {
                    completion(nil, error)
                    return
                }
                
                guard let data = data else {
                    completion(nil, self.error())
                    return
                }
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] {
                    if let response = responce as? HTTPURLResponse {
                        let statusCode: Int = response.statusCode
                        
                        if statusCode >= 200 && statusCode <= 300 {
                            completion(json, nil)
                        }
                        else {
                            let message = json["message"] as? String
                            let aaa = self.error(message: message)
                            completion(nil, aaa)
                        }
                    }
                } else {
                    completion(nil, self.error())
                }
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }

    
    func executeArrayRequest(with params: Dictionary<String, Any>?,
                        requestType: String,
                        headers: Dictionary<String, Any>?,
                        urlString: String,
                        completion:@escaping ([[String: Any]]?, Error?)->Void) {
        
            
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = requestType
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("ios", forHTTPHeaderField: "platform")
        
        if let headers = headers {
            for key in headers.keys {
                request.setValue(headers[key] as? String ?? "", forHTTPHeaderField: key)
            }
        }
       
        
        if let params = params {
            if let data = try? JSONSerialization.data(withJSONObject: params, options: .fragmentsAllowed) {
                request.httpBody = data
            }
        }
        
        request.timeoutInterval = 60
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, responce, error) in
            
            DispatchQueue.main.async {
                
                if error == nil {
                    if let responce = responce as? HTTPURLResponse, responce.statusCode >= 200 || responce.statusCode <= 300 {
                        if let data = data  {
                            
                            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]] {
                                completion(json, nil)
                            } else {
                                print("JSONSerialization failure")
                            }
                        } else {
                            completion(nil, nil)
                        }
                    } else {
                        completion(nil, nil)
                    }
                } else {
                    completion(nil,error)
                }
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
   // Custom ERROR
    func error(message: String? = nil ) -> Error? {
        var errorDescription: String = "valodik error"
        if let message = message {
            errorDescription =  message
        }
        return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorDescription])
    }
}
