//
//  HeadFile.h
//
//  Created by coderss on 15/4/18.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#ifndef ____2_HeadFile_h
#define ____2_HeadFile_h
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#import "AFNetworking.h"
#import "UIButton+WebCache.h"
#import "ProgressHUD.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "Tool.h"
#import "MyKit.h"
#import <BaiduMapAPI/BMapKit.h>
#define  RESIONURL @"http://ly.coderss.cn/index.php?m=Cwl&a=selectregion&parent_id=%d&page=%@&isPage=%d"
#define VIEWDETAILURL @"http://ly.coderss.cn/index.php?m=Cwl&a=selectNewView&Regin_id=%@&page=%@"
#define YUMING @"http://ly.coderss.cn/%@"
#define IMAGEYUMING @"http://ly.coderss.cn%@"
#define VIEWURL @"http://ly.coderss.cn/index.php?m=Cwl&a=selectDetailView&Viewid=%d"
//返回线路信息
#define WAYURL @"http://ly.coderss.cn/index.php?m=Cwl&a=selectway&teamid=%@"
#import "RefreshControl.h"
//旅游团的网址
#define SUREURL @"http://ly.coderss.cn/index.php/Base/verify.html"
#define TOURTEAMURL @"http://ly.coderss.cn/index.php?m=Cwl&a=selectTourTeam"
#define RESGINEURL @"http://ly.coderss.cn/index.php?m=Cwl&a=userresgin"//注册用户
#define LOGINURL @"http://ly.coderss.cn/index.php?m=Cwl&a=login"//登录用户
#define USERINFOURL @"http://ly.coderss.cn/index.php?m=Cwl&a=readUserInfo&UserId=%@"
#define MODIFYUSERURL @"http://ly.coderss.cn/index.php?m=Cwl&a=modeifyUserInfo"

#define MODIFUSERHEADIMAGE @"http://ly.coderss.cn/index.php?m=Cwl&a=modeifyUserHeadImage"
#define     WAYINVIEWURL @"http://ly.coderss.cn/index.php?m=Cwl&a=findViewWay&ViewId=%@"
#define VIEWADVICEURL @"http://ly.coderss.cn/index.php?m=Cwl&a=showAdvice&ViewId=%@&page=%@"//景点评论
#define USERADVICEVIEWURL @"http://ly.coderss.cn/index.php?m=Cwl&a=AdviceToView"//用户评论景点
#define USERADVICETUANURL @"http://ly.coderss.cn/index.php?m=Cwl&a=AdviceToTuan"//用户评论旅游路线
#define USERADVICEWAYURL @"http://ly.coderss.cn/index.php?m=Cwl&a=UserAdviceToView"
#define HOTURL @"http://ly.coderss.cn/index.php?m=Cwl&a=hotInformation"
#define TICKETURL @"http://ly.coderss.cn/index.php?m=Cwl&a=TicketInFor&page=%@"
#define CONNUSERURL @"http://ly.coderss.cn/index.php?m=Cwl&a=ConnPepole"//写入常用联系人
#define READCONNURL @"http://ly.coderss.cn/index.php?m=Cwl&a=ReadPeople&UserId=%@"//读取常用联系人
#define USERPHOTOURL @"http://ly.coderss.cn/index.php?m=Cwl&a=receivePhotoFromUser&UserId=%@"//上传评论照片
#define READHOTOLURL @"http://ly.coderss.cn/index.php?m=Cwl&a=ReadHotol"//读出旅馆信息
#define READPHOTOBYUSER @"http://ly.coderss.cn/index.php?m=Cwl&a=ReadPhoto&UserId=%@"//读出用户照片
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define NAVHIGHT 44
#define STATEBAR 20
#endif
