//
//  Search_View.m
//
//  Created by coderss on 15/4/5.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "Search_View.h"
#define SCREEN_HEIGHT 44
@interface Search_View ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property(nonatomic,strong) UISearchBar* searchBar;
@property(nonatomic,strong)NSMutableArray* searchResult;

@end
@implementation Search_View
#pragma mark -创建子控件
//创建搜索栏
-(void)creatSearchBar
{
UISearchBar *searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, self.navigationController.navigationBar.bounds.size.width, self.navigationController.navigationBar.bounds.size.height)];
UINavigationItem *item=self.navigationItem;
    item.hidesBackButton=YES;
 item.titleView=searchBar;
    [searchBar setShowsCancelButton:YES];
    self.searchBar=searchBar;
    self.searchBar.delegate=self;
    [self.searchBar becomeFirstResponder];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self.navigationController popToRootViewControllerAnimated:YES];
     }
//创建tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResult.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID=@"cellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if(indexPath.row==0)
        cell.textLabel.text=@"历史搜索";
    else
        
        cell.textLabel.text=self.searchResult[indexPath.row-1];
    return cell;
}
//创建tableview的数据
-(void)createTableView
{
    CGFloat heigh=self.view.bounds.size.height-SCREEN_HEIGHT;
    CGRect rect=CGRectMake(0, 0, self.view.bounds.size.width,heigh-64);
    UITableView *table=[[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    table.dataSource=self;
    table.delegate=self;
    [self.view addSubview:table];
}
//创建历史数据
-(void)createHistroyData
{
    NSString *home=NSHomeDirectory();
    NSLog(@"%@",home);
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
   NSMutableArray *arrayData=[df objectForKey:@"历史搜索"];
    self.searchResult=[NSMutableArray arrayWithArray:arrayData];
    for(NSString *str in self.searchResult)
        NSLog(@"%@",str);
    NSLog(@"111111");
}
//当点击search时搜索的记录会被写进plist文件中
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
       NSLog(@"%ld",self.searchResult.count);
    int i;
    for( i=0;i<self.searchResult.count;i++)
     {
         NSLog(@"%@",self.searchResult[i]);
         if([self.searchBar.text isEqualToString: self.searchResult[i]])
         {
             break;
         }
     }
    if(i==self.searchResult.count)
    {
        [self.searchResult insertObject:self.searchBar.text atIndex:0];
    }
    NSMutableArray *tempArray=self.searchResult;
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    [df setObject:tempArray forKey:@"历史搜索" ];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   // self.view.backgroundColor=[UIColor redColor];
    [self creatSearchBar];
    [self.searchBar becomeFirstResponder];
    [self createHistroyData];
    [self createTableView];
    
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
