import UIKit

class LocalizableLabel: UILabel {
    
    private var localizeKey: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        localizeKey = text
        text = localizeKey
        print("---------Vào awakeFromNib của LocalizableLabel---------")
    }
    
    override public var text: String?  {
//        print("-------Vào Text LocalizableLabel--------")
        set (newValue) {
            localizeKey = newValue
            super.text = LocalizationHelper.shared.localized(localizeKey)
            print("----------set----------")
            print(LocalizationHelper.shared.localized(localizeKey))
        }
        get {
            print("-----get-----")
            print(text)
            return super.text
        }
    }
    
    
    override func onUpdateLocale() {
        super.onUpdateLocale()
        print("------------Vào onUpdateLocale của LocalizableLabel------------")
        text = localizeKey
        print(text)
    }

}
