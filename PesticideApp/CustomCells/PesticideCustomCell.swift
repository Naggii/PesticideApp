//
//  NouyakuCustomCell.swift
//  NouyakuApp
//
//  Created by 永井歩武 on 2022/10/18.
//

import UIKit

class PesticideCustomCell: UITableViewCell {
    @IBOutlet weak var txtNouyakuCount: UILabel!
    @IBOutlet weak var imgNouyaku: UIImageView!
    @IBOutlet weak var txtNouyakuName: UILabel!
    @IBOutlet weak var stepperNouyaku: UIStepper!
    @IBOutlet weak var txtLimitCounter: UILabel!
    
    var nouyakuLimit = 0
    var calcLimit = 0
    
    @IBAction func changeStepperValue(sender: UIStepper) {
        calcNouyakuLimit(num: Int(sender.value))
        stepperNouyaku.maximumValue = Double(nouyakuLimit)
        if Int(sender.value) == nouyakuLimit {
            txtNouyakuCount.textColor = .red
            txtNouyakuCount.text = "\(Int(sender.value))"
        } else {
            txtNouyakuCount.textColor = .black
            txtNouyakuCount.text = "\(Int(sender.value))"
        }
    }
    
    private func calcNouyakuLimit(num: Int) {
        calcLimit = nouyakuLimit - num
        txtLimitCounter.text = "残回数: \(calcLimit)"
        if (nouyakuLimit - num <= 3) {
            txtLimitCounter.addAccent(pattern: "\(calcLimit)", color: .red)
        } else {
            txtLimitCounter.textColor = .black
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
