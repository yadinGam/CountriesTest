//
//  ViewController.swift
//  CountriesTest
//
//  Created by yadin g on 24/11/2020.
//

import UIKit

class CountriesViewController: UIViewController , Alertable {
    
    @IBOutlet weak var countriesTableView: UITableView!
    
    //MARK:- Privat methods
    private var countriesViewModel : CountriesViewModel? {
        didSet { self.countriesTableView.reloadData() }
    }
    
    private func setTableView() {
        self.countriesTableView.register(UINib(nibName: String(describing:CountryTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing:CountryTableViewCell.self))
        self.countriesTableView.estimatedRowHeight = 100
        self.countriesTableView.rowHeight = UITableView.automaticDimension
    }
    //MARK:- LifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countriesViewModel = CountriesViewModel(service: CountriesService())
        
        self.countriesTableView.delegate = self
        self.countriesTableView.dataSource = self
        self.setTableView()
        
        self.countriesViewModel?.getCountries {
            [weak self] result in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let countriesViewModel):
                    self.countriesViewModel = countriesViewModel
                    self.countriesTableView.reloadData()
                case .failure(let error):
                    self.presentAlert(message: error.localizedDescription)
                }
            }
        }
    }

    //MARK:- Navigation
    private func showSelectedCountryNeighbors( neighborCountries: [CountryViewModel]) {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(identifier: "NeighborCountriesViewController") as! NeighborCountriesViewController
                vc.countriesViewModel = CountriesViewModel(countryViewModels: neighborCountries, service: CountriesService())
                vc.modalPresentationStyle = .fullScreen
                self.show(vc, sender: self)
    }
    
    @IBAction func sortByAreaTapped(_ sender: UIButton) {
        self.countriesViewModel?.sort(by: .area)
        self.countriesTableView.reloadData()
    }
    
    @IBAction func sortByNameTapped(_ sender: UIButton) {
        self.countriesViewModel?.sort(by: .name)
        self.countriesTableView.reloadData()
    }
    
}

extension CountriesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = tableView.cellForRow(at: indexPath) as? CountryTableViewCell else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let neighborCountries = self.countriesViewModel?.getNeighborCountries(for: indexPath.row), !neighborCountries.isEmpty  else {
            self.presentAlert(message: "This country has no neighbor countries")
            return
        }
        
        self.showSelectedCountryNeighbors(neighborCountries: neighborCountries)
    }
}

extension CountriesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesViewModel?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountryTableViewCell.self) )  as? CountryTableViewCell, let countryViewModel = self.countriesViewModel?.countryViewModel(at: indexPath.row) else { return UITableViewCell() }
        cell.configure(country: countryViewModel)
        return cell
    }
}


