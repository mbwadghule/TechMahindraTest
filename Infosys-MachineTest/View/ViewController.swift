//
//  ViewController.swift
//  Infosys-MachineTest
//
//  Created by Augment Deck Technologies on 05/08/20.
//  Copyright © 2020 Augment Deck Technologies. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    var VModel = ViewModel()
    var DataList: WebItems?
    var tableView = UITableView()
    let child = Activity()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadViewComponents()
        retrieveDataFromApi()
    }
 }

// MARK: - Table datasource and Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        VModel.getNumberOfRows()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.canadaCellIdentifier, for: indexPath) as? TableViewCell
        cell?.selectionStyle = .none
        if let rowDict = DataList?.rows[indexPath.row] {
            cell?.rowData = rowDict
        }
        return cell!
    }
}
// MARK: - Create and Set Constraints for table
private extension ViewController {
    func loadViewComponents() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTableData(_:)), for: .valueChanged)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: Constants.canadaCellIdentifier)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
    }
    @objc private func refreshTableData(_ sender: Any) {
        
        self.refreshControl.endRefreshing()
        retrieveDataFromApi()
    }
    
    func retrieveDataFromApi() {
        self.loadSpinnerView()
        VModel.getDataFromApi(apiUrl: Constants.apiString) { response, status in
            if status {
                self.DataList = response
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.navigationItem.title = self.DataList?.title
                    self.tableView.reloadData()
                    self.removeSpinnerView()
                }
            }
            else {
                self.presentSingleButtonDialog()
            }
        }
    }
}


