//
//  ViewController_1.m
//
//  Created by coderss on 15/4/4.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "ViewController_1.h"
#import "Search_View.h"
#import "view_hotol.h"
#import "view_sence.h"
#import "view_ticket.h"
#import "view_tuan.h"
#import "HeadFile.h"
#define NAVBARHIGHT 60
#define ADVITISEHIGHT 100
#define PHOTONUMBER 4
#define TABBARHIGHT 49
#define LABELHIGHT 30
#define BUTTONNUM 4
#define SPACE 5
#define BUTTOMHIGHT 80
#define SEARCHBARWIDTH 100
@interface MyButton : UIButton


@end



@implementation MyButton

// 用户点击按钮，按钮会调用这个方法处理高亮状态
// 重写这个方法，取消按钮的高亮状态
- (void)setHighlighted:(BOOL)highlighted
{
    // 在父类的setHighlighted处理了高亮状态(图片变暗)
    // [super setHighlighted:highlighted];
}

@end

@interface ViewController_1 ()<UIScrollViewDelegate,UISearchBarDelegate>
@property(nonatomic,strong) UIPageControl* pc;
@property(nonatomic,strong) UIScrollView* svAdivertise;

@end

@implementation ViewController_1
#pragma mark-创建小控件
//创建导航栏，导航栏上有搜索栏按钮，点击进入下一个页面
-(void)createSearchBar
{
    UINavigationBar *bar=self.navigationController.navigationBar;
    bar.barTintColor=[UIColor colorWithRed:0 green:0.7 blue:0.9 alpha:1];
    bar.barStyle=UIBarStyleBlackTranslucent;    //
   
    UINavigationItem *item=self.navigationItem;
    UISearchBar *search=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0,SEARCHBARWIDTH,NAVBARHIGHT)];
    search.delegate=self;
   // search.barTintColor=[UIColor yellowColor];
    item.titleView=search;
    search.placeholder=@"机票／旅行地／酒店／景点";
    self.navigationController.navigationBar.translucent=NO;
    self.tabBarController.tabBar.hidden=NO;
    item.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
}
//搜索栏上的按钮点击进入下一个页面
-(void)tap:(UITapGestureRecognizer *)gest
{
    Search_View *searchView=[[Search_View alloc]init];
    NSLog(@"start");
    [self.navigationController pushViewController:searchView animated:YES];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    Search_View *searchView=[[Search_View alloc]init];
    NSLog(@"start");
    searchView.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:searchView animated:YES];
    return NO;
}
// 创建分页控制器
- (void)createPageControl
{
    UIPageControl *pc = [[UIPageControl alloc] init];
    CGFloat w = 100;
    CGFloat h = 40;
    CGFloat x=self.view.bounds.size.width/2-PHOTONUMBER*6;
    CGFloat y =ADVITISEHIGHT+10-30;
  
    pc.frame = CGRectMake(x,y,w,h);
    //    pc.backgroundColor = [UIColor brownColor];
    
    // 设置分页控制器的页数 默认为0
    pc.numberOfPages = PHOTONUMBER;
    
    // 设置分页控制器当前的页数 默认为0
    pc.currentPage = 0;
    
    // 如果分页数为1 ，则隐藏分页控制器
    pc.hidesForSinglePage = NO;
    
    // 设置普通页数点的颜色
    pc.pageIndicatorTintColor = [UIColor whiteColor];
    
    // 设置当前页的指定颜色
    pc.currentPageIndicatorTintColor = [UIColor redColor];
    self.pc=pc;
  [self.view addSubview:pc];
}
//创建滚动视图（广告栏）图片为假，让视图循环滚动
- (void)createAdvertise
{
    //创建滚动视图
    //self.navigationController.navigationBar.translucent=YES;
    UIScrollView *svAdivertise=[[UIScrollView alloc]initWithFrame:CGRectMake(10,10,SCREEN_WIDTH-20,ADVITISEHIGHT)];
    CGFloat imageViewY = 0;
    CGFloat imageViewW = svAdivertise.bounds.size.width;
    CGFloat imageViewH = svAdivertise.bounds.size.height;
    NSString *imagename1=[NSString stringWithFormat:@"advertiser%d.jpg",PHOTONUMBER-1];
    //在滚动视图上添加图片
    UIImage *image1=[UIImage imageNamed:imagename1];
    UIImageView *imageview1=[[UIImageView alloc]init];
    imageview1.frame=CGRectMake(0,0,imageViewW,imageViewH);
    imageview1.image=image1;
    [svAdivertise addSubview:imageview1];
    
    for (int i = 0; i < PHOTONUMBER; i++) {
        NSString *imageName = [NSString stringWithFormat:@"advertiser%d.jpg", i];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        CGFloat imageViewX =imageViewW;
        imageView.frame = CGRectMake(imageViewX*(i+1), 0, imageViewW, imageViewH);
        
        imageView.image = [UIImage imageNamed:imageName];
        
        [svAdivertise addSubview:imageView];
    }
    UIImage *image=[UIImage imageNamed:@"advertiser0.jpg"];
    UIImageView *imageview=[[UIImageView alloc]init];
    imageview.frame=CGRectMake((PHOTONUMBER +1)*imageViewW,imageViewY,imageViewW,imageViewH);
    imageview.image=image;
    [svAdivertise addSubview:imageview];
    
    svAdivertise.contentSize =CGSizeMake(svAdivertise.bounds.size.width * (PHOTONUMBER+2), 0);
    svAdivertise.showsHorizontalScrollIndicator = NO;
    svAdivertise.pagingEnabled = YES;
    svAdivertise.bounces = NO;
    svAdivertise.delegate = self;
    //svAdivertise.contentOffset=CGPointMake(imageViewW, 0);
    [self.view addSubview:svAdivertise];
    
    //svAdivertise.contentInset=UIEdgeInsetsMake(-64, 0,0,0);
    self.svAdivertise=svAdivertise;

}
//创建定时器，让屏幕滚动
-(void)createTimer
{
     [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}
- (void)updateTimer
{
    // 计算出当前的显示的页数
    NSUInteger curIndex = self.svAdivertise.contentOffset.x / self.svAdivertise.bounds.size.width;
    CGPoint offset=self.svAdivertise.contentOffset;
    offset.x+=self.svAdivertise.bounds.size.width;
    if(curIndex==4)
    {
        [self.svAdivertise setContentOffset:offset animated:YES];
        self.svAdivertise.contentOffset=CGPointZero;
    }
    else
    {
        [self.svAdivertise setContentOffset:offset animated:YES];
    }
}
//当滚动视图滚动时让分业控制器也跟着改变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算出当前应该显示第几张图片
    NSUInteger index = (scrollView.contentOffset.x + scrollView.bounds.size.width * 0.5) / scrollView.bounds.size.width;
    
    //设置这张图片对应的广告的标题
    if(index==(PHOTONUMBER+1))
        index=1;
    if(index==0)
        index=PHOTONUMBER;
    _pc.currentPage = index-1;
}

