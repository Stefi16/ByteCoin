import UIKit

class BitcoinViewController: UIViewController {

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.coinManagerDelegate = self
        
        currencyPicker.delegate?.pickerView?(currencyPicker, didSelectRow: 0, inComponent: 0)
    }
}

//MARK: - UIPickerViewDataSource & UIPickerViewDelegate
extension BitcoinViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return coinManager.currencyArray[row]
        }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currencies = coinManager.currencyArray
        coinManager.getCoinPrice(for: currencies[row])
    }
}

//MARK: - CoinManagerDelegate
extension BitcoinViewController: CoinManagerDelegate {
    func didUpdatePrice(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(format: "%.2f", coin.rate)
            self.currencyLabel.text = coin.currency
        }
    }
    
    func didFinishWithError(_ error: any Error) {
        print(error)
    }
}

