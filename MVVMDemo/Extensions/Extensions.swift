//
//  Extensions.swift
//  MVVMDemo
//
//  Created by Saikumar Kankipati on 5/21/19.
//  Copyright © 2019 iOSBytes. All rights reserved.
//

import UIKit

extension UITableViewCell {
    class func getNib() -> UINib {
        let className = String(describing: self)
        let nib = UINib(nibName: className, bundle: Bundle(for: self))
        
        return nib
    }
}
