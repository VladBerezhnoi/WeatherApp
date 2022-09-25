//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by Vlad Berezhnoi on 15.05.2022.
//

import UIKit

class CityViewController: UIViewController {

    let city = ["Sumy,Ukraine", "Kiev,Ukraine", "Odessa,Ukraine", "Zhitomir,Ukraine", "Kharkiv,Ukraine", "Antalya,Turkey"]
    
    let cityTableView = UITableView()
    
    private let weatherService: WeatherManager
    
    init(weatherService: WeatherManager) {
        self.weatherService = weatherService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cityTableView)
        constraint()
        cityTableView.dataSource = self
        cityTableView.delegate = self
    }
    
    private func constraint() {
        cityTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        cityTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityTableView.topAnchor.constraint(equalTo: view.topAnchor),
            cityTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            cityTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            cityTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
       
    }
    
}
extension CityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = city[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        weatherService.city = city[indexPath.row]
        navigationController?.popViewController(animated: true)
    }
}
