//
//  NetworkManager.swift
//  MVVMDemo
//
//  Created by Saikumar Kankipati on 5/21/19.
//  Copyright © 2019 iOSBytes. All rights reserved.
//

import Foundation

protocol SharedNetworkingInterface {
    typealias successCallback = (_ responseJson: Any?) -> Void
    typealias failureCallback = (_ error: Error?) -> Void
    //List of all the network API calls go here
    func getHospitalDataFromAPI(request: RequestObj, successCallBack: successCallback, errorCallback: failureCallback)
}

enum Dispatcher {
    case urlSession
    case afNetworking
    
    func makeAPICall(request: RequestObj, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void) {
        switch self {
        case .afNetworking:
            return
        case .urlSession:
            
            guard let url = URL(string: request.endPoint) else {
                return
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.httpMethod.rawValue
            
            do {
                if let params = request.bodyParams {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
                }
            } catch let error {
                onError(error)
                return
            }
            
            if let headers = request.headerParams {
                urlRequest.allHTTPHeaderFields = headers
            }
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    onError(error)
                    return
                }
                
                guard let _data = data else {
                    return
                }
                
                onSuccess(_data)
                }.resume()
           return
        }
    }
}

final class NetworkManager {
    private static var sharedInstanceInterface: SharedNetworkingInterface?
    private static var isMockMode = false
    
    private init() { }
    
    static func setMockMode(isEnabled: Bool) {
        isMockMode = isEnabled
    }
    
    static func shared() -> SharedNetworkingInterface {
        let realServiceHandler = RealServiceHandler(dispatcher: .urlSession)
        let mockServiceHandler = MockServiceHandler.init()
        
        return isMockMode ? realServiceHandler : mockServiceHandler
    }
}

struct RealServiceHandler: SharedNetworkingInterface {
    var dispatcher: Dispatcher?
    
    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
    }
    
    func getHospitalDataFromAPI(request: RequestObj,
                                successCallBack: SharedNetworkingInterface.successCallback,
                                errorCallback: SharedNetworkingInterface.failureCallback) {
        
        dispatcher?.makeAPICall(request: request, onSuccess: successCallback, onError: failureCallback)
    }
}

struct MockServiceHandler: SharedNetworkingInterface {
    func getHospitalDataFromAPI(request: RequestObj, successCallBack: (Any?) -> Void, errorCallback: (Error?) -> Void) {
        
    }
}
