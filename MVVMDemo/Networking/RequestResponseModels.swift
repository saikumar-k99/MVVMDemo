//
//  RequestResponseModels.swift
//  MVVMDemo
//
//  Created by Saikumar Kankipati on 5/22/19.
//  Copyright © 2019 iOSBytes. All rights reserved.
//

import Foundation

let baseURL = "https://api.myjson.com/bins/qqp5k"

enum API: String {
    case hospitalApi
    case labApi
    case loginApi
    
    var endPoint: String {
        switch self {
        case .hospitalApi:
            return baseURL + "bins/qqp5k"
        case .labApi:
            return baseURL + "bins/qqp5k"
        case .loginApi:
            return baseURL + "bins/qqp5k"
        }
    }
}

enum RequestData {
    case hospitalApi(String)
    case labApi(String)
    
    var payload: RequestObj {
        switch self {
        case .hospitalApi(let endpoint):
            return RequestObj.createRequestObj(endPoint: endpoint, httpMethod: .GET, headerParams: nil, bodyParams: nil)
        case .labApi(let endpoint):
            return RequestObj.createRequestObj(endPoint: endpoint, httpMethod: .GET, headerParams: nil, bodyParams: nil)
        }
    }
}

struct RequestObj {
    var endPoint: String
    var httpMethod: httpMethod = .GET
    var headerParams: [String: String]?
    var bodyParams: [String: Any]?
    
    private init() { }
    
    init(endPoint: String) {
        self.endPoint = endPoint
    }
    
    static func createRequestObj(endPoint: String,
                                 httpMethod: httpMethod,
                                 headerParams: [String: String]?,
                                 bodyParams: [String: Any]?) -> RequestObj {
        
    }
}

enum httpMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}


protocol RequestResponseInterface {
    associatedtype ResponseType: Codable
    var requestInfo: RequestObj { get }
}

extension RequestResponseInterface {
    func parseData(data: Data) -> ResponseType? {
        do {
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(ResponseType.self, from: data)
            
            DispatchQueue.main.async {
                return result
            }
        } catch let error {
            DispatchQueue.main.async {
                return error
            }
        }
    }
}
