//
//  HospitalViewModel.swift
//  MVVMDemo
//
//  Created by Saikumar Kankipati on 5/21/19.
//  Copyright © 2019 iOSBytes. All rights reserved.
//

import Foundation

struct HospitalViewModel {
    var responseModel: HospitalResponseModel?
    
    lazy var worker = {
        return HospitalWorker()
    }
    
    mutating func getHospitalData(callback: (HospitalResponseModel?, Error?) -> Void) {
        worker().getHospitalDataFromAPI { (hospitalResponseModel, error) in
            if let response = hospitalResponseModel {
                responseModel = response
                callback(responseModel, nil)
            } else if let errorObj = error {
                callback(nil, errorObj)
            }
        }
    }
}
