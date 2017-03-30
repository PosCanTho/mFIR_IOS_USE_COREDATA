import Foundation

let LangEN = "en"
let LangJA = "ja"
let LangVI = "vi"

class LocalizationHelper {
    
    private var enBundle: Bundle?
    private var jaBundle: Bundle?
    private var viBundle: Bundle?
    
    init() {
        let enBundlePath = Bundle.main.path(forResource: LangEN, ofType: "lproj")
        enBundle = Bundle(path: enBundlePath!)
        let jaBundlePath = Bundle.main.path(forResource: LangJA, ofType: "lproj")
        jaBundle = Bundle(path: jaBundlePath!)
        let viBundlePath = Bundle.main.path(forResource: LangVI, ofType: "lproj")
        viBundle = Bundle(path: viBundlePath!)
    }
    
    static let shared = LocalizationHelper()
    
    func localized(_ key: String?) -> String? {
        guard let key = key else {
            return nil
        }
        var bundle: Bundle?
        switch Prefs.shared.currentLocale() {
        case LangVI:
            bundle = viBundle
        case LangJA:
            bundle = jaBundle
        default:
            bundle = enBundle
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle!, value: key, comment: key)
    }
    
    func en(_ key: String) -> String {
        return NSLocalizedString(key, tableName: nil, bundle: enBundle!, value: key, comment: key)
    }
    
    func ja(_ key: String) -> String {
        return NSLocalizedString(key, tableName: nil, bundle: enBundle!, value: key, comment: key)
    }
    
    func vi(_ key: String) -> String {
        return NSLocalizedString(key, tableName: nil, bundle: enBundle!, value: key, comment: key)
    }
    
    func localized(_ key: String, _ locale: String) -> String {
        var bundle: Bundle?
        switch locale {
        case LangVI:
            bundle = viBundle
        case LangJA:
            bundle = jaBundle
        default:
            bundle = enBundle
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle!, value: key, comment: key)
    }
    
}
