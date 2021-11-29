//
//  Notifications.swift
//  mercadoLibre
//
//  Created by jonnattan Choque on 22/11/21.
//

import Foundation

struct Common {
    struct APIRest{
        static let URL_SEARCH = "https://api.mercadolibre.com/sites/MLA/search?q="
    }
    struct Constants{
        static let noImage = "https://inurbanas.com/wp-content/themes/fortuna/images/no_img.jpg"
    }
    struct Notifications{
        struct Items{
            static let notificationSuccess : String = "com.twon.mercadoLibre.Items.success";
            static let notificationError : String = "com.twon.mercadoLibre.Items.error";
        }
    }
}
