//
//  appearHotol.m
//
//  Created by coderss on 15/4/9.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "appearHotol.h"
#import "hotolModel.h"
#import "NewCell.h"
#import "HeadFile.h"
#define NAVBARHIGHT 0
@interface appearHotol ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView* table;
@property(nonatomic,strong) NSMutableArray* _hotolArray;


@end

@implementation appearHotol
//创建表格
-(void)createTableview
{
    self.navigationController.navigationBar.translucent=NO;
    CGRect frame=CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    UITableView *table=[[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    table.delegate=self;
    table.dataSource=self;
    table.rowHeight=100;
    
    self.table=table;
//        hotolHead *hotolHead=[[NSBundle mainBundle] loadNibNamed:@"hotolHead" owner:nil options:nil][0];
//
//       table.tableHeaderView=hotolHead;
    table.showsVerticalScrollIndicator=NO;
    [self loadData];
    [self.view addSubview:table];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return __hotolArray.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"cellID";
    NewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"NewCell" owner:self options:nil]firstObject];
    }
    hotolModel *hotol=__hotolArray[indexPath.row];
    [cell configUI:hotol];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self createTableview];
    __hotolArray=[NSMutableArray array];
  //  [self createHotolHead];
    // Do any additional setup after loading the view.
}
-(void)createProgress
{
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.navigationController.view addSubview:v];
    v.tag=900;
    v.backgroundColor=[UIColor lightGrayColor];
     [ProgressHUD showOnView:v];
    
}
-(void)loadData
{
    [self createProgress];
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.manager POST:READHOTOLURL parameters:self.dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jondata=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array=[NSArray arrayWithArray:jondata];
        for(NSDictionary *dic in array)
        {
            hotolModel *model=[[hotolModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [__hotolArray addObject:model];
        }
        UIView *v=(UIView *)[self.navigationController.view viewWithTag:900];
        [ProgressHUD hideAfterFailOnView:v];
        [v removeFromSuperview];
        v=nil;

        [self.table reloadData];
        
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        UIView *v=(UIView *)[self.navigationController.view viewWithTag:900];
        [ProgressHUD hideAfterFailOnView:v];
        [v removeFromSuperview];
        v=nil;    }];
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
