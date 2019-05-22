//
//  HospitalModel.swift
//  MVVMDemo
//
//  Created by Saikumar Kankipati on 5/21/19.
//  Copyright © 2019 iOSBytes. All rights reserved.
//

import Foundation

struct HospitalResponseModel: Codable {
    var medications: [MedicationDict]?
    var labs: [Lab]?
    var imagingList: [Imaging]?
}

struct MedicationDict: Codable {
    var medicationDict: [String: [Medication]]?
}

struct Medication: Codable {
    var name: String?
    var strength: String?
    var dose: String?
    var route: String?
    var sig: String?
    var pillCount: String?
    var refills: String?
}

struct Lab: Codable {
    var name: String?
    var time: String?
    var location: String?
}

struct Imaging:Codable {
    var name: String?
    var time: String?
    var location: String?
}
