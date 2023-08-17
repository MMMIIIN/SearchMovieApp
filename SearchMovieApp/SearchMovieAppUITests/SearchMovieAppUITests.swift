//
//  SearchMovieAppUITests.swift
//  SearchMovieAppUITests
//
//  Created by Mingwan Choi on 2023/07/20.
//

import XCTest



final class SearchMovieAppUITests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func test_영화검색() {
        let app = XCUIApplication()
        
        app.searchFields["MovieSearchBarTextField"].tap()
        
        app.searchFields["MovieSearchBarTextField"].typeText("범죄도시")
        
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"검색\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIDevice.shared.orientation = .portrait
        
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
