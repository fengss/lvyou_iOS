//
//  RegionViewController.m
//
//  Created by coderss on 15/4/21.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "RegionViewController.h"
#import "HeadFile.h"
#import "parentRegionModel.h"
@interface RegionViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,MJRefreshBaseViewDelegate>
{
    int page;
}
@property(nonatomic,strong) UITableView* table;
@property(nonatomic,strong) NSMutableArray* searchArray;
@property(nonatomic,strong) UISearchBar* searchbar;
@property(nonatomic,strong) NSMutableDictionary* arrayData;
@property(nonatomic,strong) NSTimer *time;
@property(nonatomic,strong) MJRefreshHeaderView* header;
@property(nonatomic,strong) MJRefreshFooterView* footer;

@end

@implementation RegionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self createtableview];
    self.navigationController.navigationBar.translucent=YES;
    [self createSearchbar];
    [self loadDataWithParentId:1 WithIsPage:1 WithPage:0 WithMj:NO];
    [self createFresh];
    [self createMJFresh];
    
    // Do any additional setup after loading the view.
}
-(NSMutableArray *)searchArray
{
    if(_searchArray==nil)
        _searchArray=[[NSMutableArray alloc]init];
    return _searchArray;
}
-(NSMutableDictionary *)arrayData
{
    if(_arrayData==nil)
    {
        _arrayData=[[NSMutableDictionary alloc]init];
    }
    return _arrayData;
}
#pragma mark-创建tableview
-(void)createtableview
{
    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH , SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [self.view addSubview:table];
    self.table=table;
    self.table.dataSource=self;
    self.table.delegate=self;
    self.table.sectionHeaderHeight=50;
    self.table.sectionFooterHeight=0;
    self.table.showsVerticalScrollIndicator=NO;
  
  
}
#pragma mark-tableview的协议方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1+self.parentArray.count;
   // return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        if(self.searchArray.count!=0)
        return self.searchArray.count;
        else
            return 1;
    }
    else
    {
            parentRegionModel *parentmodel=self.parentArray[section-1];
           NSMutableDictionary *dic=[self.arrayData objectForKey:parentmodel.region_id];
          BOOL expand =[[dic objectForKey:@"KEY_STATE"] boolValue];
       // NSLog(@",section=%ld,ex=%d",section,expand);
          if(expand)
          {
             // NSLog(@"expand=%d",expand);
              NSArray *aray=[dic objectForKey:@"KEY_ARRAY"];
            return aray.count;
          }
        else
            return 0;
        
    
    
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"cellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
   
    if(indexPath.section==0)
        
    {
        //NSLog(@"%@",self.searchArray);
        if(self.searchArray.count!=0)
           cell.textLabel.text=self.searchArray[indexPath.row];
        else
            cell.textLabel.text=@"无";
        
    }
    else
    {
        parentRegionModel *parentmodel=self.parentArray[indexPath.section-1];
        NSDictionary *dic=[self.arrayData objectForKey:parentmodel.region_id];
        NSArray *array =[dic objectForKey:@"KEY_ARRAY"];
        parentRegionModel *model=array[indexPath.row];
        cell.textLabel.text=model.region_name;
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    parentRegionModel *parentmodel=self.parentArray[indexPath.section-1];
    NSDictionary *dic=[self.arrayData objectForKey:parentmodel.region_id];
    NSArray *array =[dic objectForKey:@"KEY_ARRAY"];
    parentRegionModel *model=array[indexPath.row];
    self.block(model.region_id,model.region_name);
    [self.navigationController popViewControllerAnimated:YES];
 

}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        UIView *view=[[UIView alloc]init];
        //
        view.backgroundColor=RGBCOLOR(239,239, 239);
        UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        name.text=@"历史选择城市";
        name.font=[UIFont systemFontOfSize:15];
        [view addSubview:name];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(290, 8, 75, 30);
        btn.layer.borderWidth=1;
        btn.layer.borderColor=RGBCOLOR(57, 183, 56).CGColor;
        btn.layer.cornerRadius=5;
        btn.layer.masksToBounds=YES;
        [btn setTitle:@"清除记录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clearclick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [view addSubview:btn];
         return view;
    }
    else
    {
        UIView *view=[[UIView alloc]init];
        view.backgroundColor=RGBCOLOR(239,239, 239);
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0 , 0, SCREEN_WIDTH, 50);
                  parentRegionModel *model=self.parentArray[section-1];
                UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(5,15, 20, 20)];
        
        parentRegionModel *parentmodel=self.parentArray[section-1];
        NSMutableDictionary *dic=[self.arrayData objectForKey:parentmodel.region_id];
        //    NSArray *arr=[dic objectForKey:@"KEY_ARRAY"];
        BOOL expand=[[dic objectForKey:@"KEY_STATE"] boolValue];
        if(expand)
        {
          image.image=[UIImage imageNamed:@"z.png"] ;
            UIView *line=(UIView *)[self.view viewWithTag:750+section];
            [line removeFromSuperview];
           
        }
        else
        {
            image.image=[UIImage imageNamed:@"x.png"];
            UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0,49, SCREEN_WIDTH, 1)];
            line.backgroundColor=[UIColor whiteColor];
            view.frame=CGRectMake(0, 0, SCREEN_WIDTH, 52);
            line.tag=750+section;
            [view addSubview:line];
        }
        [btn addSubview:image];
        image.tag=250+section;
        [btn setTitle:model.region_name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal ];
        btn.tag=300+section;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(regionclick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
       
              [view addSubview:btn];
        

        return view;

    }
    return nil;
    
   
}
-(void)regionclick:(UIButton *)btn
{
    NSLog(@"我被点击了");
    
        parentRegionModel *parentmodel=self.parentArray[btn.tag-300-1];
       NSMutableDictionary *dic=[self.arrayData objectForKey:parentmodel.region_id];
 //    NSArray *arr=[dic objectForKey:@"KEY_ARRAY"];
       BOOL expand=[[dic objectForKey:@"KEY_STATE"] boolValue];
    NSInteger t=250+btn.tag-300;
    NSDictionary *dict=@{@"KEY_STATE":[NSNumber numberWithBool:expand],
                        @"TAG":[NSNumber numberWithInteger:t]
                        };
        [dic setObject:[NSNumber numberWithBool:!expand] forKey:@"KEY_STATE"];
    NSTimer  *time=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updatetime:) userInfo:dict repeats:NO];
    self.time=time;

    [self.arrayData setObject:dic forKey:parentmodel.region_id];
