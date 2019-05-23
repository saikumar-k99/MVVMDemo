//
//  HospitalViewModel.swift
//  MVVMDemo
//
//  Created by Saikumar Kankipati on 5/21/19.
//  Copyright © 2019 iOSBytes. All rights reserved.
//

import Foundation

class HospitalViewModel {
    var responseModel: HospitalResponseModel? 
    
    lazy var worker = {
        return HospitalWorker()
    }
    
     func getHospitalData(callback: @escaping (HospitalResponseModel?, Error?) -> Void) {
        worker().getHospitalDataFromAPI { (hospitalResponseModel, error) in
            if let response = hospitalResponseModel {
                self.responseModel = response
                callback(self.responseModel, nil)
            } else if let errorObj = error {
                callback(nil, errorObj)
            }
        }
    }
}
