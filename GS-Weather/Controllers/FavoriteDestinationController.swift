//
//  FavoriteDestinationController.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 03/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import UIKit

let kKEY_FAV_CELL_ID = "favorite_destination_cell_id"
let kKEY_NO_FAV_CELL_ID = "no_fave_destination_cell_id"

class FavoriteDestinationController: UIViewController {
    
    var viewModel: FavoriteDestinationViewModel!

    lazy var favoriteTableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorStyle = .none
        tableView.separatorStyle = .none
        tableView.register(FavoriteDestinationCell.self, forCellReuseIdentifier:kKEY_FAV_CELL_ID)
        tableView.register(NoFavoritesAvailableCell.self, forCellReuseIdentifier:kKEY_NO_FAV_CELL_ID)

        return tableView
    }()
    
    init(viewModel: FavoriteDestinationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "Favorites"
        addSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: UI setup
    private func addSubviews() {
        view.addSubview(favoriteTableView)
        addFavoriteTableViewConsraints()
    }
    
    private func addFavoriteTableViewConsraints() {
        favoriteTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteTableView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 0.0),
            favoriteTableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0.0),
            favoriteTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0.0),
            favoriteTableView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: 0.0),
        ])
    }
}

extension FavoriteDestinationController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}

extension FavoriteDestinationController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = viewModel.cellViewModelArray?.count, count > 0 {
            return count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cellVMArray = viewModel.cellViewModelArray, cellVMArray.count > 0 {
            let cell: FavoriteDestinationCell = (tableView.dequeueReusableCell(withIdentifier: kKEY_FAV_CELL_ID, for: indexPath) as? FavoriteDestinationCell)!
            cell.bind(viewModel: cellVMArray[indexPath.row])
            cell.selectionStyle = .none;
            tableView.allowsSelection = true
            return cell
        } else {
            let cell: NoFavoritesAvailableCell = (tableView.dequeueReusableCell(withIdentifier: kKEY_NO_FAV_CELL_ID, for: indexPath) as? NoFavoritesAvailableCell)!
            tableView.allowsSelection = false
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellVM: FavoriteDestinationCellVM = (viewModel.cellViewModelArray?[indexPath.row])!
        self.navigationController?.pushViewController(WeatherDetailsController(cityName: cellVM.destination, viewModel: WeatherDetailsPageVM(networkManager: NetworkManager(), reachability: Reach()), intent: .favorites), animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeFromFavorite(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
