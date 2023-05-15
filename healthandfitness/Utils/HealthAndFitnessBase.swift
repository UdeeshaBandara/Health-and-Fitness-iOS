//
//  HealthAndFitnessBase.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-05.
//

import Foundation
import UIKit
import SwiftMessages

class HealthAndFitnessBase{

    static let shared = HealthAndFitnessBase()

    private init(){}

    public static let BaseURL : String = "https://gym-api-ixep.onrender.com/"




    func showToastMessage (title : String = "", message : String = "", type : Int = 1) {

        let view = MessageView.viewFromNib(layout: .cardView)

        switch type {
        case 0:
            view.configureTheme(.success)
        case 1:
            view.configureTheme(.warning)
        case 2:
            view.configureTheme(.error)
        default:
            view.configureTheme(.warning)
        }

        view.configureDropShadow()

        view.configureContent(title: title, body: message)

        view.layoutMarginAdditions = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)

        view.button?.isHidden = true

        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10


        SwiftMessages.show(view: view)
    }


}

extension UITextField {

    func updateDesign()  {

        self.font = UIFont(name: "Roboto-Regular", size: 16)
        self.textAlignment = .left
        self.layer.backgroundColor = #colorLiteral(red: 0.1333574951, green: 0.1360867321, blue: 0.1390593946, alpha: 0.07)
        self.layer.cornerRadius = 5
        self.textColor = #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)
        self.autocorrectionType = .yes
        self.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)


    }


}
extension UILabel
{
    func addImage(imageName: String, afterLabel bolAfterLabel: Bool = false)
    {
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)

        if (bolAfterLabel)
        {
            let strLabelText: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
            strLabelText.append(attachmentString)

            self.attributedText = strLabelText
        }
        else
        {
            let strLabelText: NSAttributedString = NSAttributedString(string: self.text!)
            let mutableAttachmentString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)

            self.attributedText = mutableAttachmentString
        }
    }

    func removeImage()
    {
        let text = self.text
        self.attributedText = nil
        self.text = text
    }
}
class PaddingLabel: UILabel {

    var topInset: CGFloat
    var bottomInset: CGFloat
    var leftInset: CGFloat
    var rightInset: CGFloat

    required init(withInsets top: CGFloat, _ bottom: CGFloat,_ left: CGFloat,_ right: CGFloat) {
        self.topInset = top
        self.bottomInset = bottom
        self.leftInset = left
        self.rightInset = right
        super.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}
extension UIView {

    func applyGradient(isVertical: Bool, colorArray: [UIColor]) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        if isVertical {
            //top to bottom
            gradientLayer.locations = [0.0, 1.0]
        } else {
            //left to right
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }

        backgroundColor = .clear
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }

}