//   NSMutableDictionary *d=[self.arrayData objectForKey:parentmodel.region_id];
    
 //   NSLog(@"d=%@",[d objectForKey:@"KEY_STATE"]);
    [self.table reloadData];

}
-(void)updatetime:(NSTimer *)time
{
    NSDictionary *dic=time.userInfo;
    BOOL res=[[dic objectForKey:@"KEY_STATE"] boolValue];
    NSInteger t=[[dic objectForKey:@"TAG"] integerValue];
   
       UIImageView *image=(UIImageView *)[self.view viewWithTag:t];
    NSLog(@"res=%d",res);
       if(res==NO)
       {
           image.image=[UIImage imageNamed:@"z.png"];
       }
    else
    {
        image.image=[UIImage imageNamed:@"x.png"];
    }

}
-(void)clearclick:(UIButton *)btn
{
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    [df setObject:nil forKey:@"地区历史搜索" ];
    [df synchronize];
    [self.searchArray removeAllObjects];
    self.searchArray=nil;
    [self.table reloadData];
}
#pragma mark-创建搜索栏
-(void)createSearchbar
{
   UINavigationItem *item =self.navigationItem;
    UISearchBar *search=[[UISearchBar alloc]initWithFrame:CGRectMake(0,0, 100,50)];
    search.placeholder=@"选择省份或直辖市";
    search.delegate=self;
    self.searchbar=search;
    item.titleView=search;
}
#pragma mark-创造历史纪录
-(void)createHistroyData
{
    NSString *home=NSHomeDirectory();
    NSLog(@"%@",home);
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    NSMutableArray *arrayData=[df objectForKey:@"地区历史搜索"];
    self.searchArray=[NSMutableArray arrayWithArray:arrayData];
}
#pragma mark-searchbar协议
//当点击search时搜索的记录会被写进plist文件中
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
       int i;
    for( i=0;i<self.searchArray.count;i++)
    {
        if([self.searchbar.text isEqualToString: self.searchArray[i]])
        {
            break;
        }
    }
    if(i==self.searchArray.count)
    {
        [self.searchArray insertObject:self.searchbar.text atIndex:0];
    }
    NSMutableArray *tempArray=self.searchArray;
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    [df setObject:tempArray forKey:@"地区历史搜索" ];
    [df synchronize];
    [searchBar resignFirstResponder];
    
}
-(NSMutableArray *)parentArray
{
    if(_parentArray==nil)
        _parentArray=[[NSMutableArray alloc]init];
    return _parentArray;
}
//@"http://ly.coderss.cn/index.php?m=Cwl&a=selectregion&parent_id=%d&page=%@&isPage=%d"

