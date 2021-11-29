//
//  cellItems.swift
//  mercadoLibre
//
//  Created by jonnattan Choque on 22/11/21.
//

import UIKit

class cellItems: UITableViewCell {

    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var titleItem: UILabel!
    @IBOutlet weak var priceItem: UILabel!
    @IBOutlet weak var sellerItem: UILabel!
    @IBOutlet weak var stockItem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func display(object: Item) {
        self.imageItem.load(urlSting: object.thumbnail ?? Common.Constants.noImage)
        self.titleItem.text = object.title
        self.priceItem.text = Helpers.convertPrice(number: object.price ?? 0.0) 
        self.sellerItem.text = object.seller?.eshop?.nickName
        self.stockItem.text = "Stock: \(String(describing: object.availableQuantity ?? 0))"
    }
}
