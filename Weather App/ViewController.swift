//
//  ViewController.swift
//  Weather
//
//  Created by Vlad Berezhnoi on 14.05.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    private let weatherManager: WeatherManager
    
    init(weatherManager: WeatherManager) {
        self.weatherManager = weatherManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.weatherDidChange = { [weak self] in
            guard let self = self else { return }
            self.fetchData()
        }
        fetchData()
        title = "My City"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "globe"), style: .plain, target: self, action: #selector(presentNewVC))
        view.backgroundColor = .secondarySystemBackground
        addSubview()
        Constraints()
        
        LocationManager.shared.getUserLocation { [weak self] location in
                guard let strongSelf = self else {return}
            print(location)
            strongSelf.addLocation(with: location)
        }
    }
    
    func addLocation(with location: CLLocation) {
        LocationManager.shared.locationSityandCounrtry(with: location) { [weak self] locationName in
            guard let name = locationName else {return}
               self?.weatherManager.city = name
               }
    }
    
    @objc func presentNewVC() {
        let vc = CityViewController(weatherService: weatherManager)
        navigationController?.pushViewController(vc, animated: true)
    }

    private func fetchData() {
        weatherManager.getWeatherInfo { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let model):
                self.cityNameLabel.text = String(model.address)
                self.tempLabel.text = String(format: "%.0f", model.currentConditions.temp) + "℃"
                self.cloudCoverLabel.text = String(format: "%.0f",model.currentConditions.cloudcover) + "%"
                self.humidityLabel.text = String(format: "%.0f", model.currentConditions.humidity) + "%"
                self.feelslikeLabel.text = "Feels like:" + String(format: "%.0f", model.currentConditions.feelslike) + "℃"
                self.weatherView.image = UIImage(named: model.currentConditions.conditions)
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    let cityNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weatherView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let feelslikeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .label
        label.font = label.font.withSize(40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cloudCoverView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud")
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let cloudCoverLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .label
        label.font = label.font.withSize(25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let humidityView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "humidity")
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    let humidityLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .label
        label.font = label.font.withSize(25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func addSubview() {
        view.addSubview(cityNameLabel)
        view.addSubview(weatherView)
        view.addSubview(tempLabel)
        view.addSubview(humidityView)
        view.addSubview(humidityLabel)
        view.addSubview(cloudCoverView)
        view.addSubview(cloudCoverLabel)
        view.addSubview(feelslikeLabel)
    }
    
     func Constraints() {
        NSLayoutConstraint.activate([
            cityNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -300),
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
         
         NSLayoutConstraint.activate([
            weatherView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            weatherView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherView.heightAnchor.constraint(equalToConstant: 300),
            weatherView.widthAnchor.constraint(equalToConstant: 300)
            
         ])
         
         NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempLabel.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 30)
         ])
         
         NSLayoutConstraint.activate([
            humidityView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -65),
            humidityView.centerYAnchor.constraint(equalTo: cloudCoverView.centerYAnchor),
            humidityView.heightAnchor.constraint(equalToConstant: 37),
            humidityView.widthAnchor.constraint(equalToConstant: 37)
         ])
         
         NSLayoutConstraint.activate([
            humidityLabel.centerYAnchor.constraint(equalTo: cloudCoverLabel.centerYAnchor),
            humidityLabel.leftAnchor.constraint(equalTo: humidityView.rightAnchor, constant: 2)
         ])
         
         NSLayoutConstraint.activate([
            cloudCoverView.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 10),
            cloudCoverView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            cloudCoverView.heightAnchor.constraint(equalToConstant: 40),
            cloudCoverView.widthAnchor.constraint(equalToConstant: 40)
         ])
         
         NSLayoutConstraint.activate([
            cloudCoverLabel.centerYAnchor.constraint(equalTo: cloudCoverView.centerYAnchor,constant: 2),
            cloudCoverLabel.leftAnchor.constraint(equalTo: cloudCoverView.leftAnchor, constant: 45)
            
         ])
         
         NSLayoutConstraint.activate([
            feelslikeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feelslikeLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor,constant: 100)
         
         ])
    }
}

