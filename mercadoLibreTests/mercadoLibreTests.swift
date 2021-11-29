//
//  mercadoLibreTests.swift
//  mercadoLibreTests
//
//  Created by jonnattan Choque on 22/11/21.
//

import XCTest
@testable import mercadoLibre
import Alamofire

class mercadoLibreTests: XCTestCase {

    //Pruebas de funciones de lógica de negocio, helpers y métodos
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAlamofireConsume() throws {
        let e = expectation(description: "Alamofire")
        let urlString = "https://api.mercadolibre.com/sites/MLA/search?q="
        
        Alamofire.request(urlString)
            .response { response in
                XCTAssertNil(response.error, "Whoops, error \(response.error!.localizedDescription)")

                XCTAssertNotNil(response, "No response")
                XCTAssertEqual(response.response?.statusCode ?? 0, 200, "Status code not 200")

                e.fulfill()
        }

        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testConvertPrice(){
        let price = Double(20091.24)
        let resultPrice = "$20,091.24"
        let helper = Helpers.convertPrice(number: price)
        XCTAssertEqual(helper, resultPrice)
    }
    
    func testInternet(){
        let hasInternet = true
        let getInternetConn = Connection.isConnectedToNetwork()
        XCTAssertEqual(hasInternet, getInternetConn)
    }
    
    
    func testUpdateLabelView() throws{
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.loadViewIfNeeded()
        
        let stringTest = "Prueba"
        vc.updateLabel(title: stringTest)
        XCTAssertEqual(vc.titleLbl.text, stringTest)
    }
}
