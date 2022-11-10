//
//  NouyakuCustomCell.swift
//  NouyakuApp
//
//  Created by 永井歩武 on 2022/10/18.
//

import UIKit
import RealmSwift

protocol TappedDelegate {
    func tappedNouyakuImage(indexPath: IndexPath)
    func cellChangedValue(tapCount: Int, indexPath: IndexPath)
}

class PesticideCustomCell: UITableViewCell {
    @IBOutlet weak var txtNouyakuCount: UILabel!
    @IBOutlet weak var imgNouyaku: UIImageView!
    @IBOutlet weak var txtNouyakuName: UILabel!
    @IBOutlet weak var stepperNouyaku: UIStepper!
    @IBOutlet weak var txtLimitCounter: UILabel!
    
    var nouyakuLimit = 0
    var delegate: TappedDelegate?
    var cellIndexPath: IndexPath?
    let realm = try! Realm()
    var showInt: Double = 0.0
    
    @IBAction func changeStepperValue(sender: UIStepper) {
        calcNouyakuLimit(num: Int(sender.value))
        stepperNouyaku.maximumValue = Double(nouyakuLimit)
        txtNouyakuCount.text = "\(Int(sender.value))"
        if Int(sender.value) == nouyakuLimit {
            txtNouyakuCount.textColor = .red
        } else {
            txtNouyakuCount.textColor = .black
        }
    }
    
    private func calcNouyakuLimit(num: Int) {
        delegate?.cellChangedValue(
            tapCount: num,
            indexPath: cellIndexPath!
        )
        txtLimitCounter.text = "残回数: \(nouyakuLimit - num)"
        if (nouyakuLimit - num <= 3) {
            txtLimitCounter.addAccent(pattern: "\(nouyakuLimit - num)", color: .red)
        } else {
            txtLimitCounter.textColor = .black
        }
    }
    
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        imgNouyaku.tappedAnimation()
        delegate?.tappedNouyakuImage(indexPath: cellIndexPath!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stepperNouyaku.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        imgNouyaku.isUserInteractionEnabled = true
        imgNouyaku.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:))))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
