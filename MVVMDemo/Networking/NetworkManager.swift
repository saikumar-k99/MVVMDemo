//
//  NetworkManager.swift
//  MVVMDemo
//
//  Created by Saikumar Kankipati on 5/21/19.
//  Copyright © 2019 iOSBytes. All rights reserved.
//

import Foundation

protocol SharedNetworkingInterface {
    
}

protocol SessionDispatcher {
    var session: AnyObject { get set }
    func makeAPICall(callBack: (Data, Error) -> Void)
}

enum Dispatcher: SessionDispatcher {
    case urlSession
    case afNetworking
    
    var session: AnyObject {
        switch self {
        case .urlSession:
            return URLSession.shared
        case .afNetworking:
            return UserDefaults.standard
        }
    }
    
    func makeAPICall(urlString: String, callBack: (Data, Error) -> Void) {
        switch self {
        case .afNetworking:
            return
        case .urlSession:
            session.dataTask(with: urlString) { (data, response, error) in
               // callBack(<#Data#>)
            }
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
        let realServiceHandler = NetworkManager.createSession()
        let mockServiceHandler = MockServiceHandler.init()
        
        return isMockMode ? realServiceHandler : mockServiceHandler
    }
    
    private static func createSession() -> RealServiceHandler {
        return RealServiceHandler.init(dispatcher: .urlSession)
    }
}

struct RealServiceHandler: SharedNetworkingInterface {
    init(dispatcher: Dispatcher) {
        
    }
}

struct MockServiceHandler: SharedNetworkingInterface {
    
}
