
//
//  Common.h
//  Control
//
//  Created by 大明 on 2017/1/20.
//  Copyright © 2017年 大明. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define Video_Track_Height 60
#define Audio_Track_Height 44
#define Ttile_Track_Height 36
#define Track_Padding 5.0f

#define ThumbnailCreatedNotification @"THThumbnailCreated"

#define FilterSelectionChangedNotification @"filter_selection_changed"

#define IS_IPHONE4 (SCREEN_HEIGHT == 480)
#define IS_IPHONE5 (SCREEN_HEIGHT == 568)
#define IS_IPHONE47 (SCREEN_HEIGHT == 667)
#define IS_IPHONE55 (SCREEN_HEIGHT == 736)
#define IS_IPHONEX (SCREEN_HEIGHT >= 812)


#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorAlFromRGB(rgbValue,aL) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:aL]

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)


#define WeakSelf __block __weak typeof(self)weakSelf = self;

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds


#define  iPhone4_4s     (SCREEN_WIDTH == 320.f && SCREEN_HEIGHT == 480.f ? YES : NO)

#define  iPhone5_5s     (SCREEN_WIDTH == 320.f && SCREEN_HEIGHT == 568.f ? YES : NO)

#define  iPhone6_6s     (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 667.f ? YES : NO)

#define  iPhone6_6sPlus (SCREEN_WIDTH == 414.f && SCREEN_HEIGHT == 736.f ? YES : NO)

#define  iPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ? YES : NO

#define NavigationBarBackgroundColor [UIColor whiteColor]

/**  判断文字中是否包含表情 */
#define IsTextContainFace(text) [text containsString:@"["] &&  [text containsString:@"]"] && [[text substringFromIndex:text.length - 1] isEqualToString:@"]"]

/** 判断emoji下标 */
#define emojiText(text)  (text.length >= 2) ? [text substringFromIndex:text.length - 2] : [text substringFromIndex:0]

//ChatKeyBoard背景颜色
#define MessagesInputToolbarBackgroundColor  [UIColor colorWithWhite:0.98 alpha:0.9]

#define MessagesInputToolbarLineViewColor  [UIColor colorWithWhite:0.84 alpha:1.0]

#define MessagesCircleBlueColor    [UIColor colorWithRed:104 / 255.0 green:158 / 255.0 blue:255 / 255.0 alpha:1.0]

#define iPhoneXBottomMargin             39
#define iPhoneXBottomHeight             88
#define iPhoneXTopMargin             24
//表情模块高度
#define kFacePanelHeight                216
#define kFacePanelBottomToolBarHeight   40
#define kUIPageControllerHeight         25

//拍照、发视频等更多功能模块的面板的高度
#define kMorePanelHeight                216
#define kMoreItemH                      80
#define kMoreItemIconSize               56


#define isIPhone4_5                (kScreenWidth == 320)
#define isIPhone6_6s               (kScreenWidth == 375)
#define isIPhone6p_6sp             (kScreenWidth == 414)

#define AppleTableViewCellMargin  20

#define CellCornerRadius  10

#define LineWidth  1 / [UIScreen mainScreen].scale

#define PAN_DISTANCE 120
#define CARD_WIDTH 300
#define CARD_HEIGHT 400

#define SCALE SCREEN_WIDTH/375.0

#define LineSpacing   36.0
#define ZoomScale  1.20
#define MinZoomScale  (ZoomScale - 1.0)
#define ImageScale  (1000.0 / 1000.0)


#define CornerRadius  10

#define ViewCornerRadius  12

#define ButtonHeight  44

#define MapViewLeftMargin 32
#define BusLinePaddingEdge 20
#define ViewForTopMargin 280
#define SearchViewShowHeight 256
#define SearchViewDefaultHeight 64

#define SearchViewBottomFrame  CGRectMake(0, self.view.bounds.size.height - SearchViewDefaultHeight, self.view.bounds.size.width, self.view.bounds.size.height - ViewForTopMargin)

#define ViewCentrePositionFrame  CGRectMake(0, self.view.bounds.size.height - SearchViewShowHeight, self.view.bounds.size.width, self.view.bounds.size.height - ViewForTopMargin)

#define ViewTopPositionFrame  CGRectMake(0, ViewForTopMargin, self.view.bounds.size.width, self.view.bounds.size.height - ViewForTopMargin)

#define ViewBottomPositionFrame  CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height - ViewForTopMargin)

#define SearchHistoriesPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"SearchHistories.plist"] // 搜索历史存储路径


#define iPhone5AndEarlyDevice (([[UIScreen mainScreen] bounds].size.height*[[UIScreen mainScreen] bounds].size.width <= 320*568)?YES:NO)
#define Iphone6 (([[UIScreen mainScreen] bounds].size.height*[[UIScreen mainScreen] bounds].size.width <= 375*667)?YES:NO)

#define MessagesCircleGreenColor    UIColorFromRGB(0x3dcf94)
#define MessagesCircleGreenColor5    UIColorFromRGB(0x25cfaa)

#define MessagesCircleRedColor    UIColorFromRGB(0xff6876)
#define MessagesCircleRedColor1    UIColorFromRGB(0xf47778)
#define MessagesCircleRedColor2    UIColorFromRGB(0xff7c1f)
#define MessagesCircleRedColor4    UIColorFromRGB(0xff3947)
#define MessagesCircleRedColor6    UIColorFromRGB(0xfc6453)

#define MessagesCircleBlackColor    UIColorFromRGB(0x333333)
#define MessagesCircleBlackColor1    UIColorFromRGB(0x999999)
#define MessagesCircleBlackColor2    UIColorFromRGB(0x363636)
#define MessagesCircleBlackColor3    UIColorFromRGB(0x666666)
#define MessagesCircleBlackColor4    UIColorFromRGB(0xececec)
#define MessagesCircleBlackColor5    UIColorFromRGB(0xf5f5f5)

#define Color1   UIColorFromRGB(0xFF8F8F)
#define Color2   UIColorFromRGB(0xA08FFF)
#define Color3   UIColorFromRGB(0x8FB6FF)
#define Color4   UIColorFromRGB(0x65CDA3)
#define Color5   UIColorFromRGB(0x6892ff)

#define AppleBlueColor [UIColor colorWithRed:0 green:122 / 255.0 blue:1 alpha:1.0]

#define AppleGreenColor [UIColor colorWithRed:0 green:204 / 255.0 blue:71 / 255.0 alpha:1.0]

#define AppleTableViewBackgroundColor  [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:244 / 255.0 alpha:1.0]

#define AppleTableViewCellBackgroundColor  [UIColor colorWithRed:254 / 255.0 green:255 / 255.0 blue:254 / 255.0 alpha:1.0]

#define AppleTableViewLineColor  [UIColor colorWithRed:200 / 255.0 green:199 / 255.0 blue:204 / 255.0 alpha:1.0]


#define PNLightGreen    [UIColor colorWithRed:77.0 / 255.0 green:216.0 / 255.0 blue:122.0 / 255.0 alpha:1.0f]
#define PNRed           [UIColor colorWithRed:245.0 / 255.0 green:94.0 / 255.0 blue:78.0 / 255.0 alpha:1.0f]
#define PNYellow        [UIColor colorWithRed:242.0 / 255.0 green:197.0 / 255.0 blue:117.0 / 255.0 alpha:1.0f]
#define PNStarYellow    [UIColor colorWithRed:252.0 / 255.0 green:223.0 / 255.0 blue:101.0 / 255.0 alpha:1.0f]



#endif /* Common_h */
