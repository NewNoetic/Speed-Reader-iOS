import UIKit

class ReaderViewController: UIViewController {
    @IBOutlet weak var readingText: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var wpm: Float = 450.0;
    var textToRead = ""
    var timer: Timer.Type = Timer.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginCountdown()
    }
    
    func beginCountdown(){
        var countdown = 3

        timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if(countdown == 0){
                timer.invalidate()
                self.read()
                return
            }
            
            self.readingText.text = String(countdown)
            countdown -= 1
        }
    }
    
    func calculateIntervalBetweenWordsInSeconds(wordsPerMin: Float) -> TimeInterval {
        return TimeInterval(60/wpm)
    }
    
    func read(){
        let data = textToRead.split(separator: " ")
        let wordsInterval = calculateIntervalBetweenWordsInSeconds(wordsPerMin: self.wpm)
        
        var index = 0

        timer.scheduledTimer(withTimeInterval: wordsInterval, repeats: true) { timer in
            if(index == data.count){
                timer.invalidate()
                self.readingText.text = "You read " + String(data.count) + " words at " + String(format: "%gwpm", self.wpm) + "!"
                self.readingText.font = self.readingText.font.withSize(14)
                self.doneButton.isHidden = false
                return
            }
            
            self.readingText.text = String(data[index])
            index += 1
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func attachCustomerTimer(timer: Timer.Type) {
        self.timer = timer
    }
}

