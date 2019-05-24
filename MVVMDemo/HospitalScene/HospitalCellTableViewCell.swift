//
//  HospitalCellTableViewCell.swift
//  MVVMDemo
//
//  Created by Saikumar Kankipati on 5/21/19.
//  Copyright © 2019 iOSBytes. All rights reserved.
//

import UIKit

struct CellDisplayModel {
    let label1: String?
    let label2: String?
    let label3: String?
    let label4: String?
    let label5: String?
    let label6: String?
    
    static func placeholder() -> CellDisplayModel {
        return CellDisplayModel(label1: "Dummy", label2: "Dummy", label3: "Dummy", label4: "Dummy", label5: "Dummy", label6: "Dummy")
    }
}

class HospitalCellTableViewCell: UITableViewCell {
    @IBOutlet var labelOne: UILabel!
    @IBOutlet var labelTwo: UILabel!
    @IBOutlet var labelThree: UILabel!
    @IBOutlet var labelFour: UILabel!
    @IBOutlet var labelFive: UILabel!
    @IBOutlet var labelSix: UILabel!
    
    static let identifier = {
        return String(describing: self)
    }
    
    func loadContents(model: CellDisplayModel) {
        labelOne.text = model.label1
        labelTwo.text = model.label2
        labelThree.text = model.label3
        labelFour.text = model.label4
        labelFive.text = model.label5
        labelSix.text = model.label6
    }
}


