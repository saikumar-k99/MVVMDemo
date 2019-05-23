//
//  RequestResponseModels.swift
//  MVVMDemo
//
//  Created by Saikumar Kankipati on 5/22/19.
//  Copyright © 2019 iOSBytes. All rights reserved.
//

import Foundation

let baseURL = "https://urldefense.proofpoint.com/"

enum API: String {
    case hospitalApi
    case labApi
    case loginApi
    
    var endPoint: String {
        switch self {
        case .hospitalApi:
            return baseURL + "v2/url?u=https-3A__api.myjson.com_bins_qqp5k&d=DwMGaQ&c=1hIq-C3ayh4zm6RZ7m4R2A&r=brzxXVtmD5gSKmzJNvdb7qKGVUO9hUIyZeIHzlAovfvnssQ1Lp2FRR95uHd6pT6M&m=cIMa-MhAZBkDM5Ir7TDmOW5MG0D6JIG8m5Y0HbYb2UQ&s=yb_Gb7XIb83myP4nnWD-2cpdaNhOQJDC-YrXzLe8E08&e="
        case .labApi:
            return baseURL + "v2/url?u=https-3A__api.myjson.com_bins_qqp5k&d=DwMGaQ&c=1hIq-C3ayh4zm6RZ7m4R2A&r=brzxXVtmD5gSKmzJNvdb7qKGVUO9hUIyZeIHzlAovfvnssQ1Lp2FRR95uHd6pT6M&m=cIMa-MhAZBkDM5Ir7TDmOW5MG0D6JIG8m5Y0HbYb2UQ&s=yb_Gb7XIb83myP4nnWD-2cpdaNhOQJDC-YrXzLe8E08&e="
        case .loginApi:
            return baseURL + "v2/url?u=https-3A__api.myjson.com_bins_qqp5k&d=DwMGaQ&c=1hIq-C3ayh4zm6RZ7m4R2A&r=brzxXVtmD5gSKmzJNvdb7qKGVUO9hUIyZeIHzlAovfvnssQ1Lp2FRR95uHd6pT6M&m=cIMa-MhAZBkDM5Ir7TDmOW5MG0D6JIG8m5Y0HbYb2UQ&s=yb_Gb7XIb83myP4nnWD-2cpdaNhOQJDC-YrXzLe8E08&e="
        }
    }
}

enum RequestData {
    case hospitalApi(String)
    case labApi(String)
    
    var payload: RequestObj {
        switch self {
        case .hospitalApi(let endpoint):
            return RequestObj(endPoint: endpoint, httpMethod: .GET, headerParams: nil, bodyParams: nil)
        case .labApi(let endpoint):
            return RequestObj(endPoint: endpoint, httpMethod: .GET, headerParams: nil, bodyParams: nil)
        }
    }
}

struct RequestObj {
    var endPoint: String
    var httpMethod: httpMethod = .GET
    var headerParams: [String: String]?
    var bodyParams: [String: Any]?
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
    func parseData(data: Data) -> Any {
        do {
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(ResponseType.self, from: data)
            
            return result
            
        } catch let error {
            return error
        }
    }
}
