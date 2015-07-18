//
//  ViewDeatilController.m
//
//  Created by coderss on 15/4/22.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "ViewDeatilController.h"
#import "HeadFile.h"
#import "view_details.h"
#import "UIImageView+WebCache.h"
#import "wayInviewTableViewCell.h"
#import "WayModel.h"
#import "SugViewTableViewCell.h"
#import "ViewAdvice.h"
#import "AdviceSmallView.h"
#import "LoginInViewController.h"
#define IMGEVIEWHIGH 120
@interface ViewDeatilController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,AdviceSmallViewDelegate>
{
    UIScrollView *sc;
    UISegmentedControl *seg;
    UIView *v1;
    view_details *v2;
    UIView *v3;
    UIView *v;
    int viewKey;
    CGFloat h;
    int Page;
}
@property(nonatomic,strong) NSMutableArray* wayArray;
@property(nonatomic,strong) UITableView* wayTable;
@property(nonatomic,strong) UITableView* sugTable;
@property(nonatomic,strong) NSMutableArray* adviceArray;
@property(nonatomic,strong) MJRefreshHeaderView* header;
@property(nonatomic,strong) MJRefreshFooterView* footer;



@end

@implementation ViewDeatilController
#pragma mark-制定一个navbar
-(void)createNav
{
    UINavigationItem *item=self.navigationItem;
    UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tab_0"] style:UIBarButtonItemStylePlain target:self action:@selector(shareView:)];
    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tab_1"] style:UIBarButtonItemStylePlain target:self action:@selector(telephone:)];
    UIBarButtonItem *item3=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tab_2"] style:UIBarButtonItemStylePlain target:self action:@selector(backToHome:)];
    item.rightBarButtonItems=@[item1,item2,item3];

}
#pragma mark-导航栏上按钮的实现
-(void)shareView:(UIBarButtonItem*)item
{
    
}
-(void)telephone:(UIBarButtonItem *)item
{
    
}
-(void)backToHome:(UIBarButtonItem *)item
{
    
}
#pragma mark-创造图片
-(void)createImage
{
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, IMGEVIEWHIGH)];
    NSString *url=[NSString stringWithFormat:YUMING,self.model.headimage];
    [image setImageWithURL:[NSURL URLWithString:url]];
    [self.view addSubview:image];
}
#pragma mark-创造分段
-(void)createSegment
{
    UISegmentedControl *segctl=[[UISegmentedControl alloc]initWithItems:@[@"旅游路线",@"景点简介",@"评论" ]];
    segctl.frame=CGRectMake(1,IMGEVIEWHIGH, SCREEN_WIDTH-2, 40);
    [segctl addTarget:self action:@selector(seqValueChange:) forControlEvents:UIControlEventValueChanged];
    seg=segctl;
    seg.selectedSegmentIndex=0;
    
    [self.view addSubview:segctl];
}

