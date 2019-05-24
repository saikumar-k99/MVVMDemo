//
//  HospitalViewModel.swift
//  MVVMDemo
//
//  Created by Saikumar Kankipati on 5/21/19.
//  Copyright © 2019 iOSBytes. All rights reserved.
//

import Foundation

enum HospitalDataSource: Int {
    case lab
    case medicals
    case imaging
    
    func getNumberOfRows(model: HospitalResponseModel) -> Int {
        switch self {
        case .lab:
            return model.labs?.count ?? 0
        case .medicals:
            return model.medications?.count ?? 0
        case .imaging:
            return model.imagingList?.count ?? 0
        }
    }
    
    func getCellDataFor(indexPath: IndexPath, model: HospitalResponseModel) -> CellDisplayModel {
        switch indexPath.section {
        case HospitalDataSource.lab.rawValue:
            guard let labCellModel =  model.labs?[indexPath.row] else {
                return CellDisplayModel(label1: "Dummy", label2: "Dummy", label3: "Dummy", label4: "Dummy", label5: "Dummy", label6: "Dummy")
            }
            
            return CellDisplayModel(label1: labCellModel.name, label2: labCellModel.time, label3: labCellModel.location, label4: nil, label5: nil, label6: nil)
       
        case HospitalDataSource.medicals.rawValue:
            guard let medicalCellModel =  model.getMedicationsList()?[indexPath.row] else {
                return CellDisplayModel(label1: "Dummy", label2: "Dummy", label3: "Dummy", label4: "Dummy", label5: "Dummy", label6: "Dummy")
            }
            
            
            return CellDisplayModel(label1: medicalCellModel.name, label2: medicalCellModel.strength, label3: medicalCellModel.dose, label4: medicalCellModel.route, label5: medicalCellModel.sig, label6: medicalCellModel.pillCount)
            
        case HospitalDataSource.imaging.rawValue:
            guard let imagingCellModel =  model.imagingList?[indexPath.row] else {
                return CellDisplayModel(label1: "Dummy", label2: "Dummy", label3: "Dummy", label4: "Dummy", label5: "Dummy", label6: "Dummy")
            }
            
            return CellDisplayModel(label1: imagingCellModel.name, label2: imagingCellModel.time, label3: imagingCellModel.location, label4: nil, label5: nil, label6: nil)
            
        default:
            return CellDisplayModel(label1: "Dummy", label2: "Dummy", label3: "Dummy", label4: "Dummy", label5: "Dummy", label6: "Dummy")
        }
    }
}

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

extension HospitalViewModel {
    func getNumberOfSections() -> Int {
        guard let model = responseModel else {
            return 0
        }
        
        return model.getNumberOfCases()
    }
    
    func getNumberOfRowsFor(section: Int) -> Int {
        guard let model = responseModel else {
            return 0
        }
        
        let dataSource = HospitalDataSource(rawValue: section)
        return dataSource?.getNumberOfRows(model: model) ?? 0
    }
    
    func getCellForRow(index:IndexPath) -> CellDisplayModel {
        guard let model = responseModel else {
            return CellDisplayModel(label1: "Dummy", label2: "Dummy", label3: "Dummy", label4: "Dummy", label5: "Dummy", label6: "Dummy")
        }
        
        let dataSource = HospitalDataSource(rawValue: index.section)
        
        return dataSource?.getCellDataFor(indexPath: index, model: model) ?? CellDisplayModel(label1: "Dummy", label2: "Dummy", label3: "Dummy", label4: "Dummy", label5: "Dummy", label6: "Dummy")
    }
}


