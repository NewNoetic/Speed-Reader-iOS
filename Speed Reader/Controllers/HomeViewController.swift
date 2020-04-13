import UIKit

// https://www.techotopia.com/index.php/Creating_an_iOS_8_Action_Extension
class HomeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var readyButton: UIButton!
    @IBOutlet weak var textToSpeedRead: UITextView!
    @IBOutlet weak var wpmSlider: UISlider!
    @IBOutlet weak var wpmSliderLabel: UILabel!

    var wpm: Float = 450.0
    var textToSpeedReadPlaceholder = "Enter/Paste text to speed read here..."

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        self.view.addGestureRecognizer(tap)

        self.applyTextFieldStyles()
        self.applyReadyButtonStyles()
    }
    
    @IBAction func wpmSliderValueChanged(_ sender: Any) {
        let steppedWPMValue = round(wpmSlider.value / 50) * 50
        
        wpm = steppedWPMValue
        wpmSliderLabel.text = String(format: "%gwpm", steppedWPMValue)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        self.textToSpeedRead.text = ""
    }
    
    // TODO: Test this method
    @IBAction func pasteButtonTapped(_ sender: Any) {
        let pasteboardString: String? = UIPasteboard.general.string
        if let textToRead = pasteboardString {
            textToSpeedRead.text = textToRead
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let readerViewController = segue.destination as? ReaderViewController
        readerViewController?.wpm = self.wpm
        readerViewController?.textToRead = self.textToSpeedRead.text
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textToSpeedRead.text == textToSpeedReadPlaceholder {
            textToSpeedRead.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textToSpeedRead.text == "" {
            textToSpeedRead.text = textToSpeedReadPlaceholder
        }
    }

    func applyTextFieldStyles(){
        self.textToSpeedRead.delegate = self
        self.textToSpeedRead.layer.cornerRadius = 10
        self.textToSpeedRead.clipsToBounds = true
        self.textToSpeedRead.layer.borderWidth = 1
        self.textToSpeedRead.layer.borderColor = UIColor(red:0.23, green:0.17, blue:0.26, alpha:1.00).cgColor
        self.textToSpeedRead.text = textToSpeedReadPlaceholder
        self.textToSpeedRead.textColor = UIColor.white
    }
    
    func applyReadyButtonStyles(){
        readyButton.layer.borderWidth = 1
        readyButton.layer.cornerRadius = 10
        readyButton.clipsToBounds = true
    }
}


