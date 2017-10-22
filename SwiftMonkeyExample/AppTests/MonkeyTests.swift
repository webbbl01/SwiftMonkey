//
//  SwiftMonkeyExampleUITests.swift
//  SwiftMonkeyExampleUITests
//
//  Created by Dag Agren on 07/11/2016.
//  Copyright © 2016 Zalando SE. All rights reserved.
//

import XCTest
import SwiftMonkey

class SwiftMonkeyExampleUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMonkey() {
        let application = XCUIApplication()

        // Workaround for bug in Xcode 7.3. Snapshots are not properly updated
        // when you initially call app.frame, resulting in a zero-sized rect.
        // Doing a random query seems to update everything properly.
        // TODO: Remove this when the Xcode bug is fixed!
        _ = application.descendants(matching: .any).element(boundBy: 0).frame

        // Initialise the monkey tester with the current device
        // frame. Giving an explicit seed will make it generate
        // the same sequence of events on each run, and leaving it
        // out will generate a new sequence on each run.
        let monkey = Monkey(frame: application.frame)
        //let monkey = Monkey(seed: 123, frame: application.frame)

        let app = XCUIApplication()
        let tablesQuery = app.tables
        let tabBarsQuery = app.tabBars
        
        let excludedElements = [
            tablesQuery/*@START_MENU_TOKEN@*/.buttons["Left button"]/*[[".cells.buttons[\"Left button\"]",".buttons[\"Left button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/,
            tablesQuery/*@START_MENU_TOKEN@*/.buttons["Middle button"]/*[[".cells.buttons[\"Middle button\"]",".buttons[\"Middle button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/,
            tablesQuery/*@START_MENU_TOKEN@*/.buttons["Right button"]/*[[".cells.buttons[\"Right button\"]",".buttons[\"Right button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/,
            tablesQuery/*@START_MENU_TOKEN@*/.buttons["Bad button"]/*[[".cells.buttons[\"Bad button\"]",".buttons[\"Bad button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/,
            // tablesQuery/*@START_MENU_TOKEN@*/.buttons["Ok button"]/*[[".cells.buttons[\"Ok button\"]",".buttons[\"Ok button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/,
            tablesQuery/*@START_MENU_TOKEN@*/.buttons["Good button"]/*[[".cells.buttons[\"Good button\"]",".buttons[\"Good button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/,
            tablesQuery/*@START_MENU_TOKEN@*/.buttons["Cool button"]/*[[".cells.buttons[\"Cool button\"]",".buttons[\"Cool button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/,
            tablesQuery/*@START_MENU_TOKEN@*/.buttons["Calm button"]/*[[".cells.buttons[\"Calm button\"]",".buttons[\"Calm button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/,
            tablesQuery/*@START_MENU_TOKEN@*/.buttons["Tough button"]/*[[".cells.buttons[\"Tough button\"]",".buttons[\"Tough button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/,
            tabBarsQuery.buttons["Clicky things"],
            tabBarsQuery.buttons["Banana"]
        ]

        monkey.tapExcluded = excludedElements
        
        // Add actions for the monkey to perform. We just use a
        // default set of actions for this, which is usually enough.
        // Use either one of these but maybe not both.
        // XCTest private actions seem to work better at the moment.
        // UIAutomation actions seem to work only on the simulator.
        // monkey.addDefaultXCTestPrivateActions()
        // monkey.addDefaultUIAutomationActions()
        
        monkey.addXCTestTapAction(weight: 25)
        

        // Occasionally, use the regular XCTest functionality
        // to check if an alert is shown, and click a random
        // button on it.
        monkey.addXCTestTapAlertAction(interval: 100, application: application)

        // Run the monkey test indefinitely.
        monkey.monkeyAround()
    }
}
