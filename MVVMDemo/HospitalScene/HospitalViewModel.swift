//
//  HospitalViewModel.swift
//  MVVMDemo
//
//  Created by Saikumar Kankipati on 5/21/19.
//  Copyright © 2019 iOSBytes. All rights reserved.
//

import Foundation

struct HospitalViewModel {
    var responseModel: ResponseModel?
    
    lazy var worker = {
        return HospitalWorker()
    }
    
    func getHospitalData() {
        worker.
    }
}
