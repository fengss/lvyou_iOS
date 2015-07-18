//
//  ViewController_2.m
//
//  Created by coderss on 15/4/4.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "ViewController_2.h"
#import "HeadFile.h"
#import "HotTicketModel.h"
#import "NewsViewController.h"
#define kCellReuseId (@"cellID")

@interface ViewController_2 ()<UICollectionViewDataSource,UICollectionViewDelegate,MyLayoutDelegte>
{
    NSMutableArray *_dataarray;
    UICollectionView *_collectionView;
}

@end

@implementation ViewController_2

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor=[UIColor whiteColor];
      [self createCollectionView];
      [self loadData];
    _dataarray=[NSMutableArray array];
   
  
    // Do any additional setup after loading the view.
}
//创建网格视图
- (void)createCollectionView
{
    //创建布局对象
    MyLayout *layout = [[MyLayout alloc] init];
    layout.sectionInsets = UIEdgeInsetsMake(10, 10, 10,10);
    layout.itemSpace = 20;
    layout.lineSpace = 20;
    //设置代理
    layout.delegate = self;
    
    //创建网格视图
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,20, 375, 667-64) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kCellReuseId];
    [self.view addSubview:_collectionView];
    
    
}

#pragma mark - MyLayoutDelegate
-(NSInteger)numberOfColumns
{
    return 2;
}

- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
   
    return [MyCollectionViewCell heightForModel:[_dataarray objectAtIndex:indexPath.row]] ;
}

#pragma mark - UICollectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataarray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseId forIndexPath:indexPath];
    
    [cell configUI:_dataarray[indexPath.row]];

    return cell;
    
}
-(void)loadData
{
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.manager GET:HOTURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsondata=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       // NSLog(@"%@",jsondata);
        NSArray *data=[NSArray arrayWithArray:jsondata];
        for(NSDictionary *dic in data)
            
        {
            HotTicketModel *model=[[HotTicketModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataarray addObject:model];
        }
        [_collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR=%@",error);
    }];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewsViewController *news=[[NewsViewController alloc]init];
    [self.navigationController pushViewController:news animated:YES];
    self.tabBarController.hidesBottomBarWhenPushed=YES;
    news.model=_dataarray[indexPath.row];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
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
