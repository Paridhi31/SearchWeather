//
//  WeatherDetailsPageVM.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 03/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import UIKit
import RxSwift

enum WeatherInfoState: Equatable {
    case weatherInfoLoadingState
    case weatherInfoSuccessState
    case weatherInfoFailureState
    case networkErrorState
    case networkConnectedState
    case addToFavoriteSuccessState(newlyAdded: Bool)
}

class WeatherDetailsPageVM<T: NetworkManagerProtocol>: NSObject {
    
    private let disposeBag = DisposeBag()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = UIColor.black
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var blurEffectView: UIVisualEffectView?
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    
    var fetchWeatherNetworkRequest = FetchWeatherInfoRequest()
    var networkManager: T
    
    var weatherDetailsViewModel: WeatherDetailsListViewModel?
    let progressState = BehaviorSubject<WeatherInfoState?>(value:.weatherInfoLoadingState)
    let reachability: Reach?
    
    var currentState: WeatherInfoState? {
        didSet {
            progressState.onNext(currentState)
        }
    }
    
    init(networkManager: T, reachability: Reach) {
        self.networkManager = networkManager
        self.reachability = reachability
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: Notification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        reachability.monitorReachabilityChanges()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addToFavorite() {
        if let destination = weatherDetailsViewModel?.name {
            let favDestinationManager = FavoriteDestinationManager()
            if favDestinationManager.isDestinationAlreadyFavorited(destination: destination) {
                currentState = .addToFavoriteSuccessState(newlyAdded: false)
            } else {
                FavoriteDestinationManager().addDestinationInUserDefaults(destination: destination)
                currentState = .addToFavoriteSuccessState(newlyAdded: true)
            }
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let status = userInfo["Status"] as! String
            
            print(status)
            if reachability?.isReachable() == true && currentState == .networkErrorState {
                currentState = .networkConnectedState
            }
        }
    }
    
    func makeRequestToLoadWeather(destination: String?) {
        
        guard let destination = destination else {
            return
        }
        if reachability?.isReachable() == true {
            fetchWeatherNetworkRequest.endPoint = "q=\(destination)&appid=\(WEATHER_API_KEY)"
            fetchWeatherNetworkRequest.method = KGET_METHOD
            fetchWeatherNetworkRequest.url = FETCH_WEATHER_BASE_URL
            fetchWeatherNetworkRequest.parameters = [:]
            fetchWeatherNetworkRequest.jsonParserBlock = {[weak self]
                (data: Data?) in
                
                let dataFetcher: WeatherDataFetcher = WeatherDataFetcher()
                dataFetcher.fetchWeatherInfo(data) { (weatherInfoModel: WeatherInfoModel?, error: String?) in
                    if let weatherInfoM = weatherInfoModel {
                        self?.weatherDetailsViewModel = WeatherDetailsListViewModel.init(model: weatherInfoModel)
                        GSCacheManager.sharedInstance.addInfoInCacheFor(destination: destination as NSString, data: weatherInfoM)
                    }
                }
                self?.currentState = .weatherInfoSuccessState
            }
            
            fetchWeatherNetworkRequest.jsonErrorBlock = { [weak self]
                (error: String?) in
                self?.currentState = .weatherInfoFailureState
            }
            
            currentState = .weatherInfoLoadingState
            self.networkManager.enqueueRequest(self.fetchWeatherNetworkRequest)
        } else {
            showDataFromCache(destination: destination)
        }
    }
    
    private func showDataFromCache(destination: String) {
        print("Show data from cache")
        let model: WeatherInfoModel? = GSCacheManager.sharedInstance.getCachedInfoFor(destination: destination as NSString)
        if let weatherModel = model {
            self.weatherDetailsViewModel = WeatherDetailsListViewModel.init(model: weatherModel)
            self.currentState = .weatherInfoSuccessState
        } else {
            //Show network unavailability error, retry, on click make API call.
            self.currentState = .networkErrorState
        }
    }
}
