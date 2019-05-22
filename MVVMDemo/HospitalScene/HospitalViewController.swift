//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Saikumar Kankipati on 5/21/19.
//  Copyright © 2019 iOSBytes. All rights reserved.
//

import UIKit

class HospitalViewController: UIViewController {

    @IBOutlet var hospitalTableView: UITableView!
    
    lazy var viewModel: HospitalViewModel? = {
        return HospitalViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hospitalTableView.register(HospitalCellTableViewCell.getNib(), forCellReuseIdentifier: HospitalCellTableViewCell.identifier)
        viewModel?.getHospitalData(callback: { (response, error) in
            guard let _ = error else {
                DispatchQueue.main.async {
                    self.hospitalTableView.reloadData()
                }
                return
            }
        })
        
    }
}

extension HospitalViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
