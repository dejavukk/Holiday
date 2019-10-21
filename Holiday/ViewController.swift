//
//  ViewController.swift
//  Holiday
//
//  Created by JunHyuk on 2019/10/17.
//  Copyright © 2019 junhyuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 00ce2a63cd85075c0d1ff7d589d272570d584821 - API Key.
    // https://calendarific.com/api/v2
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var listOfHolidays = [HolidayDetail]() {
        didSet {
            
            DispatchQueue.main.sync {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfHolidays.count) Holidays found."
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }


}


extension ViewController: UITableViewDelegate {
    
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listOfHolidays.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let holiday = listOfHolidays[indexPath.row]
        cell.textLabel?.text = holiday.name
        cell.detailTextLabel?.text = holiday.date.iso
        
        
        return cell
    }
    
    
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchBarText = searchBar.text else {
            
            return
        }
        
        let holidayRequest = HolidayRequest(countryCode: searchBarText)
        holidayRequest.getHolidays{ [weak self] result in
            
            switch result {
                
            case .failure(let error):
                print(error)
            case .success(let holidays):
                self?.listOfHolidays = holidays
            }
        }
    }
}
