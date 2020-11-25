//
//  NeighborCountriesViewController.swift
//  CountriesTest
//
//  Created by yadin g on 25/11/2020.
//

import UIKit

class NeighborCountriesViewController: UIViewController {
  
    var countriesViewModel: CountriesViewModel!
    
    @IBOutlet weak var neighborCountriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.neighborCountriesTableView.delegate = self
        self.neighborCountriesTableView.dataSource = self
        self.setTableView()
    }
    
    private func setTableView() {
        self.neighborCountriesTableView.register(UINib(nibName: String(describing:CountryTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing:CountryTableViewCell.self))
        self.neighborCountriesTableView.estimatedRowHeight = 100
        self.neighborCountriesTableView.rowHeight = UITableView.automaticDimension
    }
}

extension NeighborCountriesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = tableView.cellForRow(at: indexPath) as? CountryTableViewCell else { return }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension NeighborCountriesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesViewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountryTableViewCell.self) )  as? CountryTableViewCell, let countryViewModel = countriesViewModel.countryViewModel(at: indexPath.row) else { return UITableViewCell() }
        cell.configure(country: countryViewModel)
        return cell
    }
}
