//
//  view_tuan.m
//
//  Created by coderss on 15/4/6.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "view_tuan.h"
#import "PGCategoryView.h"
#import "HeadFile.h"
#import "tourTeamModel.h"
#import "WayTableViewCell.h"
#import "WayModel.h"
#import "waySmallView.h"
#import "viewInWay.h"
#import "ViewDetailModel.h"
#import "MapViewController.h"
#import "SugTuanTableViewCell.h"
#import "UserAdviceViewController.h"
#import "AdviceTuan.h"
#import "LoginInViewController.h"
#import "OrderViewController.h"
#define VIEWHIGHT 467
#define VIEWWIGHR 295
#define kLeftViewWidth 96
@interface view_tuan ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,BMKGeoCodeSearchDelegate>

{
    UITableView *_leftTbale;
    UITableView *_rightTbale;
    UIView *_contentView;
    UIView * wayview;
    UITableView *leftview;
    UIScrollView *rightview;
    UISegmentedControl *sege;
    UIScrollView *s;
    BMKMapView* _mapView;
    BMKGeoCodeSearch* _geocodesearch;
    BOOL isAdvice;
}
@property (strong, nonatomic) PGCategoryView *categoryView;
@property(nonatomic,strong) NSMutableArray* dataArray;
@property(nonatomic,strong) NSMutableArray* wayArray;
@property(nonatomic,strong) WayModel* waymodel;
@property(nonatomic,strong) NSMutableArray* mapArray;
@property(nonatomic,strong) NSMutableArray* adviceArray;

@end

@implementation view_tuan
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createview];
    [self createtableviews];
    [self loadDataWithIsway:NO WithStr:nil];
   self.view.backgroundColor= RGBCOLOR(360, 235, 242);
    [self createfresh];
    self.adviceArray=[NSMutableArray array];
    isAdvice=NO;
    NSLog(@"wo jinlai le ");
    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"isadvice=%d",isAdvice);
    self.navigationController.navigationBarHidden=NO;
    if(isAdvice)
    {
        [self loadAdviceData];
    }
    isAdvice=NO;
}
-(NSMutableArray *)dataArray
{
    if(_dataArray==nil)
    {
        _dataArray=[[NSMutableArray alloc]init];
    }
    return _dataArray;
}
-(NSMutableArray *)wayArray{
    if(_wayArray==nil)
    {
        _wayArray=[[NSMutableArray alloc]init];
    }
    return _wayArray;
}
//创建左右tableview
-(void)createtableviews
{
    _contentView = [[UIView alloc] init];
    _contentView.frame = CGRectMake(self.view.bounds.size.width, 0,self.view.bounds.size.width, self.view.bounds.size.height);
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _contentView.backgroundColor = RGBCOLOR(360, 235, 242);
    [self.view addSubview:_contentView];
    
    _leftTbale = [[UITableView alloc] init];
    _leftTbale.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    _leftTbale.dataSource = self;
    _leftTbale.delegate = self;
    _leftTbale.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _leftTbale.showsVerticalScrollIndicator = NO;
    _leftTbale.tableFooterView = [[UIView alloc] init];
    [self.view insertSubview:_leftTbale belowSubview:_contentView];
    
    _rightTbale = [[UITableView alloc] init];
    _rightTbale.frame = CGRectMake(0, 0, _contentView.bounds.size.width, _contentView.bounds.size.height);
    _rightTbale.dataSource = self;
    _rightTbale.delegate = self;
    _rightTbale.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _rightTbale.showsVerticalScrollIndicator = NO;
    _rightTbale.tableFooterView = [[UIView alloc] init];
    [_contentView addSubview:_rightTbale];
    
    
    CGRect frame = _contentView.frame;
    frame.origin.x -= 30;
    frame.size.width = 30;
    _categoryView = [PGCategoryView categoryRightView:_contentView];
    _categoryView.frame = frame;
    [self.view addSubview:_categoryView];

}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _leftTbale) {
        return self.dataArray.count;
    }else if(tableView==_rightTbale){
       // NSLog(@"self.wayarray=%ld",self.wayArray.count);
        return self.wayArray.count;
    }
    return self.adviceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _leftTbale)
    {
        static NSString *CellIdentifier = @"cellid";
        LyTuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LyTuanTableViewCell" owner:self options:nil]lastObject];
        }
        [cell configUI:self.dataArray[indexPath.row]];
        
        return cell;
    }
    else if(tableView==_rightTbale){
        static NSString *CellIdentifier2 = @"cellId";
        WayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"WayTableViewCell" owner:self options:nil]lastObject];
        }
        
        [cell configUI:self.wayArray[indexPath.row]];
        return cell;
    }
    static NSString *str=@"cell";
    SugTuanTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"SugTuanTableViewCell" owner:self options:nil]lastObject];
    }
    AdviceTuan *model=self.adviceArray[indexPath.row];
    [cell configUI:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_leftTbale)
        return 60;
    else if(tableView==_rightTbale)
        return 64;
      AdviceTuan *model=self.adviceArray[indexPath.row];
    CGFloat hight=[SugTuanTableViewCell heightForModel:model];
    return hight;
}

