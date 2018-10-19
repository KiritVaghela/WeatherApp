//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Kirit Vaghela on 10/15/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import WeatherApp

class WeatherAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTempetureStringFunc(){
        
        // given
        let main = Main(JSON: [:])
        main?.temp = 100
        
         //when
        let tempString = main?.getTempetureString()
        
         //than
        XCTAssert(tempString! == "100°", "Error : Give: \(main!.temp!), return : \(tempString ?? "" )")
        
    }
    
    func testMinTemparetureStringFunc() {
        
        // given
        let main = Main(JSON: [:])
        main?.temp_min = 50
        
        //when
        let minTempString = main?.getMinTempetureString()
        
        //than
        XCTAssert(minTempString! == "50°", "Error : Give: \(main!.temp_min!), return : \(minTempString ?? "" )")
        
    }
    
    func testMaxTemparetureStringFunc() {
        
        // given
        let main = Main(JSON: [:])
        main?.temp_max = 150
        
        //when
        let maxTempString = main?.getMaxTempetureString()
        
        //than
        XCTAssert(maxTempString! == "150°", "Error : Give: \(main!.temp_max!), return : \(maxTempString ?? "" )")
        
    }
    
}
