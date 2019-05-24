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
        hospitalTableView.register(UINib(nibName: "HospitalCellTableViewCell", bundle: nil), forCellReuseIdentifier: "HospitalCellTableViewCell")
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let dataSource = viewModel else {
            return 0
        }
        
        return dataSource.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRowsFor(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalCellTableViewCell", for: indexPath) as? HospitalCellTableViewCell else {
            return UITableViewCell()
        }
        
        cell.loadContents(model: viewModel?.getCellForRow(index: indexPath) ?? CellDisplayModel.placeholder())
        
        return cell
    }
}
