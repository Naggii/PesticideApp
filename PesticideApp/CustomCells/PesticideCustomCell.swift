//
//  NouyakuCustomCell.swift
//  NouyakuApp
//
//  Created by 永井歩武 on 2022/10/18.
//

import UIKit

class PesticideCustomCell: UITableViewCell, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var txtNouyakuCount: UILabel!
    @IBOutlet weak var imgNouyaku: UIImageView!
    @IBOutlet weak var stepperNouyaku: UIStepper!
    
    @IBAction func changeStepperValue(sender: UIStepper) {
        txtNouyakuCount.text = "\(Int(sender.value))"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
