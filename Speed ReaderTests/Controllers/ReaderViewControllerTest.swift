import XCTest
@testable import Speed_Reader

class ReaderViewControllerTests: XCTestCase {
    func testDefaultWordsPerMinute_Is450() {
        let readerViewController = ReaderViewController()

        XCTAssertEqual(readerViewController.wpm, 450.0)
    }
    
    func testDoneButton_IsHiddenByDefault() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let readerViewController = storyboard.instantiateViewController(withIdentifier: "ReaderViewController") as! ReaderViewController
        readerViewController.loadView()

        XCTAssertTrue(readerViewController.doneButton.isHidden)
    }
    
    // MARK : Test Countdown Sequence
    
    func testCountdownSequence_Is30Seconds() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let readerViewController = storyboard.instantiateViewController(withIdentifier: "ReaderViewController") as! ReaderViewController
        readerViewController.loadView()

        readerViewController.attachCustomerTimer(timer: MockTimer.self)
        
        readerViewController.beginCountdown()
        
        XCTAssertEqual(MockTimer.interval, 0.5)
    }
    
    func testCountdownSequence_BeginsWithReady() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let readerViewController = storyboard.instantiateViewController(withIdentifier: "ReaderViewController") as! ReaderViewController
        readerViewController.loadView()

        readerViewController.attachCustomerTimer(timer: MockTimer.self)
        
        readerViewController.beginCountdown()

        XCTAssertEqual(readerViewController.readingText!.text, "Ready?")
    }
    
    func testCountdownSequence_AfterFirstTick_Is3() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let readerViewController = storyboard.instantiateViewController(withIdentifier: "ReaderViewController") as! ReaderViewController
        readerViewController.loadView()

        readerViewController.attachCustomerTimer(timer: MockTimer.self)
        
        readerViewController.beginCountdown()
        
        MockTimer.currentTimer.fire()
        
        XCTAssertEqual(readerViewController.readingText!.text, "3")
    }
    
    func testCountdownSequence_AfterSecondTick_Is2() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let readerViewController = storyboard.instantiateViewController(withIdentifier: "ReaderViewController") as! ReaderViewController
        readerViewController.loadView()

        readerViewController.attachCustomerTimer(timer: MockTimer.self)
        
        readerViewController.beginCountdown()
        
        MockTimer.currentTimer.fire()
        MockTimer.currentTimer.fire()
        
        XCTAssertEqual(readerViewController.readingText!.text, "2")
    }
    
    func testCountdownSequence_AfterThirdTick_Is1() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let readerViewController = storyboard.instantiateViewController(withIdentifier: "ReaderViewController") as! ReaderViewController
        readerViewController.loadView()

        readerViewController.attachCustomerTimer(timer: MockTimer.self)
        
        readerViewController.beginCountdown()
        
        MockTimer.currentTimer.fire()
        MockTimer.currentTimer.fire()
        MockTimer.currentTimer.fire()
        
        XCTAssertEqual(readerViewController.readingText!.text, "1")
    }
    
    // MARK : Test Reading Sequence
    
    func testReadingSequence_IsCalculatedCorrectly() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let readerViewController = storyboard.instantiateViewController(withIdentifier: "ReaderViewController") as! ReaderViewController
        readerViewController.loadView()

        readerViewController.attachCustomerTimer(timer: MockTimer.self)
        
        readerViewController.read()
        
        XCTAssertEqual(MockTimer.interval, 0.13333334028720856)
    }
    
    func testReadingSequence_AfterFirstTick_IsExpectedWord() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let readerViewController = storyboard.instantiateViewController(withIdentifier: "ReaderViewController") as! ReaderViewController
        readerViewController.loadView()

        readerViewController.attachCustomerTimer(timer: MockTimer.self)
        readerViewController.textToRead = "Hello World"
        
        readerViewController.read()
        
        MockTimer.currentTimer.fire()
        
        XCTAssertEqual(readerViewController.readingText!.text, "Hello")
    }
    
    func testReadingSequence_AfterSecondTick_IsExpectedWord() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let readerViewController = storyboard.instantiateViewController(withIdentifier: "ReaderViewController") as! ReaderViewController
        readerViewController.loadView()

        readerViewController.attachCustomerTimer(timer: MockTimer.self)
        readerViewController.textToRead = "Hello World"
        
        readerViewController.read()
        
        MockTimer.currentTimer.fire()
        MockTimer.currentTimer.fire()
        
        XCTAssertEqual(readerViewController.readingText!.text, "World")
    }
    
    func testReadingSequence_AfterReadingAllWordsSummary_IsDisplayed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let readerViewController = storyboard.instantiateViewController(withIdentifier: "ReaderViewController") as! ReaderViewController
        readerViewController.loadView()
        
        let textToRead = "Hello World"

        readerViewController.attachCustomerTimer(timer: MockTimer.self)
        readerViewController.textToRead = textToRead
        readerViewController.wpm = 300
        
        readerViewController.read()
        
        MockTimer.currentTimer.fire()
        MockTimer.currentTimer.fire()
        MockTimer.currentTimer.fire()

        XCTAssertEqual(readerViewController.readingText!.text, "You read " + String(textToRead.split(separator: " ").count) + " words at 300wpm!")
    }
    
    func testReadingSequence_DisplaysDoneButton_WhenReadingFinished() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let readerViewController = storyboard.instantiateViewController(withIdentifier: "ReaderViewController") as! ReaderViewController
        readerViewController.loadView()
        
        let textToRead = "Hello World"

        readerViewController.attachCustomerTimer(timer: MockTimer.self)
        readerViewController.textToRead = textToRead
        
        readerViewController.read()
        
        MockTimer.currentTimer.fire()
        MockTimer.currentTimer.fire()
        MockTimer.currentTimer.fire()
        
        XCTAssertFalse(readerViewController.doneButton.isHidden)
    }
    
    func testReadingSequence_InvalidatesTimer_WhenFinished() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let readerViewController = storyboard.instantiateViewController(withIdentifier: "ReaderViewController") as! ReaderViewController
        readerViewController.loadView()
        
        let textToRead = "Hello World"

        readerViewController.attachCustomerTimer(timer: MockTimer.self)
        readerViewController.textToRead = textToRead
        
        readerViewController.read()
        
        MockTimer.currentTimer.fire()
        MockTimer.currentTimer.fire()
        MockTimer.currentTimer.fire()
        
        XCTAssertNil(MockTimer.currentTimer)
    }
}
