//
//  ConvertToRubiTests.swift
//  ConvertToRubiTests
//
//  Created by 藤枝拓弥 on 2019/07/28.
//  Copyright © 2019 藤枝拓弥. All rights reserved.
//

import XCTest
@testable import ConvertToRubi

class ConvertToRubiTests: XCTestCase {
    var rubiView: ViewController!
    var rubiPresenter: RubiPresenter!
    
    override func setUp() {
        rubiView = ViewController()
        rubiPresenter = RubiPresenter(with: rubiView)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // 入力文字が空(エラー)
    func testInputEmptyConvertToRubi() {
        let sentence = ""
        let expectected = Message.Error.NO_INPUT_TEXT
        let exp: XCTestExpectation! = self.expectation(description: "testInputEmptyConvertToRubi")
        rubiPresenter.requestConvertToRubi(sentence: sentence,
                                           success: { rubiResponseData in
                                            XCTFail("converted:" + rubiResponseData.converted)
                                            exp.fulfill()
                                            
        },
                                           failure: { errorText in
                                            XCTAssertEqual(expectected, errorText)
                                            exp.fulfill()
                                            
        })
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    // 入力文字が漢字
    func testInputKanjiConvertToRubi() {
        let sentence = "漢字"
        let expectected = "かんじ"
        let exp: XCTestExpectation! = self.expectation(description: "testInputKanjiConvertToRubi")
        rubiPresenter.requestConvertToRubi(sentence: sentence,
                                           success: { rubiResponseData in
                                            XCTAssertEqual(expectected, rubiResponseData.converted)
                                            exp.fulfill()
                                            
        },
                                           failure: { errorText in
                                            XCTFail("errorText:" + errorText)
                                            exp.fulfill()
                                            
        })
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    // 入力文字がひらがな
    func testInputHiraganaConvertToRubi() {
        let sentence = "ひらがな"
        let expectected = "ひらがな"
        let exp: XCTestExpectation! = self.expectation(description: "testInputHiraganaConvertToRubi")
        rubiPresenter.requestConvertToRubi(sentence: sentence,
                                           success: { rubiResponseData in
                                            XCTAssertEqual(expectected, rubiResponseData.converted)
                                            exp.fulfill()
                                            
        },
                                           failure: { errorText in
                                            XCTFail("errorText:" + errorText)
                                            exp.fulfill()
                                            
        })
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    // 入力文字が数字
    func testInputNumberConvertToRubi() {
        let sentence = "123"
        let expectected = "ひゃくにじゅーさん"
        let exp: XCTestExpectation! = self.expectation(description: "testInputNumberConvertToRubi")
        rubiPresenter.requestConvertToRubi(sentence: sentence,
                                           success: { rubiResponseData in
                                            XCTAssertEqual(expectected, rubiResponseData.converted)
                                            exp.fulfill()
                                            
        },
                                           failure: { errorText in
                                            XCTFail("errorText:" + errorText)
                                            exp.fulfill()
                                            
        })
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    // 入力文字がローマ字
    func testInputRomanConvertToRubi() {
        let sentence = "abc"
        let expectected = "えーびーしー"
        let exp: XCTestExpectation! = self.expectation(description: "testInputRomanConvertToRubi")
        rubiPresenter.requestConvertToRubi(sentence: sentence,
                                           success: { rubiResponseData in
                                            XCTAssertEqual(expectected, rubiResponseData.converted)
                                            exp.fulfill()
                                            
        },
                                           failure: { errorText in
                                            XCTFail("errorText:" + errorText)
                                            exp.fulfill()
                                            
        })
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    // 入力文字が記号
    func testInputSymbolConvertToRubi() {
        let sentence = ";]:"
        let expectected = ";]:"
        let exp: XCTestExpectation! = self.expectation(description: "testInputSymbolConvertToRubi")
        rubiPresenter.requestConvertToRubi(sentence: sentence,
                                           success: { rubiResponseData in
                                            XCTAssertEqual(expectected, rubiResponseData.converted)
                                            exp.fulfill()
        },
                                           failure: { errorText in
                                            XCTFail("errorText:" + errorText)
                                            exp.fulfill()
                                            
        })
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
}
