import Foundation

class MockTimer: Timer {
    static var currentTimer: MockTimer!
    static var interval: TimeInterval = TimeInterval(0)

    var block: ((Timer) -> Void)!

    override func invalidate() {
        MockTimer.currentTimer = nil
    }

    override func fire() {
        block(self)
    }
    
    override open class func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer {
        let mockTimer = MockTimer()
        
        mockTimer.block = block
        
        self.currentTimer = mockTimer
        self.interval = interval
    
        return mockTimer
    }
}
