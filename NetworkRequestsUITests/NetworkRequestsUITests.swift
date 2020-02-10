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

    func testWithNoHeaderCheck() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            app.stubRequests(
                matching: SBTRequestMatch(url: "https://api.postcodes.io/random/postcodes", method: "GET"),
                response: SBTStubResponse(response: getJSON(), returnCode: 200))
            
            let application = XCUIApplication()
            
            let field = application.textFields.firstMatch
            XCTAssertTrue(field.value as! String == "Waiting")
            
            let fetch = application.buttons.firstMatch
            fetch.tap()
            
            _ = application.scrollViews.firstMatch.waitForExistence(timeout: 2)
            XCTAssertTrue(field.value as! String == "TEST CASE")
        }
    }
    
    func testWithHeaderCheck() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            app.stubRequests(
                matching: SBTRequestMatch(url: "https://api.postcodes.io/random/postcodes", method: "GET", requestHeaders: [:]),
                response: SBTStubResponse(response: getJSON(), returnCode: 200))
            
            let application = XCUIApplication()
            
            let field = application.textFields.firstMatch
            XCTAssertTrue(field.value as! String == "Waiting")
            
            let fetch = application.buttons.firstMatch
            fetch.tap()
            
            _ = application.scrollViews.firstMatch.waitForExistence(timeout: 2)
            XCTAssertTrue(field.value as! String == "TEST CASE")
        }
    }
    
    func testWithSpecificHeaderCheck() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            app.stubRequests(
                matching: SBTRequestMatch(url: "https://api.postcodes.io/random/postcodes", method: "GET", requestHeaders: ["x-amz-target":"AWSCognitoIdentityProviderService.InitiateAuth"]),
                response: SBTStubResponse(response: getJSON(), returnCode: 200))
            let application = XCUIApplication()
            
            let field = application.textFields.firstMatch
            XCTAssertTrue(field.value as! String == "Waiting")
            
            let fetch = application.buttons.firstMatch
            fetch.tap()
            
            _ = application.scrollViews.firstMatch.waitForExistence(timeout: 2)
            XCTAssertTrue(field.value as! String == "TEST CASE")
        }
    }
    
    fileprivate func getJSON() -> [String: Any] {
        return NetworkRequestsUITests.readJSONFromFile(fileName: "postcodes")!
    }
    
    static func readJSONFromFile(fileName: String) -> [String: Any]? {
        var json: Any?
        guard let path = Bundle(for: NetworkRequestsUITests.self).path(forResource: fileName, ofType: "json") else {
            return nil
        }
        
        do {
            let fileUrl = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
        } catch let error {
            print("JSON fetch error \(error)")
        }
        
        return json as? [String: Any]
    }
}
