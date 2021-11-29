//
//  Item.swift
//  mercadoLibre
//
//  Created by jonnattan Choque on 22/11/21.
//

import Foundation

// MARK: - Item
class Item: Codable {
    let id, title: String?
    let price: Double?
    let currencyID: String?
    let availableQuantity, soldQuantity: Int?
    let buyingMode, condition: String?
    let permalink: String?
    let thumbnail: String?
    let thumbnailID: String?
    let acceptsMercadopago, useThumbnailID: Bool?
    let seller: Seller?

    enum CodingKeys: String, CodingKey {
        case id, title, price
        case currencyID = "currency_id"
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case buyingMode = "buying_mode"
        case condition, permalink, thumbnail
        case thumbnailID = "thumbnail_id"
        case acceptsMercadopago = "accepts_mercadopago"
        case useThumbnailID = "use_thumbnail_id"
        case seller
    }

    init(id: String?, title: String?, price: Double?, currencyID: String?, availableQuantity: Int?, soldQuantity: Int?, buyingMode: String?, condition: String?, permalink: String?, thumbnail: String?, thumbnailID: String?, acceptsMercadopago: Bool?, useThumbnailID: Bool?, seller: Seller?) {
        self.id = id
        self.title = title
        self.price = price
        self.currencyID = currencyID
        self.availableQuantity = availableQuantity
        self.soldQuantity = soldQuantity
        self.buyingMode = buyingMode
        self.condition = condition
        self.permalink = permalink
        self.thumbnail = thumbnail
        self.thumbnailID = thumbnailID
        self.acceptsMercadopago = acceptsMercadopago
        self.useThumbnailID = useThumbnailID
        self.seller = seller
    }
}

// MARK: - Seller
class Seller: Codable {
    let id: Int?
    let permalink: String?
    let registrationDate: String?
    let carDealer, realEstateAgency: Bool?
    let eshop: Eshop?
    let sellerReputation: SellerReputation?

    enum CodingKeys: String, CodingKey {
        case id, permalink
        case registrationDate = "registration_date"
        case carDealer = "car_dealer"
        case realEstateAgency = "real_estate_agency"
        case eshop
        case sellerReputation = "seller_reputation"
    }

    init(id: Int?, permalink: String?, registrationDate: String?, carDealer: Bool?, realEstateAgency: Bool?, eshop: Eshop?, sellerReputation: SellerReputation?) {
        self.id = id
        self.permalink = permalink
        self.registrationDate = registrationDate
        self.carDealer = carDealer
        self.realEstateAgency = realEstateAgency
        self.eshop = eshop
        self.sellerReputation = sellerReputation
    }
}

// MARK: - Eshop
class Eshop: Codable {
    let seller: Int?
    let eshopID: Int?
    let nickName, siteID: String?
    let eshopLogoURL: String?
    let eshopStatusID, eshopExperience: Int?
    let eshopLocations: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case seller
        case eshopID = "eshop_id"
        case nickName = "nick_name"
        case siteID = "site_id"
        case eshopLogoURL = "eshop_logo_url"
        case eshopStatusID = "eshop_status_id"
        case eshopExperience = "eshop_experience"
        case eshopLocations = "eshop_locations"
    }

    init(seller: Int?,eshopID: Int?, nickName: String?, siteID: String?, eshopLogoURL: String?, eshopStatusID: Int?, eshopExperience: Int?, eshopLocations: [JSONAny]?) {
        self.seller = seller
        self.eshopID = eshopID
        self.nickName = nickName
        self.siteID = siteID
        self.eshopLogoURL = eshopLogoURL
        self.eshopStatusID = eshopStatusID
        self.eshopExperience = eshopExperience
        self.eshopLocations = eshopLocations
    }
}

// MARK: - SellerReputation
class SellerReputation: Codable {
    let powerSellerStatus, levelID: String?
    let metrics: Metrics?
    let transactions: Transactions?

    enum CodingKeys: String, CodingKey {
        case powerSellerStatus = "power_seller_status"
        case levelID = "level_id"
        case metrics, transactions
    }

    init(powerSellerStatus: String?, levelID: String?, metrics: Metrics?, transactions: Transactions?) {
        self.powerSellerStatus = powerSellerStatus
        self.levelID = levelID
        self.metrics = metrics
        self.transactions = transactions
    }
}

// MARK: - Metrics
class Metrics: Codable {
    let cancellations, claims, delayedHandlingTime: Cancellations?
    let sales: Sales?

    enum CodingKeys: String, CodingKey {
        case cancellations, claims
        case delayedHandlingTime = "delayed_handling_time"
        case sales
    }

    init(cancellations: Cancellations?, claims: Cancellations?, delayedHandlingTime: Cancellations?, sales: Sales?) {
        self.cancellations = cancellations
        self.claims = claims
        self.delayedHandlingTime = delayedHandlingTime
        self.sales = sales
    }
}

// MARK: - Cancellations
class Cancellations: Codable {
    let period: String?
    let rate: Double?
    let value: Int?

    init(period: String?, rate: Double?, value: Int?) {
        self.period = period
        self.rate = rate
        self.value = value
    }
}

// MARK: - Sales
class Sales: Codable {
    let period: String?
    let completed: Int?

    init(period: String?, completed: Int?) {
        self.period = period
        self.completed = completed
    }
}

// MARK: - Transactions
class Transactions: Codable {
    let canceled: Int?
    let period: String?
    let total: Int?
    let ratings: Ratings?
    let completed: Int?

    init(canceled: Int?, period: String?, total: Int?, ratings: Ratings?, completed: Int?) {
        self.canceled = canceled
        self.period = period
        self.total = total
        self.ratings = ratings
        self.completed = completed
    }
}

// MARK: - Ratings
class Ratings: Codable {
    let negative, neutral, positive: Double?

    init(negative: Double?, neutral: Double?, positive: Double?) {
        self.negative = negative
        self.neutral = neutral
        self.positive = positive
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
