//
//  DetailViewController.swift
//  mercadoLibre
//
//  Created by jonnattan Choque on 22/11/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var titleItem: UILabel!
    @IBOutlet weak var stockItem: UILabel!
    @IBOutlet weak var priceItem: UILabel!
    @IBOutlet weak var imageSeller: UIImageView!
    @IBOutlet weak var nameSeller: UILabel!
    @IBOutlet weak var stateSeller: UILabel!
    @IBOutlet weak var stackBottom: UIStackView!
    
    var item: Item? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackBottom.roundCorners(corners: [.topLeft, .topRight], radius: 25)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadInfo()
    }
    
    
    func loadInfo(){
        guard let item = item else{return}
        
        self.imageItem.load(urlSting: item.thumbnail ?? Common.Constants.noImage)
        titleItem.text = item.title
        stockItem.text = "Stock: \(String(describing: item.availableQuantity ?? 0))"
        priceItem.text = "Precio: \(Helpers.convertPrice(number: item.price ?? 0.0))"
        
        self.imageSeller.load(urlSting: (item.seller?.eshop?.eshopLogoURL ?? Common.Constants.noImage))
        
        guard let name = item.seller?.eshop?.nickName else {return}
        nameSeller.text = "Vendedor: \(String(describing: name))"
        
        guard let state = item.seller!.sellerReputation!.powerSellerStatus else {return}
        stateSeller.text = "Nivel: \(String(describing: state))"
    }

    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
