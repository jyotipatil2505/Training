//
//  TestAppTests.swift
//  TestAppTests
//
//  Created by Jyoti Mitkar on 09/11/20.
//

import XCTest
@testable import TestApp

import TestApp

class TestAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let object = ProfileIconViewController()
        //object.internalMethod() // Calling internal method : Throwing compile time error as internalMethod() defined with Internal keyword
        
        object.openMethod() // Calling open method defined in TestApp Target
        object.publicMethod() // Calling public method defined in TestApp Target
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//Trying to inherit PublicClass defined in TestApp module into TestAppTests Module
/*class CustomClass: PublicClass {
    
    func testMethod() {
        
    }
}*/


//INHERITED OPEN CLASS DEFINED IN TestApp Module into TestAppTests Module
class CustomClass: OpenClass {
    
    //Method overriding implementation : openMethod() Method is defined in OpenClass Class
    override func openMethod() {
        super.openMethod()
        print("CustomClass openMethod CALLED")
    }
}
