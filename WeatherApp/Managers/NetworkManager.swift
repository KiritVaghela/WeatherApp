//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 10/15/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

let keyStatus = "status"
let keyMessage = "message"
let keyDomain = "weatherApp"
let resultOK = 200

let httpGet = HTTPMethod.get
let httpPost = HTTPMethod.post

class NetworkManager {
    
    static let shared = NetworkManager()
    
    /// A closure executed when the request is success
    public typealias SuccessBlock = (_ successMessage:String) -> Void
    
    /// A clouse executed when the request is failed
    public typealias FailureBlock = (_ error:Error) -> Void

    // private initializer
    private init(){
        
    }
    
    private func httpRequestBuilder(urlString: String, requestMethod:HTTPMethod, params:[String:Any]) -> DataRequest {
        
        print("\(Date()) Url: \(urlString)")
        print("Params: \(params)")
        
        
        //add default params
        var newParams = params
        newParams["appid"] = WEATHER_API_KEY
        
        let httpRequest = Alamofire.request(urlString,
                                                 method: requestMethod,
                                                 parameters: newParams,
                                                 encoding: requestMethod == .get ? URLEncoding.default : JSONEncoding.default,
                                                 headers: nil)
        
        // log reponse string as object mapper failed to parsing response
        httpRequest.responseString { response in
            
            if !response.result.isSuccess || response.response?.statusCode != resultOK {
                print("Error : \(response.result.value ?? "" )")
            }else{
                print("Success : \(response.result.isSuccess)")
            }
            
            #if DEBUG
                print("Request URL : \(response.request!.url!)")
                print("\(Date())Success: \(response.result.isSuccess)")
                print("Response String: \(response.result.value ?? "no response")")
            #endif
        }
        
        return httpRequest
    }
    
    /// Make simple http request
    func makeSimpleRequest(requestMethod:HTTPMethod, forApi name:String, params:[String:Any], success:@escaping ([String:Any]?) -> Void, failure:@escaping (Error) -> Void )  {
        
        let apiUrl = BASE_URL + name
        
        let httpRequest = httpRequestBuilder(urlString: apiUrl, requestMethod: requestMethod, params: params)
        
        httpRequest.responseData { (dataResponse) in
            print("\(Date())Response is data")
            
            switch dataResponse.result {
                
            case .success(let data):
                
                if dataResponse.response?.statusCode == 200 {
                    success(NetworkManager.getJsonString(from: data))
                }else{
                    NetworkManager.parseFailureResponse(for: data, with: failure)
                }
                
            case .failure(let error):
                self.handleError(forRequest: httpRequest, error: error, with: dataResponse.data!, failure: failure)
            }
            
        }
    }
    
    /// Generic request for json object response
    func makeObjectRequest<T:BaseMappable>(forClass: T.Type, requestMethod: HTTPMethod, forApi name:String, params:[String:Any], success:@escaping (DataResponse<T>) -> Void, failure:@escaping (Error) -> Void )  {
        
        let apiUrl = BASE_URL + name
        
        let httpRequest = httpRequestBuilder(urlString: apiUrl,requestMethod: requestMethod,params: params)
        
        httpRequest.responseObject { (response:DataResponse<T>) in
            print("\(Date())Response: \(response)")
            
            switch response.result {
                
            case .success:
                success(response)
                
            case .failure(let error):
                self.handleError(forRequest: httpRequest, error: error, with: response.data!, failure: failure)
            }
        }
    }
    
    // this funcation will convert data into json object and parse data and create a error object and pass to the failure block
    static func parseFailureResponse(for data:Data, with failure:@escaping (Error) -> Void){
        if let json = getJsonString(from: data) {
            if let status = json[keyStatus] as? Int, let message = json[keyMessage] as? String {
                let error = NSError(domain: keyDomain, code: status , userInfo: [NSLocalizedDescriptionKey : message])
                failure(error)
            }
        } else {
            failure(NSError(domain: keyDomain, code: -1 , userInfo: [NSLocalizedDescriptionKey : "The server encountered a temporary error and could not complete your request"]))
        }
    }
    
    /// Convert response data in json object
    static func getJsonString(from data:Data) -> [String:Any]? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any] {
            return json
        }
        return nil
    }
    
    /// Handle error reponse
    private func handleError(forRequest:DataRequest, error:Error, with data:Data, failure:@escaping (Error) -> Void) {
        let nserror = error as NSError
        if nserror.domain == "com.alamofireobjectmapper.error" {
            NetworkManager.parseFailureResponse(for: data, with: failure)
        }else{
            failure(error)
        }
    }
}
