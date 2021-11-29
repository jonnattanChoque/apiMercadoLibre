//
//  cellDisconnected.swift
//  mercadoLibre
//
//  Created by jonnattan Choque on 22/11/21.
//

import UIKit

class cellDisconnected: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func display(){
        titleLbl.text = "No hay internet"
    }
}
