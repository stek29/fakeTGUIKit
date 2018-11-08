import Cocoa

struct FontConfig {
  var FontFamily = "Comic Sans MS"
  var SizeFactor: CGFloat = 1.0
}

private let Config: FontConfig = {
  var config = FontConfig()
  if let path = Bundle.main.path(forResource: "FontConfig", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
    if let fontFamily = dict["FontFamily"] as? String {
      if let font = NSFont(name: fontFamily, size: 10) {
        config.FontFamily = fontFamily
      } else {
        NSLog("Found invalid FontFamily in FontConfig: \(fontFamily)")
      }
    }
    if let sizeFactor = dict["SizeFactor"] as? Double {
      config.SizeFactor = CGFloat(sizeFactor)
    }
  } else {
    NSLog("FontConfig not found!")
  }
  return config
}()

public func systemFont(_ size:CGFloat) ->NSFont {
  return NSFontManager.shared.font(withFamily: Config.FontFamily, traits: [], weight: Int(NSFont.Weight.regular.rawValue), size: size*Config.SizeFactor)!
}

public func systemMediumFont(_ size:CGFloat) ->NSFont {
  return NSFontManager.shared.convertWeight(true, of: systemFont(size))
}

public func systemBoldFont(_ size:CGFloat) ->NSFont {
  return NSFontManager.shared.convertWeight(true, of: systemMediumFont(size))
}

public extension NSFont {
  public static func normal(_ size:FontSize) ->NSFont {
    return TGUIKit.systemFont(size)
  }

  public static func italic(_ size: FontSize) -> NSFont {
    return NSFontManager.shared.convert(.normal(size), toHaveTrait: .italicFontMask)
  }

  public static func avatar(_ size: FontSize) -> NSFont {
    return .medium(size)
  }

  public static func medium(_ size:FontSize) ->NSFont {
    return TGUIKit.systemMediumFont(size)
  }

  public static func bold(_ size:FontSize) ->NSFont {
    return TGUIKit.systemBoldFont(size)
  }

  public static func code(_ size:FontSize) ->NSFont {
    return NSFont(name: "Menlo-Regular", size: size) ?? TGUIKit.systemFont(17.0)
  }
}

public typealias FontSize = CGFloat
