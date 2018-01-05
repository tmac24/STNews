//
//  STEasyMacro.h
//  STNews
//
//  Created by readygo on 2018/1/5.
//  Copyright © 2018年 suntao. All rights reserved.
//

#ifndef STEasyMacro_h
#define STEasyMacro_h

/** 字体*/
#define STFont(x) [UIFont systemFontOfSize:x]
#define STBoldFont(x) [UIFont boldSystemFontOfSize:x]

/** 颜色*/
#define STRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define STRGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define STRGB16Color(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/** 输出*/
#ifdef DEBUG
#define STLog(...) NSLog(__VA_ARGS__)
#else
#define STLog(...)
#endif

/** 获取硬件信息*/
#define STSCREEN_W [UIScreen mainScreen].bounds.size.width
#define STSCREEN_H [UIScreen mainScreen].bounds.size.height
#define STCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define STCurrentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]


/** 适配*/
#define STiOS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define STiOS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define STiOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define STiOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define STiOS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

#define STiPhone4_OR_4s    (STSCREEN_H == 480)
#define STiPhone5_OR_5c_OR_5s   (STSCREEN_H == 568)
#define STiPhone6_OR_6s   (STSCREEN_H == 667)
#define STiPhone6Plus_OR_6sPlus   (STSCREEN_H == 736)
#define STiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** 弱指针*/
#define STWeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;

/** 加载本地文件*/
#define STLoadImage(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
#define STLoadArray(file,type) [UIImage arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
#define STLoadDict(file,type) [UIImage dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]

/** 多线程GCD*/
#define STGlobalGCD(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define STMainGCD(block) dispatch_async(dispatch_get_main_queue(),block)

/** 数据存储*/
#define STUserDefaults [NSUserDefaults standardUserDefaults]
#define STCacheDir [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define STDocumentDir [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define STTempDir NSTemporaryDirectory()

/** 打印输出信息*/
#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

#endif /* STEasyMacro_h */
