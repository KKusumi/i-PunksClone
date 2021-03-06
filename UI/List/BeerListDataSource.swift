//
//  BeerListDataSource.swift
//  UI
//
//  Created by kusumi on 2021/04/23.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import Domain

class BeerListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, RxTableViewDataSourceType {
    
    typealias ItemSelected = (Beer) -> Void
    
    private let _itemSelected:ItemSelected
    
    typealias Element = [Beer]
    private var _beers: Element = []
    
    init(itemSelected: @escaping ItemSelected) {
        self._itemSelected = itemSelected
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath)
        let beer = _beers[indexPath.row]
        
        // image
        if let imageUrl = beer.imageUrl {
            let imageView = cell.viewWithTag(1) as! UIImageView
            imageView.image = UIImage(url: imageUrl)
        }
        
        // name
        let nameLabel = cell.viewWithTag(2) as! UILabel
        nameLabel.text = beer.name
        
        // first brewed
        let brewedLabel = cell.viewWithTag(3) as! UILabel
        brewedLabel.text = beer.firstBrewed
        
        // abv
        let abvLabel = cell.viewWithTag(4) as! UILabel
        abvLabel.text = beer.abv
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, observedEvent: Event<[Beer]>) {
        Binder(self) { dataSource, beers in
            dataSource._beers = beers
            tableView.reloadData()
        }.on(observedEvent)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        _itemSelected(_beers[indexPath.row])
    }
}
