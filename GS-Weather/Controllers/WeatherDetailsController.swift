//
//  WeatherDetailsController.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 03/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import UIKit
import RxSwift

let kkEY_PROGRESS_STATE = "progressState"

enum WeatherDetailsIntent: Int {
    case home
    case favorites
}

@objc class WeatherDetailsController: UIViewController {
    
    lazy var weatherDetailsView : WeatherDetailsListView = WeatherDetailsListView(viewModel: nil)
    let scrollView = UIScrollView()
    
    private var viewModel: WeatherDetailsPageVM<NetworkManager>!
    private let disposeBag = DisposeBag()
    private var cityName: String?
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = UIColor.black
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    lazy var retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Retry", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(retryClicked), for: .touchUpInside)
        button.backgroundColor = UIColor.lightGray
        button.layer.cornerRadius = 3.0
        return button
    }()
    
    lazy var networkErrorView: NetworkErrorMessageView = NetworkErrorMessageView()
    
    //MARK: init
    init(cityName: String?, viewModel: WeatherDetailsPageVM<NetworkManager>, intent: WeatherDetailsIntent) {
        self.viewModel = viewModel
        self.cityName = cityName
        super.init(nibName: nil, bundle: nil)
        self.title = cityName
        initialSetup(intent: intent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Self methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.addObserver(self, forKeyPath: kkEY_PROGRESS_STATE, options: [.new, .old], context: nil)
        addSubviews()
    }
    
    deinit {
        viewModel.removeObserver(self, forKeyPath: kkEY_PROGRESS_STATE)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.makeRequestToLoadWeather(destination: cityName);
    }
    
    //MARK: UI Setup
    private func initialSetup(intent: WeatherDetailsIntent) {
        view.backgroundColor = UIColor.white
        if intent == .home {
            setupRightBarButtonItem()
        }
        observeProgressState()
    }
    
    private func addSubviews() {
        view.addSubview(loadingIndicator)
        setupLoadinIndicatorCons()
        setupScrollView()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0.0),
            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0.0),
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0.0),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0.0),
        ])
    }
    
    private func addWeatherDetailsViewConstraints() {
        weatherDetailsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherDetailsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0.0),
            weatherDetailsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0.0),
            weatherDetailsView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0.0),
        ])
    }
    
    private func networkErrorViewCons() {
        networkErrorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            networkErrorView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0),
            networkErrorView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0.0),
            networkErrorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            networkErrorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
        ])
        
        view.addSubview(retryButton)
        
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            retryButton.topAnchor.constraint(equalTo: networkErrorView.bottomAnchor, constant: 15.0),
            retryButton.heightAnchor.constraint(equalToConstant: 44.0),
            retryButton.widthAnchor.constraint(equalToConstant: 100.0),
            retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupLoadinIndicatorCons() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0.0),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 20.0),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 20.0)
        ])
    }
    
    private func setupRightBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Add to favorites", style: .plain, target: self, action: #selector(didPressAddToFavoriteButton))
    }
    
    //MARK: Target action
    @objc private func didPressAddToFavoriteButton() {
        viewModel.addToFavorite()
    }
    
    @objc func retryClicked() {
        viewModel.makeRequestToLoadWeather(destination: cityName)
    }

    //MARK: Observer
    private func observeProgressState() {
        viewModel.progressState
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] progressState in
                switch progressState! {
                case .weatherInfoLoadingState :
                    self?.showLoadingIndicator()
                    
                case .weatherInfoSuccessState :
                    self?.removeLoadingIndicator()
                    self?.networkErrorView.removeFromSuperview()
                    self?.weatherDetailsView = WeatherDetailsListView.init(viewModel: (self?.viewModel.weatherDetailsViewModel)!)
                    self?.scrollView.addSubview(self?.weatherDetailsView ?? UIView())
                    self?.addWeatherDetailsViewConstraints()
                    
                case .weatherInfoFailureState :
                    self?.removeLoadingIndicator()
                    self?.networkErrorView.removeFromSuperview()
                    let alert = AlertHandler().showErrorAlertWith(header: "Alert!", message: "This city doesn't exist.", buttonText: "OK")
                    self?.present(alert, animated: true, completion: nil)
                    self?.navigationItem.rightBarButtonItem?.isEnabled = false
                    
                case .networkErrorState:
                    self?.removeLoadingIndicator()
                    self?.view.addSubview(self?.networkErrorView ?? UIView())
                    self?.networkErrorViewCons()
                    self?.navigationItem.rightBarButtonItem?.isEnabled = false
                    break
                    
                case .networkConnectedState:
                    self?.removeLoadingIndicator()
                    self?.networkErrorView.removeFromSuperview()
                    self?.viewModel.makeRequestToLoadWeather(destination: self?.cityName)
                    self?.navigationItem.rightBarButtonItem?.isEnabled = true
                case .addToFavoriteSuccessState(newlyAdded: let newlyAdded):
                    let alert = newlyAdded == true ?
                        AlertHandler().showErrorAlertWith(header: "Success!", message: "\(self?.cityName ?? "City") is added in favorites ", buttonText: "OK"):
                        AlertHandler().showErrorAlertWith(header: "Alert!", message: "\(self?.cityName ?? "City") is already added in favorites", buttonText: "OK")
                    self?.present(alert, animated: true, completion: nil)
                }
                }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    private func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    private func removeLoadingIndicator() {
        self.loadingIndicator.stopAnimating()
        self.loadingIndicator.removeFromSuperview()
    }
}
