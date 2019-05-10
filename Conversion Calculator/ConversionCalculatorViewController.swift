import UIKit

class ConversionCalculatorViewController: UIViewController{
    
    
    @IBOutlet weak var outputDisplayUnit: UITextView!
    @IBOutlet weak var inputDisplayUnit: UITextView!

    @IBOutlet weak var outputDisplay: UITextField!
    @IBOutlet weak var inputDisplay: UITextField!
    
    struct conversion{
        var  label: String
        var inputUnit: String
        var outputUnit: String
    }
    
    var conversionCalc = ConversionCalculations()
    var stringToDouble: Double? = 0
    var outputDouble: Double? = -1
    var conversionNumber: String = ""
    
    let converters = [conversion(label: "fahrenheit to celcius", inputUnit: "°F", outputUnit: "°C"),
                      conversion(label: "celcius to fahrenheit", inputUnit: "°C", outputUnit: "°F"),
                      conversion(label: "miles to kilometers", inputUnit: "mi", outputUnit: "km"),
                      conversion(label: "kilometers to miles", inputUnit: "km", outputUnit: "mi")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let initialConverter = converters[0]
        
        outputDisplayUnit.text = initialConverter.outputUnit
        inputDisplayUnit.text = initialConverter.inputUnit
    }
    
    @IBAction func convert(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Choose Converter", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: converters[0].label, style: UIAlertAction.Style.default, handler:{ (UIAlertAction)-> Void in
            self.outputDisplayUnit.text = self.converters[0].outputUnit
            self.inputDisplayUnit.text = self.converters[0].inputUnit
            self.outputDisplay.text = String(self.conversionCalc.fToC(farenheit: (self.stringToDouble!)))
        }
        ))
        alert.addAction(UIAlertAction(title: converters[1].label, style: UIAlertAction.Style.default, handler:{ (UIAlertAction)-> Void in
            self.outputDisplayUnit.text = self.converters[1].outputUnit
            self.inputDisplayUnit.text = self.converters[1].inputUnit
            self.outputDisplay.text = String(self.conversionCalc.cToF(celsius: self.stringToDouble!))
        }
        ))
        alert.addAction(UIAlertAction(title: converters[2].label, style: UIAlertAction.Style.default, handler:{ (UIAlertAction)-> Void in
            self.outputDisplayUnit.text = self.converters[2].outputUnit
            self.inputDisplayUnit.text = self.converters[2].inputUnit
            self.outputDisplay.text = String(self.conversionCalc.mtoKm(mile: self.stringToDouble!))
        }
        ))
        alert.addAction(UIAlertAction(title: converters[3].label, style: UIAlertAction.Style.default, handler:{ (UIAlertAction)-> Void in
            self.outputDisplayUnit.text = self.converters[3].outputUnit
            self.inputDisplayUnit.text = self.converters[3].inputUnit
            self.outputDisplay.text = String(self.conversionCalc.kmToM(kilometer: self.stringToDouble!))


        }
        ))
        
        self.present(alert, animated: true, completion: nil)
    }
    

    @IBAction func numberInput(_ sender: UIButton) {
        self.inputDisplay.text = self.inputDisplay.text! + String(sender.tag-1)
        stringToDouble = Double(self.inputDisplay.text!)!
        
        conversionNumber = String(stringToDouble!)
        
        if self.inputDisplayUnit.text! == "°F"{
            outputDouble = conversionCalc.fToC(farenheit: stringToDouble!)
        }
        if self.inputDisplayUnit.text! == "°C"{
            outputDouble = conversionCalc.cToF(celsius: stringToDouble!)
        }
        if self.inputDisplayUnit.text! == "mi"{
            outputDouble = conversionCalc.mtoKm(mile: stringToDouble!)
        }
        if self.inputDisplayUnit.text! == "km"{
            outputDouble = conversionCalc.kmToM(kilometer: stringToDouble!)
        }
        self.outputDisplay.text = String(outputDouble!)
        
    }

    
    @IBAction func clearInput(_ sender: UIButton) {
        self.inputDisplay.text = ""
        self.outputDisplay.text = ""
        conversionNumber = ""
        stringToDouble = 0

    }
    
    @IBAction func changeState(_ sender: UIButton) {
        stringToDouble = -stringToDouble!
    
        let tempDouble = String(format: "%g", stringToDouble!)
        conversionNumber = tempDouble
        self.inputDisplay.text = tempDouble
        
    }
    @IBAction func decimalButton(_ sender: UIButton) {
        conversionNumber = self.inputDisplay.text! + "."
        self.inputDisplay.text! = conversionNumber
    }
}
