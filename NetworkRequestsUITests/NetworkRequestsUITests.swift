import XCTest
import SBTUITestTunnelClient

class NetworkRequestsUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launchTunnel()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            let application = XCUIApplication()
            
            let field = application.textFields.firstMatch
            XCTAssertTrue(field.value as! String == "Waiting")
            
            let fetch = application.buttons.firstMatch
            fetch.tap()
            
            _ = application.scrollViews.firstMatch.waitForExistence(timeout: 2)
            XCTAssertTrue(field.value as! String != "Waiting")
        }
    }
}
