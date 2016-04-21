//
//  BMButtonConst.h
//  BMButton
//
//  Created by Bob on 16/4/21.
//  Copyright © 2016年 Bob. All rights reserved.
//


//屏幕的宽
#define screen_width [UIScreen mainScreen].bounds.size.width
//屏幕的高
#define screen_height [UIScreen mainScreen].bounds.size.height

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define BG_COLOR  RGBColor(239, 239, 244)

#define GridCol 4.0

#define ButtonWidth   (screen_width)/GridCol

#define ButtonHeight  (screen_width)/GridCol

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
