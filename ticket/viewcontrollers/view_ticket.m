//
//  view_ticket.m
//
//  Created by coderss on 15/4/6.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "view_ticket.h"
#import "HeadFile.h"
#import "TicketCollectionViewCell.h"
#import "TicketModel.h"
#define KHomeCellID (@"homeCellId")
@interface view_ticket()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MJRefreshBaseViewDelegate>
{
    NSMutableArray *_dataArray;
    UICollectionView *_collect;
    int _page;
    MJRefreshHeaderView *_head;
    MJRefreshFooterView *_foot;
}
@end
@implementation view_ticket
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self createCollection];
    self.navigationController.navigationBar.translucent=NO;
    _dataArray=[NSMutableArray array];
    _page=0;
    [self loadDataWithIshead:NO WithPage:_page];
    self.tabBarController.tabBar.hidden=YES;
    [self createMJFresh];
    [self createProgress];
    [self createNav];
}
-(void)createCollection
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset=UIEdgeInsetsMake(20, 14, 10, 14);
    layout.itemSize=CGSizeMake(165, 220);
    layout.minimumInteritemSpacing=1;
    layout.minimumLineSpacing=15;
    _collect=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT- 64) collectionViewLayout:layout];
    _collect.backgroundColor=[UIColor whiteColor];
    _collect.delegate=self;
    _collect.dataSource=self;
    [_collect registerNib:[UINib nibWithNibName:@"TicketCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:KHomeCellID];
    _collect.showsVerticalScrollIndicator=YES;
    _collect.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_collect];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TicketCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:KHomeCellID forIndexPath:indexPath];
    TicketModel *model=_dataArray[indexPath.row];
    [cell configUI:model];
    return cell;
}
-(void)createProgress
{
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    v.backgroundColor=[UIColor lightGrayColor];
    v.tag=140;
    [self.navigationController.view addSubview:v];
    [ProgressHUD showOnView:v];
}
-(void)loadDataWithIshead:(BOOL)isHead WithPage:(int)page
{
    
    
    AppDelegate * delegate=(AppDelegate *)[UIApplication sharedApplication].delegate ;
    NSString *url=[NSString stringWithFormat:TICKETURL,[NSString stringWithFormat:@"%d",page]];
     [delegate.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         id jsondata=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSArray *data=[NSArray arrayWithArray:jsondata];
       //  NSLog(@"jsondata=%@",jsondata);
         if(isHead)
            [_dataArray removeAllObjects];
         for(NSDictionary *dic in data)
         {
             TicketModel *model=[[TicketModel alloc]init];
             [model setValuesForKeysWithDictionary:dic];
             [_dataArray addObject:model];
         }
         [_collect reloadData];
         UIView *v=(UIView *)[self.navigationController.view viewWithTag:140];
         [ProgressHUD hideOnView:v];
         [v removeFromSuperview];
         v=nil;
         [_head endRefreshing];
         [_foot endRefreshing];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
          [ProgressHUD hideOnView:self.view];
         [_head endRefreshing];
         [_foot endRefreshing];
         UIView *v=(UIView *)[self.navigationController.view viewWithTag:140];
         [ProgressHUD hideOnView:v];
         [v removeFromSuperview];
         v=nil;

     }];
}
#pragma mark-mj刷新
-(void)createMJFresh
{
    _head=[MJRefreshHeaderView header];
    _head.delegate=self;
    _head.scrollView=_collect;
    _foot=[MJRefreshFooterView footer];
    _foot.delegate=self;
    _foot.scrollView=_collect;
    
}
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if(refreshView==_head)
    {
        _page=1;
        [self loadDataWithIshead:YES WithPage:_page];
    }
    else
    {
        _page++;
        [self loadDataWithIshead:NO WithPage:_page];
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
    _foot.scrollView=nil;
    _head.scrollView=nil;
}
-(void)createNav
{
    UINavigationItem *item=self.navigationItem;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake( 100,20,100,45)];
    label.text=@"特价机票";
    label.textColor=[UIColor blueColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:18];
    item.titleView=label;

}
@end
