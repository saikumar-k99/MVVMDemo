//
//  HospitalWorker.swift
//  MVVMDemo
//
//  Created by Saikumar Kankipati on 5/21/19.
//  Copyright © 2019 iOSBytes. All rights reserved.
//

import Foundation

// Start request response binding from here
struct HospitalRequestResponse: RequestResponseInterface {
    typealias ResponseType = HospitalResponseModel
    var requestInfo: RequestObj {
         let requestData = RequestData.hospitalApi(API.hospitalApi.endPoint) 
        return requestData.payload
    }
}

struct HospitalWorker {
    
    func getHospitalDataFromAPI(callBack: (_ response: HospitalResponseModel?, _ error: Error?) -> Void ) {
        let requestResponseModel = HospitalRequestResponse()
        NetworkManager.shared().getHospitalDataFromAPI(request: requestResponseModel.requestInfo, successCallBack: { (responseData) in
            let responseModel = requestResponseModel.parseData(data: responseData as! Data)
            callBack(responseModel, nil)
        }, errorCallback: { (error) in
            callBack(nil, error)
        })
    }
}
