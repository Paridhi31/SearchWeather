//
//  ViewController.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 02/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel!
    
    let cityField: GSTextField = {
        let textField = GSTextField()
        textField.textColor = UIColor.black
        textField.layer.borderWidth = 1.0
        textField.placeholder = "Enter the city name"
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        return  button
    }()
    
    let goToFavoritesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go to favorites", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(goToFavorites), for: .touchUpInside)
        return  button
    }()
    
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    //MARK: init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Self methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        addSubviews()
    }
    
    //MARK: Target action
    @objc func searchButtonClicked() {
        guard let city = cityField.text, city.count > 0 else {
            let alert = AlertHandler().showErrorAlertWith(header: "Alert!", message: "Please enter a destination to see the weather info", buttonText: "OK")
            self.present(alert, animated: true, completion: nil)
            return
        }
        self.navigationController?.pushViewController(WeatherDetailsController(cityName: city, viewModel: WeatherDetailsPageVM(networkManager: NetworkManager(), reachability: Reach()), intent: .home), animated: true)
    }
    
    @objc func goToFavorites() {
        self.navigationController?.pushViewController(FavoriteDestinationController(viewModel: FavoriteDestinationViewModel()), animated: true)
    }
    
    //MARK: UI setup
    private func addSubviews() {
        view.addSubview(containerView)
        addContainerViewConstraints()
        containerView.addSubview(cityField)
        addCityFieldConstraints()
        containerView.addSubview(searchButton)
        addSearchButtonConstraints()
        containerView.addSubview(goToFavoritesButton)
        addGoToFavoritesButtonConstraints()
    }
    
    private func addContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 15.0),
            containerView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -15.0),
            containerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 15.0),
            containerView.heightAnchor.constraint(equalToConstant: 162.0)
        ])
    }
    
    private func addCityFieldConstraints() {
        cityField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0.0),
            cityField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0.0),
            cityField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0.0),
            cityField.heightAnchor.constraint(equalToConstant: 44.0)
        ])
    }
    
    private func addSearchButtonConstraints() {
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            searchButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0.0),
            searchButton.topAnchor.constraint(equalTo: cityField.bottomAnchor, constant: 15.0),
            searchButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])
    }
    
    private func addGoToFavoritesButtonConstraints() {
        goToFavoritesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goToFavoritesButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15.0),
            goToFavoritesButton.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 15.0),
            goToFavoritesButton.heightAnchor.constraint(equalToConstant: 44.0),
        ])
    }
}


