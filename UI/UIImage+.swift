//
//  UIImage.swift
//  UI
//
//  Created by kusumi on 2021/04/23.
//

import Foundation
import UIKit

extension UIImage {
    public convenience init(url: String) {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            self.init(data: data)!
            return
        } catch let err {
            print("Error: \(err.localizedDescription)")
        }
        self.init()
    }
}
