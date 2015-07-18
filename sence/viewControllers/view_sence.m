//
//  view_sence.m
//
//  Created by coderss on 15/4/6.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "view_sence.h"
#import "HeadFile.h"
#import "RegionViewController.h"
#import "ViewCollectionViewCell.h"
#import "ViewDeatilController.h"
#define ADVITISEHIGHT 80
#define PHOTONUMBER 4
@interface view_sence()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,MJRefreshBaseViewDelegate,ViewCollectionViewCellDelegate>
{
    int page;
    BOOL isRegion;
    NSString* resgion_id;
    NSString* pid;
}
@property(nonatomic,strong) UIScrollView* adveritise;
@property(nonatomic,strong) UIPageControl* pc;
@property(nonatomic,strong) UIImageView* vw;
@property(nonatomic,strong) UICollectionView* collect;
@property(nonatomic,strong) UIButton* resgion_btn;

@property(nonatomic,strong) NSMutableArray* dataArray;
@property(nonatomic,strong)  MJRefreshHeaderView *header;
@property(nonatomic,strong) MJRefreshFooterView* footer;



@end
@implementation view_sence

//创造导航栏
-(void)createNav
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"上海" forState:UIControlStateNormal];
    btn.frame=CGRectMake(0, 15,35, 30);
    btn.tag=20;
    self.resgion_btn=btn;
    UIImageView *view=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    view.image=[UIImage imageNamed:@"zuobiao"];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:12];
    [btn addTarget:self action:@selector(resigonclick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:btn];
    UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithCustomView:view];

    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.rightBarButtonItems=@[item,item1];
    
}
#pragma mark-跳转到地区界面
-(void)resigonclick:(UIButton *)btn
{
    RegionViewController *region=[[RegionViewController alloc]init];
    region.tabBarController.hidesBottomBarWhenPushed=YES;
        region.block=^(NSString *rid,NSString *name)
    {
        isRegion=YES;
        [self loadDataWithRegion:rid WithIsHead:NO WithPage:@"0"];
        page=0;
        resgion_id=rid;
        [self.resgion_btn setTitle:name forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:region animated:YES]
    ;
}
#pragma mark-创建瀑布流

-(void)createCollection
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=CGSizeMake(355,200);//单元格的宽度和高度
    layout.minimumInteritemSpacing=10;//最小的列距离;
    layout.minimumLineSpacing=15;//行距离；
      layout.headerReferenceSize=CGSizeMake(SCREEN_WIDTH, 140);//设置页眉的高度
    
    UICollectionView *collect=[[UICollectionView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:layout];
  
    [collect registerClass:[ViewCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [collect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ads"];
    collect.backgroundColor=RGBCOLOR(239, 239, 244);
    collect.dataSource=self;
    collect.delegate=self;
    self.collect=collect;
    collect.showsVerticalScrollIndicator=NO;
    [self.view addSubview:collect];

}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  ViewCollectionViewCell *cell = (ViewCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.layer.borderWidth=2;
   cell.layer.borderColor=[[UIColor whiteColor]CGColor];
   cell.layer.cornerRadius=15;
    cell.layer.masksToBounds=YES;
    [cell configUI:self.dataArray[indexPath.row]];
    cell.delegate=self;
    return cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *head=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ads" forIndexPath:indexPath];
    [self createHot];
    
       [head addSubview:self.vw];
    return head;
    

}

//创建热门榜单
-(void)createHot
{
    NSArray *imageArray=@[@"rest1.png",@"rest2.png",@"rest3.png",@"rest4.png"];
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    imageview.image=[UIImage imageNamed:@"bg_hot.png"];
    self.vw=imageview;
    UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake(5, 8, 20, 18)];
    icon.image=[UIImage imageNamed:@"love.png"];
    [imageview addSubview:icon];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(28, 8, SCREEN_WIDTH-18, 20)];
    label.text=@"热门推荐";
    label.font=[UIFont systemFontOfSize:13];
    imageview.userInteractionEnabled=YES;
    [imageview addSubview:label];
    CGFloat x=10;
    CGFloat y=30;
    CGFloat w=75;
    CGFloat h=75;
    CGFloat space=10;
    for(int i=0;i<4;i++)
    {
       UIImageView *v=[[UIImageView alloc]init];
        v.frame=CGRectMake(x+(w+space)*i, y, w, h);
      
        v.image=[UIImage imageNamed:imageArray[i]];
        [imageview addSubview:v];
        
        
    }
}
#pragma mark-创造数据
-(void)loadDataWithRegion:(NSString *)region WithIsHead:(BOOL)res WithPage:(NSString *)p

{
    NSString *url=[NSString stringWithFormat:VIEWDETAILURL,region,p];
    NSLog(@"url=%@",url);
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsondata=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array=[NSArray arrayWithArray:jsondata];
          if(res)
           [self.dataArray removeAllObjects];
        for(NSDictionary *dic in array)
        {
            ViewDetailModel *model=[[ViewDetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
            NSLog(@"%@",model.ViewName);
        }
        [self.collect reloadData];
        UIView *v=[self.navigationController.view viewWithTag:800];
        [ProgressHUD hideOnView:v];
        [v removeFromSuperview];
        v=nil;
        NSLog(@"数据加载成功");
        [self.header endRefreshing];
        [self.footer endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.header endRefreshing];
        [self.footer endRefreshing];
        NSLog(@"%@",error);
        UIView *v=[self.navigationController.view viewWithTag:800];
        [ProgressHUD hideOnView:v];
        [v removeFromSuperview];
        v=nil;
        pid=resgion_id;

    }];
    
}
-(void)viewDidLoad
{
  
    [super viewDidLoad];
    [self createNav];
    _dataArray=[NSMutableArray array];
    self.view.backgroundColor=[UIColor whiteColor];
    [self createCollection];
    [self loadDataWithRegion:@"321" WithIsHead:NO WithPage:@"0"];
    [self createfresh];
   [self createMJFresh];
    page=0;
    resgion_id=@"321";
    isRegion=NO;
    
}
-(void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:animated];
    if(_collect!=nil)
    {
        _header.scrollView=_collect;
        _footer.scrollView=_collect;
    }
    NSLog(@"collect.fram=%@",NSStringFromCGRect(self.collect.frame));
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.translucent=NO;
    if(isRegion)
    [_dataArray removeAllObjects];
    isRegion=NO;
    page=0;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.header.scrollView=nil;
    self.footer.scrollView=nil;
}
#pragma mark-创建刷新器
-(void)createfresh
{
   
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor=[UIColor lightGrayColor];
    view.tag=800;
    [self.navigationController.view addSubview:view];

    [ProgressHUD showOnView:view];
}
#pragma mark-创建上拉下载
-(void)createMJFresh
{
    self.header=[MJRefreshHeaderView header];
    self.header.delegate=self;
    self.header.scrollView=self.collect;
    self.footer=[MJRefreshFooterView footer];
    self.footer.delegate=self;
    self.footer.scrollView=self.collect;
    
}
#pragma mark-实现mj的代理
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if(refreshView==self.header)
    {
        page=0;
        [self loadDataWithRegion:resgion_id WithIsHead:YES WithPage:[NSString stringWithFormat:@"%d",page ]];
    }
    else
    {
        page++;
        [self loadDataWithRegion:resgion_id WithIsHead:NO WithPage:[NSString stringWithFormat:@"%d",page ]];
     }
}
-(void)clickToViewDeatil:(ViewDetailModel *)model
{
    ViewDeatilController *de=[[ViewDeatilController alloc]init];
    de.model=model;
    [self.navigationController pushViewController:de animated:YES];
}
@end
