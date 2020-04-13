import XCTest
@testable import Speed_Reader

class HomeViewControllerTest: XCTestCase {
    func testDefaultTextPlaceholder_IsExpected() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.loadView()

        XCTAssertEqual(homeViewController.textToSpeedReadPlaceholder, "Enter/Paste text to speed read here...")
    }
    
    func testDefaultWPM_IsExpected() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.loadView()

        XCTAssertEqual(homeViewController.wpm, 450.0)
    }
    
    // MARK - Read button styling tests
    
    func testReadyButton_CornerRadius_Is10() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.loadView()
        
        homeViewController.applyReadyButtonStyles()
        
        XCTAssertEqual(homeViewController.readyButton.layer.cornerRadius, 10)
    }
    
    func testReadyButton_BorderWidth_Is11() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.loadView()
        
        homeViewController.applyReadyButtonStyles()
        
    XCTAssertEqual(homeViewController.readyButton.layer.borderWidth, 1.0)
    }
    
    func testReadyButton_ClipToBounds_IsTrue() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.loadView()
        
        homeViewController.applyReadyButtonStyles()
        
        XCTAssertTrue(homeViewController.readyButton.clipsToBounds)
    }
    
    
    // MARK - Text Field Styling Tests
    
    func testTextToSpeedRead_CornerRadius_Is10() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.loadView()
        
        homeViewController.applyTextFieldStyles()

        XCTAssertEqual(homeViewController.textToSpeedRead.layer.cornerRadius, 10)
    }
    
    func testTextToSpeedRead_ClipToBounds_IsTrue() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.loadView()
        
        homeViewController.applyTextFieldStyles()

        XCTAssertTrue(homeViewController.textToSpeedRead.clipsToBounds)
    }
    
    func testTextToSpeedRead_BorderWidth_Is1() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.loadView()
        
        homeViewController.applyTextFieldStyles()

        XCTAssertEqual(homeViewController.textToSpeedRead.layer.borderWidth, 1)
    }
    
    func testTextToSpeedRead_BorderColor_IsCorrect() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.loadView()
        
        homeViewController.applyTextFieldStyles()

        XCTAssertEqual(homeViewController.textToSpeedRead.layer.borderColor, UIColor(red:0.23, green:0.17, blue:0.26, alpha:1.00).cgColor)
    }
    
    func testTextToSpeedRead_Text_IsCorrect() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.loadView()
        
        homeViewController.applyTextFieldStyles()

        XCTAssertEqual(homeViewController.textToSpeedRead.text, "Enter/Paste text to speed read here...")
    }
    
    func testTextToSpeedRead_TextColor_IsWhite() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.loadView()

        homeViewController.applyTextFieldStyles()

        XCTAssertEqual(homeViewController.textToSpeedRead.textColor, UIColor.white)
    }
    
    // MARK - Text To Speed Read Placeholder Tests

    func testWhenBeginningToEditTextToSpeedRead_Text_IsCleared() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.loadView()

    homeViewController.textViewDidBeginEditing(homeViewController.textToSpeedRead)

        XCTAssertEqual(homeViewController.textToSpeedRead.text, "")
    }
    
    func testWhenFinishedEditingTextToSpeedRead_AndIsDirty_Text_IsPersisted() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.loadView()

    homeViewController.textViewDidBeginEditing(homeViewController.textToSpeedRead)
        
        homeViewController.textToSpeedRead.text = "Dirty"
        
    homeViewController.textViewDidEndEditing(homeViewController.textToSpeedRead)


        XCTAssertEqual(homeViewController.textToSpeedRead.text, "Dirty")
    }
    
    func testWhenFinishedEditingTextToSpeedRead_AndIsNotDirty_Text_IsPersisted() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.loadView()

    homeViewController.textViewDidBeginEditing(homeViewController.textToSpeedRead)
    homeViewController.textViewDidEndEditing(homeViewController.textToSpeedRead)


        XCTAssertEqual(homeViewController.textToSpeedRead.text, "Enter/Paste text to speed read here...")
    }
    
    // MARK - WPM slider tests
    
    func testWhenSliderIsChanged_wpm_IsUpdated() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.loadView()

        homeViewController.wpmSlider.value = 300
        homeViewController.wpmSliderValueChanged(homeViewController.wpmSlider!)
        
        XCTAssertEqual(homeViewController.wpm, 300)
    }
    
    func testWhenSliderIsChanged_wpmSliderLabel_IsUpdated() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.loadView()

        homeViewController.wpmSlider.value = 300
        homeViewController.wpmSliderValueChanged(homeViewController.wpmSlider!)
        
        XCTAssertEqual(homeViewController.wpmSliderLabel.text, "300wpm")
    }
    
    // MARK - Segue tests
    
    func testWpmAndTextToRead_AreSetOnSegue() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let readerViewController = storyboard.instantiateViewController(withIdentifier: "ReaderViewController") as! ReaderViewController
        homeViewController.loadView()
        
        homeViewController.textToSpeedRead.text = "Segue"
        homeViewController.wpmSlider.value = 300.0
        homeViewController.wpmSliderValueChanged(homeViewController.wpmSlider!)

        homeViewController.prepare(for: UIStoryboardSegue(identifier: "ReaderViewController", source: homeViewController, destination: readerViewController), sender: homeViewController)
        
        XCTAssertEqual(readerViewController.wpm, 300.0)
        XCTAssertEqual(readerViewController.textToRead, "Segue")
    }
    
    // MARK - helper buttons
    
    func testClearButtonTapped_ClearsTextToRead(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.loadView()

        homeViewController.clearButtonTapped((Any).self)
    
        XCTAssertEqual(homeViewController.textToSpeedRead.text, "")
    }
}
