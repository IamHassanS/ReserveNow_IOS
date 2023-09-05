
import UIKit

class PrimaryButton: UIButton {
    func customColorsUpdate() {
        self.backgroundColor = .appGuestThemeColor
        self.tintColor = .appGuestThemeColor
        self.setTitleColor(.appGuestThemeColor, for: .normal)
        self.titleLabel?.setFont(font: .medium(size: .BODY))
        self.clipsToBounds = true
        self.cornerRadius = 15
    }
    override func awakeFromNib() {
        self.customColorsUpdate()
    }
}

class SecondaryButton : UIButton {
    func customColorsUpdate() {
        self.backgroundColor = .appHostThemeColor
        self.setTitleColor(.appHostThemeColor ,
                           for: .normal)
        self.tintColor = .appHostThemeColor
        self.titleLabel?.setFont(font: .medium(size: .BODY))
    }
    override func awakeFromNib() {
        self.customColorsUpdate()
    }
}