//创建按钮和标签
-(void)createButtonAndLabel
{
    CGFloat x=0;
    CGFloat y=ADVITISEHIGHT+20;
    CGFloat w=SCREEN_WIDTH;
    CGFloat hight=90;
    CGFloat space=20;
    NSArray *labelArray=@[@"酒店订购",@"交通出行",@"景点介绍",@"旅游规划"];
    NSArray *imageArray=@[@"bg_1",@"bg_2",@"bg_3",@"bg_5"];
    NSArray *btnImage=@[@"hotol.png",@"fly.png",@"view.png",@"tuan.png"];
    NSArray *rightImage=@[@"rv1",@"rv2",@"rv3",@"rv4"];
    for(int i=0;i<BUTTONNUM;i++)
    {
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(x, y+i*(hight+space), w, hight)];
        image.image=[UIImage imageNamed:imageArray[i]];
        [self.view addSubview:image];
        image.userInteractionEnabled=YES;
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(50, 20, 80, 80);
        [btn setBackgroundImage:[UIImage imageNamed:btnImage[i]] forState:UIControlStateNormal];
           [image addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=100+i;
           UILabel *label=[[UILabel alloc]init];
                label.frame=CGRectMake(btn.frame.size.width+btn.frame.origin.x+20,35,100,30 );
                 label.text=labelArray[i];
                label.font=[UIFont systemFontOfSize:20];
        label.textColor=[UIColor whiteColor];                label.textAlignment=NSTextAlignmentLeft;
                [image addSubview:label];
        UIImageView *right=[[UIImageView alloc]initWithFrame:CGRectMake(300, 25, 40, 40)];
        right.image=[UIImage imageNamed:rightImage[i]];
        [image addSubview:right];

    }

}
//点击按钮后发生页面跳转
-(void)btnClick:(UIButton *)btn
{
    view_hotol *view1=[[view_hotol alloc]init];
    view_sence *view2=[[view_sence alloc]init];
    view_ticket *view3=[[view_ticket alloc]init];
    view_tuan *view4=[[view_tuan alloc]init];
    switch (btn.tag) {
        case 100:
            [self.navigationController pushViewController:view1 animated:YES];
            break;
        case 101:
            [self.navigationController pushViewController:view3 animated:YES];
            break;
        case 102:
            view2.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:view2 animated:YES];
            break;
        case 103:
               view4.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:view4 animated:YES];
            break;
        default:
            break;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
      [self.tabBarController.tabBar setHidden:NO];
      self.navigationController.navigationBar.translucent=NO;
}
- (void)viewDidLoad {
//    [super viewDidLoad];
//    UIImageView *image=[[UIImageView alloc]initWithFrame:self.view.frame];
//    image.image=[UIImage imageNamed:@"bg_youlun_calendar_rest"];
//    image.userInteractionEnabled=YES;
//    [self.view addSubview:image];
    self.view.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=RGBCOLOR(231, 231, 231);
    [self createSearchBar];
    [self createAdvertise];
    [self createPageControl];
    // 创建定时器，每隔一定时间让滚动视图滚动
    [self createTimer];
    [self createButtonAndLabel];
   

    //[self becomeFirstResponder];
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
