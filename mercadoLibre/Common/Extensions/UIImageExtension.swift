//
//  UIImageExtension.swift
//  mercadoLibre
//
//  Created by jonnattan Choque on 22/11/21.
//

import UIKit

extension UIImageView {
    
    /// function that loads an image and sets the https
    /// - Parameter urlSting: Url image String
    func load(urlSting: String) {
        let http = URL(string: urlSting)!
        var comps = URLComponents(url: http, resolvingAgainstBaseURL: false)!
        comps.scheme = "https"
        let urlImage = comps.url!
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: urlImage) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
