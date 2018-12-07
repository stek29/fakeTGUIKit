# Fake TGUIKit font changer

Telegram macOS native app font replacement
simple PoC just for lulz, uses `LD_REEXPORT_DYLIB` dylib hijacking to
override only selected functions.

![Preview with Comic Sans MS](preview.png?raw=true)

> чуть \*\*\* не умер  
> сердец болит  
> руки дрожат  
> такого издевательства над системой и телеграмом я еще не видел  
> от шрифта хочется умереть  
> ну \*\*\*, я конечно понимаю не у всех чувство прекрасного развито,
> чтоб на столько плохо - я думал это сказки.  
> разработчики потратили сотни часов, чтоб появилась возможность
> кастомизации, а вы вот используете ее так.


# Installation
- Run mkempty.sh
- Open TGUIKit.xcodeproj
- Build
- Use patcher.sh

# Usage
With no configuration Font would be replaced with Comic Sans MS.

Go to Telegram.app/Contents/Resources and create FontConfig.plist:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>FontFamily</key>
	<string>Helvetica</string>
	<key>SizeFactor</key>
	<real>1.1</real>
</dict>
</plist>
```

Where:
- FontFamily (Helvetica) is Font Family to use. You can get font family
  from font file by checking Full name in Finder's Get Info.
- SizeFactor (1.1) is the factor for font sizes. Some fonts are smaller
  than others with same font size, so you might need to adjust the size
  factor. But for most fonts 1 should work the best.

You can add more fonts to Telegram.app/Contents/Resources/fonts.

# License
MIT, or GPL if MIT violates TG license. I'm not a lawyer.