#pragma mark - tableView 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == _leftTbale) {
        tourTeamModel *model=self.dataArray[indexPath.row];
        [self loadDataWithIsway:YES WithStr:model.teamid];
        [_categoryView show];
        UIView *v=[[UIView alloc]initWithFrame:CGRectMake( kLeftViewWidth,-46, SCREEN_WIDTH-kLeftViewWidth-120, SCREEN_HEIGHT)];
        [self.view addSubview:v];
        v.tag=170;
        [ProgressHUD showOnView:v];
        

 
    }
    else if(tableView==_rightTbale){

        [UIView animateWithDuration:1 animations:^{
            UIControl *ctl=(UIControl *)[self.navigationController.view viewWithTag:230];
                [ctl addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
            [self.view bringSubviewToFront:ctl];
           _leftTbale.transform = CGAffineTransformScale(_leftTbale.transform,0.9, 0.9);
        _rightTbale.transform = CGAffineTransformScale(_rightTbale.transform,0.9, 0.9);
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake(40, 40,VIEWWIGHR , VIEWHIGHT)];
            view.backgroundColor=RGBCOLOR(223, 235, 240);
            NSLog(@"%@",NSStringFromCGRect(view.frame));
            [self.view addSubview:view];
            wayview=view;
            self.waymodel=self.wayArray[indexPath.row];
            view.tag=280;
            view.alpha=1;
            [self createWayView];
         
        }];
        [self loadAdviceData];
    }
    
    
    
    
}
#pragma mark-点击空白处汇到原位
-(void)click
{
    
    [UIView animateWithDuration:1 animations:^{
        
        UIView *v=[self.view viewWithTag:280];
       // v.backgroundColor=[UIColor redColor];
        [v removeFromSuperview];
        v=nil;
        UIControl *ctl=(UIControl *)[self.navigationController.view viewWithTag:230];
        
        [self.view sendSubviewToBack:ctl ];
        _leftTbale.transform=CGAffineTransformScale(_leftTbale.transform, 1.111, 1.111);
        _rightTbale.transform=CGAffineTransformScale(_rightTbale.transform, 1.111, 1.111);
        UIView *view=[self.view viewWithTag:180];
        [view removeFromSuperview];
        view=nil;
    }]
    ;
    

}
#pragma mark-创建地图
-(void)mbtnClick:(UIButton *)btn
{
    MapViewController *map=[[MapViewController alloc]init];
    [self.navigationController pushViewController:map animated:YES];
    isAdvice=YES;
    map.mapArray=self.mapArray;
}
-(void)segvalueclick:(UISegmentedControl *)seg
{
    if(seg.selectedSegmentIndex==1)
    {
        CGRect rect=leftview.frame;
        rect.origin.x=-VIEWWIGHR;
        leftview.frame=rect;
        CGRect  re=rightview.frame;
        re.origin.x=0;
        rightview.frame=re;
        //UILabel *detail=(UILabel *)[self.view viewWithTag:140];
        // s.contentSize=CGSizeMake(VIEWWIGHR,detail.frame.size.height+rightview.frame.origin.y+20);
    }
    else
    {
        CGRect rect=leftview.frame;
        rect.origin.x=0;
        leftview.frame=rect;
        CGRect  re=rightview.frame;
        re.origin.x=VIEWWIGHR;
        rightview.frame=re;
        
    }
}
-(void)creatchangeview
{
    CGFloat y= sege.frame.size.height+sege.frame.origin.y;
    leftview =[[UITableView alloc]initWithFrame:CGRectMake(0,y,VIEWWIGHR,VIEWHIGHT-sege.frame.size.height-37) style:UITableViewStylePlain];
    leftview.dataSource=self;
    leftview.delegate=self;
    leftview.tag=610;
    [s addSubview:leftview];
   // leftview.backgroundColor=[UIColor redColor];
    rightview=[[UIScrollView alloc]initWithFrame:CGRectMake(VIEWWIGHR, y, VIEWWIGHR,leftview.frame.size.height)];
    rightview.bounces=NO;
    [s addSubview:rightview];
    CGSize size= [Tool strSize:self.waymodel.WayInfo withMaxSize:CGSizeMake(VIEWWIGHR-20, 10000) withFont:[UIFont systemFontOfSize:12] withLineBreakMode:NSLineBreakByCharWrapping];
    UILabel *detail=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, VIEWWIGHR-20,size.height+30 )];
    detail.text=self.waymodel.WayInfo;
    detail.numberOfLines=0;
   // NSLog(@"info==%@",self.waymodel.WayInfo);
    detail.textColor=[UIColor blackColor];
    detail.font=[UIFont systemFontOfSize:12];
   // detail.backgroundColor=[UIColor redColor];
    detail.tag=140;
   // rightview.contentSize=CGSizeMake(VIEWWIGHR, detail.frame.size.height);
    [rightview addSubview:detail];
   // rightview.backgroundColor=[UIColor blackColor];
    rightview.showsVerticalScrollIndicator=NO;

}
#pragma mark-创建数据
-(void)loadDataWithIsway:(BOOL)isWay WithStr:(NSString *)teamid
{
    NSString *url;
   
    if(isWay)
    {
        url=[NSString stringWithFormat:WAYURL,teamid];
       // NSLog(@"wayurl=%@",url);
    }
    else
    {
        url=TOURTEAMURL;

    }
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsondata=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if(isWay)
        {
            [self.wayArray removeAllObjects];
            NSArray *arr=[NSArray arrayWithArray:jsondata];
            for(NSDictionary *dic in arr)
            {
                WayModel *model=[[WayModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.wayArray addObject:model];
            }
           UIView * v=(UIView *)[self.view viewWithTag:170];
            [ProgressHUD hideOnView:v];
            [v removeFromSuperview];
            v=nil;

            [_rightTbale reloadData];
            
        }
        else
        {
        NSArray *array=[NSArray arrayWithArray:jsondata];
        for (NSDictionary *dic in array) {
            tourTeamModel *model=[[tourTeamModel alloc]init];
            [model setValuesForKeysWithDictionary:dic ];
            [self.dataArray addObject:model];
        }
            
        
        [_leftTbale reloadData];
        UIView *v=(UIView *)[self.view viewWithTag:160];
            [ProgressHUD hideOnView:v];
            [v removeFromSuperview];
            v=nil;

    }

     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [_leftTbale reloadData];
        UIView *v=[self.view viewWithTag:160];
        [ProgressHUD hideOnView:v];
        [v removeFromSuperview];
        v=nil;
        
        NSLog(@"%@",error);
    }];
}
#pragma mark-创建刷新器
-(void)createfresh
{
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    v.backgroundColor=[UIColor whiteColor];
    v.tag=160;
    [self.view addSubview:v];
    [ProgressHUD showOnView:v];
}
#pragma mark-sc的代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.tag==500)
   {
//    NSLog(@"content＝＝%f",scrollView.contentOffset.y);
//        NSLog(@"sege.frame.origin.y=%f",sege.frame.origin.y);
     if(scrollView.contentOffset.y<sege.frame.origin.y-0.1)
     {
                 // rightview.contentSize=CGSizeMake(VIEWWIGHR, detail.frame.size.height);

         rightview.contentSize=CGSizeMake(VIEWWIGHR,VIEWHIGHT-sege.frame.size.height-37);
             leftview.showsVerticalScrollIndicator=NO;
         leftview.scrollEnabled=NO;
     }
        else
        {
            UILabel *label=(UILabel *)[self.view viewWithTag:140];
 
            rightview.contentSize=CGSizeMake(VIEWWIGHR, label.frame.size.height);
          
     
            leftview.scrollEnabled=YES;
        }
    }
    
}
#pragma mark-图片上的文字被点击之后
-(void)imageBtnClick:(UIButton *)btn
{
      NSString *num=[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"];
    if(btn.tag==100)
    {
      
      
        if(![num isEqualToString:@"0"])
        {

        UserAdviceViewController *user=[[UserAdviceViewController alloc]init];
            user.UserId=num;
            user.WayId=self.waymodel.WayId;
            isAdvice=YES;
        [self.navigationController pushViewController:user animated:YES];
        self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
            user.block=^{
                [self loadAdviceData];
            };
        }
        else
        {
            LoginInViewController *login=[[LoginInViewController alloc]init];
            [self presentViewController:login animated:YES completion:nil];
        }
    }
    else
    {
        if(![num isEqualToString:@"0"])
        {

        OrderViewController *order=[[OrderViewController alloc]init]
        ;
        order.model=self.waymodel;
            order.UserId=num;
        [self.navigationController pushViewController:order animated:YES];
        }
        else
        {
            self.navigationController.navigationBarHidden=YES;
            LoginInViewController *login=[[LoginInViewController alloc]init];
            
            [self.navigationController pushViewController:login animated:YES];

        }
    }
}
#pragma mark-创造way详情
-(void)createWayView
{
   CGFloat imageHight=40;
    NSArray *array=@[@"用户评论",@"立刻预定"];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0,VIEWHIGHT-imageHight,VIEWWIGHR,imageHight)];
    image.image=[UIImage imageNamed:@"navigationbar"];
    image.userInteractionEnabled=YES;
    [wayview addSubview:image];
    self.view.backgroundColor=RGBCOLOR(223, 235, 240);
    CGFloat x=20;
    CGFloat space=20;
    CGFloat btnWidth=(VIEWWIGHR-x*3)/2;
    CGFloat btnHight=30;
    NSArray *colorArray=@[RGBCOLOR(247, 147, 95),RGBCOLOR(247, 142, 140)];
    for(int i=0;i<2;i++)
    {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(x+btnWidth*i+space*i,5, btnWidth,btnHight)];
        [btn setBackgroundColor:colorArray[i]];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=100+i;
        btn.layer.cornerRadius=5;
        btn.layer.masksToBounds=YES;
        [image addSubview:btn];
        
    }
    
    UIScrollView *sc=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,VIEWWIGHR,VIEWHIGHT-image.frame.size.height) ];
    //sc.backgroundColor=[UIColor blueColor];
    //    // sc.contentSize=CGSizeMake( VIEWWIGHR, SCREEN_HEIGHT);
    [wayview addSubview:sc];
        UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,VIEWWIGHR, 38)];
    name.textAlignment=UITextAlignmentCenter;
    //    NSLog(@"wayname=%@",self.waymodel.ViewId);
        NSArray *viewIdArray=[self.waymodel.ViewId componentsSeparatedByString:@","];
    //    NSLog(@"%@",viewIdArray);
       name.text=self.waymodel.WayName;
        name.font=[UIFont systemFontOfSize:15];
        name.textColor=[UIColor blackColor];
        name.backgroundColor=RGBCOLOR(45,163, 227);
        [sc addSubview:name];
        UIButton *mbtn=[UIButton buttonWithType:UIButtonTypeSystem];
        mbtn.frame=CGRectMake(0, 0, 60, 30) ;
        [ mbtn setTitle:@"查看地图" forState:UIControlStateNormal];
        [mbtn addTarget:self action:@selector(mbtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [mbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        mbtn.titleLabel.font=[UIFont systemFontOfSize:12];
   // mbtn.backgroundColor=[UIColor whiteColor];
        [sc addSubview:mbtn];
    
    waySmallView *small=[[[NSBundle mainBundle]loadNibNamed:@"waySmallView" owner:self options:nil]lastObject];
    [sc addSubview:small];
    small.wayinfo.text=self.waymodel.wayshortinfo;
    small.adultprice.text=[NSString stringWithFormat:@"大人价格:  %@",self.waymodel.AdultMoney];
    small.childprice.text=[NSString stringWithFormat:@"小孩价格:  %@",self.waymodel.ChildMoney];
    CGSize size=[Tool strSize:self.waymodel.Waydate withMaxSize:CGSizeMake(350, 10000) withFont:[UIFont systemFontOfSize:13] withLineBreakMode:NSLineBreakByCharWrapping];
    //    //    CGRect timeRect=small.time.frame;
    //    //    timeRect.size.height=hight2+50;
    small.timehight.constant=size.height+30;//有误差
    //    //small.time.frame=timeRect;
    small.time.numberOfLines=0;
    small.time.text=self.waymodel.Waydate;
    small.backgroundColor=RGBCOLOR(223, 235, 240);
    //
    //    //   small.smaliiviewhigh.constant=size.height+90;
    small.frame=CGRectMake(0, name.frame.origin.y+name.frame.size.height,VIEWWIGHR,size.height+small.time.frame.origin.y+30);
    CGFloat viewY=small.frame.size.height+small.frame.origin.y+50;
    //    NSLog(@"frame=%f",small.frame.size.height);
        CGFloat viewHight=80;
        CGFloat space1=10;
        CGFloat linehigh=viewIdArray.count*80+space1*(viewIdArray.count-1)+viewY+20;
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    self.mapArray=[NSMutableArray array];
        for(int i=0;i<viewIdArray.count;i++)
        {
            viewInWay *view=[[[NSBundle mainBundle]loadNibNamed:@"viewInWay" owner:self options:nil]lastObject];
            view.frame=CGRectMake(10, viewY+i*80+space*i,VIEWWIGHR-20, viewHight);
            [sc addSubview:view];
            view.layer.cornerRadius=5;
            NSString *url=[NSString stringWithFormat:VIEWURL,[viewIdArray[i] intValue]];
    
            [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                id jsondata=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"url=%@",url);
                NSArray *array=[NSArray arrayWithArray:jsondata];
                NSDictionary *dic=array[0];
                ViewDetailModel *model=[[ViewDetailModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                //  NSLog(@"viewDeatilmodel=%@",model.headimage);
                [view.imagehead setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMAGEYUMING,model.headimage]]];
                 view.viewname.text=model.ViewName;
                [self.mapArray addObject:model];
                
    
            }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
    
                     NSLog(@"%@",error);
                 }];
    
            view.layer.masksToBounds=YES;
        }
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(5, linehigh, VIEWWIGHR-5, 1)];
        line.backgroundColor=RGBCOLOR(111, 113, 121);
        [sc addSubview:line];
        NSArray *arr=@[@"看看别人怎么说",@"您需要了解"];
        UISegmentedControl *seg=[[UISegmentedControl alloc]initWithItems:arr];
        seg.frame=CGRectMake(10, line.frame.origin.y+line.frame.size.height+5, VIEWWIGHR-20, 40);
        [seg addTarget:self action:@selector(segvalueclick:) forControlEvents:UIControlEventValueChanged];
        //seg.tintColor=[UIColor redColor];
        [sc addSubview:seg];
        seg.selectedSegmentIndex=0;
        sege=seg;
        s=sc;
        s.tag=500;
        s.delegate=self;
        sc.contentSize=CGSizeMake(wayview.frame.size.width,seg.frame.origin.y+wayview.frame.size.height-40);
        sc.bounces=NO;
        sc.showsVerticalScrollIndicator=NO;
        [self creatchangeview];
}

#pragma mark-创建新的界面
-(void)createview
{
      UIControl *ctl=[[UIControl alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        ctl.backgroundColor=[UIColor blackColor];
        ctl.alpha=0.5;
        ctl.tag=230;
        [self.view addSubview:ctl];
    
}
#pragma mark-评论加载数据
-(void)loadAdviceData
{
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *dic=@{@"WayId":self.waymodel.WayId};
    [delegate.manager POST:USERADVICETUANURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsondata=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *data=[NSArray arrayWithArray:jsondata];
        for(NSDictionary *d in data)
        {
            AdviceTuan *tuan=[[AdviceTuan alloc]init];
            [tuan setValuesForKeysWithDictionary:d];
            [self.adviceArray addObject:tuan];
        }
        [leftview reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end