#pragma mark-加载数据
-(void)loadDataWithParentId:(int)parent_id WithIsPage:(int)isPage WithPage:(int)p WithMj:(BOOL)res
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString *url=[NSString stringWithFormat:RESIONURL,parent_id,[NSString stringWithFormat:@"%d",p],isPage];
   // NSLog(@"resigonurl=%@",url);
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsondata=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *data=[NSArray arrayWithArray:jsondata];
         NSLog(@"parent_id=%d res=%d",parent_id,res);
           if(res)
           {
              

              [self.parentArray removeAllObjects];
               [self.arrayData removeAllObjects];
           }
       if(parent_id==1)//等到中国parent_id=1
       {
        for(NSDictionary *dic in data)
        {
            parentRegionModel *model=[[parentRegionModel alloc]init];
          [model setValuesForKeysWithDictionary:dic];
            [self.parentArray addObject:model];
            //[self loadDataWithParentId:[[model.region_id intValue]] WithIsPage:@"NO" WithPage:0  ];
            [self loadDataWithParentId:[model.region_id intValue] WithIsPage:0 WithPage:0  WithMj:NO];
            
        }
        }
        else
        {
            NSMutableArray *array=[NSMutableArray arrayWithCapacity:0];
            for(NSDictionary *dic in data)
            {
                parentRegionModel *model=[[parentRegionModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [array addObject:model];

            }
            
            NSDictionary *dic=@{@"KEY_ARRAY":array,
                                       @"KEY_STATE":[NSNumber numberWithBool:NO]
                                       };
            NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:dic];
            [self.arrayData setObject:dict forKey:[NSString stringWithFormat:@"%d",parent_id]];
            }
        UIView *view=[self.view viewWithTag:200];
        [ProgressHUD hideOnView:view];
        [view removeFromSuperview];
        view=nil;
        [self.header endRefreshing];
        [self.footer endRefreshing];
        [self.table reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.header endRefreshing];
        [self.footer endRefreshing];
        NSLog(@"%@",error);
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self createHistroyData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-创建加载工具
-(void)createFresh
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    view.tag=200;
    [self.view addSubview:view];
    view.backgroundColor=[UIColor whiteColor];
    [ProgressHUD showOnView:view];
}
#pragma mark-创建上拉下载
-(void)createMJFresh
{
    self.header=[MJRefreshHeaderView header];
    self.header.delegate=self;
    self.header.scrollView=self.table;
    self.footer=[MJRefreshFooterView footer];
    self.footer.delegate=self;
    self.footer.scrollView=self.table;
    
}
#pragma mark-实现mj的代理
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if(refreshView==self.header)
    {
        page=0;
        //[self loadDataWithRegion:@"25" WithIsHead:YES WithPage:[NSString stringWithFormat:@"%d",page ]];
        [self loadDataWithParentId:1 WithIsPage:1 WithPage:page WithMj:YES];
    }
    else
    {
        page++;
        [self loadDataWithParentId:1 WithIsPage:1 WithPage:page WithMj:NO];

    }
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