#pragma mark-创建view1的tableview
-(void)createtable
{
    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, v1.frame.size.width, v1.frame.size.height) style:UITableViewStylePlain];
    table.dataSource=self;
    table.delegate=self;
    table.tag=950;
    [v1 addSubview:table];
    self.wayTable=table;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==950)
    return  self.wayArray.count;
    return self.adviceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==950)
    {
    static NSString *str=@"cellid";
   wayInviewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"wayInviewTableViewCell" owner:self options:nil]lastObject];
        
    }
    WayModel *model=self.wayArray[indexPath.row];
    [cell configUI:model];
        
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        return cell;

    }
    
       static NSString *str=@"cellId";
       SugViewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"SugViewTableViewCell" owner:self options:nil]lastObject];
        }
    ViewAdvice *model=self.adviceArray[indexPath.row];
    [cell configUI:model];
      
    cell.selectionStyle= UITableViewCellSelectionStyleNone;


    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==950)
    return 80;
    ViewAdvice *model=self.adviceArray[indexPath.row];
    return [SugViewTableViewCell cellHight:model];
}
#pragma mark-当分段改变的时候
-(void)seqValueChange:(UISegmentedControl *)segem
{
//    v.backgroundColor=[UIColor colorWithRed:235 green:235 blue:245 alpha:1];
       int high=seg.frame.size.height+seg.frame.origin.y;

     int index=segem.selectedSegmentIndex;
    switch (index) {
        case 0:
        {
            
            v1.frame=CGRectMake(0, high, SCREEN_WIDTH, SCREEN_HEIGHT-64);
           sc.frame=CGRectMake(SCREEN_WIDTH,high, SCREEN_WIDTH, SCREEN_HEIGHT-64);
            v3.frame=CGRectMake(SCREEN_WIDTH*2,high, SCREEN_WIDTH, SCREEN_HEIGHT-high);
            UIButton *btn=(UIButton *)[self.view viewWithTag:870];
            [btn removeFromSuperview];
            btn=nil;
            
            break;
        }
        case 1:
        {
           
            v1.frame=CGRectMake(-SCREEN_WIDTH, high, SCREEN_WIDTH, SCREEN_HEIGHT-64);
            sc.frame=CGRectMake(0,high, SCREEN_WIDTH, SCREEN_HEIGHT-64);
            v3.frame=CGRectMake(SCREEN_WIDTH,high, SCREEN_WIDTH, SCREEN_HEIGHT-high);
            NSInteger length=[v2 configUI:self.model];
            sc.contentSize=CGSizeMake(SCREEN_WIDTH, length+seg.frame.size.height+seg.frame.origin.y);
            sc.showsVerticalScrollIndicator=NO;
            UIButton *btn=(UIButton *)[self.view viewWithTag:870];
            [btn removeFromSuperview];
            btn=nil;
            break;
        }
        case 2:
        {
            
            v1.frame=CGRectMake(-SCREEN_WIDTH*2, high, SCREEN_WIDTH, SCREEN_HEIGHT-64);
            sc.frame=CGRectMake(SCREEN_WIDTH,high, SCREEN_WIDTH, SCREEN_HEIGHT-64);
            v3.frame=CGRectMake(0,high, SCREEN_WIDTH, SCREEN_HEIGHT-high);
              [self createButton];
            break;
        }
   
            
        default:
            break;
    }
    
}
#pragma mark-创建评论表
-(void)createSugTable
{
    self.sugTable=[MyKit createTable:CGRectMake(0, 0, v3.frame.size.width, v3.frame.size.height) WithDataDrlegate:self WithDelegate:self];
    [v3 addSubview:self.sugTable];
    self.sugTable.tag=960;
  
    self.sugTable.showsVerticalScrollIndicator=NO;
    
}
#pragma mark-创建评论的按钮
-(void)createButton
{
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, self.view.frame.size.height/2, 50, 50)];
    btn.layer.cornerRadius=25;
    btn.layer.masksToBounds=YES;
     [btn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [btn setTitle:@"话" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:24];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(adviceClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=870;
    [self.view addSubview:btn];

}
-(void)adviceClick:(UIButton *)btn
{
   NSString *num=[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"];
    if(![num isEqualToString:@"0"])
    {
    
    UIControl *vd=[[UIControl alloc]initWithFrame:self.navigationController.view.frame];
    vd.backgroundColor=[UIColor blackColor];
    vd.tag=130;
    vd.alpha=0.9;
    [self.navigationController.view addSubview:vd];
    AdviceSmallView *small=[[[NSBundle mainBundle]loadNibNamed:@"AdviceSmallView" owner:self options:nil]lastObject];
    small.frame=CGRectMake(50, 100,280, 440);
     [vd addSubview:small];
    small.alpha=0;
    [UIView animateWithDuration:1 animations:^{
           self.view.transform=CGAffineTransformScale(self.view.transform, 0.9,0.9);
                small.alpha=1;
    }];
    small.delegate=self;
    small.tag=119;
        small.UserId=num;
        small.ViewId=self.model.Viewid;
    [vd addTarget:self action:@selector(ctrlClick) forControlEvents:UIControlEventTouchDown];
    }
    else
    {
        
        LoginInViewController *loginview=[[LoginInViewController alloc]init];
        [self presentViewController:loginview animated:YES completion:nil];
    }
   
    

}
- (void)ctrlClick
{
    AdviceSmallView *small=(AdviceSmallView *)[self.navigationController.view viewWithTag:119];
    [small endEditing:YES];
}
-(void)back
{
    AdviceSmallView *small=(AdviceSmallView *)[self.navigationController.view viewWithTag:119];
    [small removeFromSuperview];
    small=nil;
    UIControl *vd=(UIControl *)[self.navigationController.view viewWithTag:130];
    [vd removeFromSuperview];
    [UIView animateWithDuration:1 animations:^{
        self.view.transform=CGAffineTransformScale(self.view.transform,1.111,1.111);
      
    }];

}
#pragma mark-加载数据
-(void)loadDataWithPage:(int)page WithIsHead:(BOOL)isHead WithViewKey:(int)viewkey
{
   
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *url;
    if(viewkey==1)
    {
      url=[NSString stringWithFormat:WAYINVIEWURL,self.model.Viewid];
        NSLog(@"viewurl%@",url);
    }
    else
    {
        url=[NSString stringWithFormat:VIEWADVICEURL,self.model.Viewid,[NSString stringWithFormat:@"%d",page]];
    }
    [delegate.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsondata=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if(viewkey==1)
        {
           
        NSArray *data=[NSArray arrayWithArray:jsondata];
        for(NSDictionary *dic in data)
        {
            WayModel *way=[[WayModel alloc]init];
            [way setValuesForKeysWithDictionary:dic];
            [self.wayArray addObject:way];
        }
                  [self.wayTable reloadData];
        }
        else
        {
            
            NSArray *dataarray=[NSArray arrayWithArray:jsondata];
                if(isHead)
               [self.adviceArray removeAllObjects];
            for (NSDictionary *dic in dataarray) {
                ViewAdvice *model=[[ViewAdvice alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.adviceArray addObject:model];
            }
            [self.sugTable reloadData];
            if(viewkey==3)
            [self.header endRefreshing];
            [self.footer endRefreshing];
    
        }
        UIView *vk=(UIView *)[self.view viewWithTag:700];
        [ProgressHUD hideOnView:vk];
        [vk removeFromSuperview];
        vk=nil;
      
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error=%@",error);
        UIView *vk=(UIView *)[self.view viewWithTag:700];
        [ProgressHUD hideOnView:vk];
        [vk removeFromSuperview];
        vk=nil;
        [self.header endRefreshing];
        [self.footer endRefreshing];


    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
     [self createFresh];
    self.view.backgroundColor=[UIColor colorWithRed:235 green:235 blue:245 alpha:1];
    self.wayArray=[NSMutableArray array];
    self.adviceArray=[NSMutableArray array];
    [self createImage];
    [self createSegment];
    [self createViews];
    // Do any additional setup after loading the view.
}
#pragma mark-创建分组视图
-(void)createViews
{
     int high=seg.frame.size.height+seg.frame.origin.y;
    v1=[MyKit createUIView:CGRectMake(0,high, SCREEN_WIDTH, SCREEN_HEIGHT-high) WithColor:[UIColor whiteColor]];
    [self.view addSubview:v1];
    [self createtable];
    viewKey=1;
   [self loadDataWithPage:Page WithIsHead:NO WithViewKey:viewKey];

    sc=[[UIScrollView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, high, SCREEN_WIDTH, SCREEN_HEIGHT
                                                     -high)];
    [self.view addSubview:sc];
    v2=[[[NSBundle mainBundle]loadNibNamed:@"view_details" owner:self options:nil]lastObject];
    v2.frame=CGRectMake(0, 0,sc.frame.size.width, sc.frame.size.height);   
    [sc addSubview:v2];
    v3=[MyKit createUIView:CGRectMake(2*SCREEN_WIDTH, high, SCREEN_WIDTH, SCREEN_HEIGHT-high) WithColor:[UIColor redColor]];
    [self.view addSubview:v3];
      [self createSugTable];
           viewKey=3;
    [self.adviceArray removeAllObjects];
        Page=0;
    [self loadDataWithPage:Page WithIsHead:NO WithViewKey:viewKey];
              
    [self createMjLoad];
}

-(void)createFresh
{
    UIView *vm=[[UIView alloc]initWithFrame:self.view.frame];
    vm.backgroundColor=[UIColor whiteColor];
    vm.tag=700;
    [ProgressHUD showOnView:vm];
    [self.view addSubview:vm];
}
#pragma mark-创建上拉加载下拉刷新
-(void)createMjLoad
{
    self.header=[MJRefreshHeaderView header];
    self.footer=[MJRefreshFooterView footer];
    self.header.delegate=self;
    self.header.scrollView=self.sugTable;
    self.footer.delegate=self;
    self.footer.scrollView=self.sugTable;
}
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if(refreshView==self.header)
    {
        Page=0;
        viewKey=3;
        [self loadDataWithPage:Page WithIsHead:YES WithViewKey:viewKey];
    }
    else
    {
        Page++;
        viewKey=3;
        [self loadDataWithPage:Page WithIsHead:NO WithViewKey:viewKey];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.footer.scrollView=nil;
    self.header.scrollView=nil;
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
