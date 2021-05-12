//
//  BeerListViewController.swift
//  UI
//
//  Created by kusumi on 2021/04/23.
//

import Foundation
import UIKit
import RxSwift
import Domain
import SwinjectStoryboard

public class BeerListViewController: UIViewController, BeerListNavigator {
    
    public static func createViewController() -> UIViewController {
        let sb = SwinjectStoryboard.create(name: "BeerList", bundle: nil, container: SwinjectStoryboard.defaultContainer)
        let vc = sb.instantiateViewController(withIdentifier: "beerListNavigationController") as! BeerListViewController
        return vc
    }
    
    public var viewModel: BeerListViewModel?
    
    let disposeBag = DisposeBag()
    lazy var listDataSource = BeerListDataSource(itemSelected: { beer in
        self.toBeerDetail(beerId: beer.id)
    })

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViewBinding()
        viewModel?.fetchBeerList(page: 1)
    }
    
    private func setupViewBinding() {
        // tableView
        viewModel?.beerList
            .drive(tableView.rx.items(dataSource: listDataSource))
            .disposed(by: disposeBag)
        viewModel?.loadState
            .map { $0 != LoadState.complete }
            .drive(tableView.rx.isHidden)
            .disposed(by: disposeBag)
        
        // indicator
        viewModel?.loadState
            .map { $0 != LoadState.loading }
            .drive(indicatorView.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    func toBeerDetail(beerId: Int) {
        let vc = BeerDetailViewController.createViewController(beerId: beerId)
        navigationController?.pushViewController(vc, animated: true)
    }
}
