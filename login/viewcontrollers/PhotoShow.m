//
//  PhotoShow.m
//
//  Created by coderss on 15/5/15.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "PhotoShow.h"
#import "HeadFile.h"
#import "URBMediaFocusViewController.h"
#define kCellReuseId  (@"cellId")
@interface PhotoShow ()<UICollectionViewDataSource,UICollectionViewDelegate,URBMediaFocusViewControllerDelegate>
{
    UICollectionView *_collection;
    NSMutableArray *_photoArray;
   

}
@property(nonatomic,strong) URBMediaFocusViewController* mediaFocusController;


@end

@implementation PhotoShow
//-(void)viewWillAppear:(BOOL)animated
//{
//    self.tabBarController.tabBar.hidden=YES;
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    self.tabBarController.tabBar.hidden=NO;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self  loadData];
    self.mediaFocusController = [[URBMediaFocusViewController alloc] init];
    self.mediaFocusController.delegate = self;

    
    self.view.backgroundColor=RGBCOLOR(239, 239, 244);
    _photoArray=[NSMutableArray array];
    self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=CGSizeMake(100, 100);
    layout.minimumInteritemSpacing=15;
    layout.minimumLineSpacing=25;
    layout.sectionInset=UIEdgeInsetsMake(20, 22, 10, 22);
    
    _collection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    _collection.backgroundColor=[UIColor whiteColor];
    _collection.dataSource=self;
    _collection.delegate=self;
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellReuseId];
    _collection.backgroundColor=RGBCOLOR(239, 239, 244);
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
      UIImage *p=[UIImage imageNamed:@"album-photo.png"];
       
       image.image=p;
    _collection.backgroundView=image;
    [self.view addSubview:_collection];
    // Do any additional setup after loading the view.
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photoArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseId forIndexPath:indexPath];
    for(UIView *oldSubView in cell.contentView.subviews)
    {
        [oldSubView removeFromSuperview];
    }
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    NSString *photoName=_photoArray[indexPath.item];
    NSString *url=[NSString stringWithFormat:IMAGEYUMING,photoName];
    image.contentMode = UIViewContentModeScaleAspectFill;
   image.clipsToBounds = YES;
    [image setImageWithURL:[NSURL URLWithString:url]];
    image.userInteractionEnabled=YES;
   [self addTapGestureToView:image];
    [cell.contentView addSubview:image];
    return cell;
}
-(void)loadData
{
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *str=[NSString stringWithFormat:READPHOTOBYUSER,self.UserId];
    [delegate.manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsondata=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array=[NSArray arrayWithArray:jsondata];
        for(NSArray *arr in array)
        {
             for(NSString *name in arr)
             {
                 if(![name isEqualToString:@""])
                 {
                     [_photoArray addObject:name];
                 }
                     
             }
        }
        [_collection reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error=%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addTapGestureToView:(UIView *)view {
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFocusView:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    [view addGestureRecognizer:tapRecognizer];
}
- (void)showFocusView:(UITapGestureRecognizer *)gestureRecognizer {
    
    UIImageView *photo=(UIImageView *)gestureRecognizer.view;
        [self.mediaFocusController showImage:photo.image fromView:gestureRecognizer.view];
}

#pragma mark - URBMediaFocusViewControllerDelegate Methods
- (void)mediaFocusViewControllerDidAppear:(URBMediaFocusViewController *)mediaFocusViewController {
    NSLog(@"focus view appeared");
}

- (void)mediaFocusViewControllerDidDisappear:(URBMediaFocusViewController *)mediaFocusViewController {
    NSLog(@"focus view disappeared");
}

- (void)mediaFocusViewController:(URBMediaFocusViewController *)mediaFocusViewController didFinishLoadingImage:(UIImage *)image {
    NSLog(@"focus view finished loading image");
}

- (void)mediaFocusViewController:(URBMediaFocusViewController *)mediaFocusViewController didFailLoadingImageWithError:(NSError *)error {
    NSLog(@"focus view failed loading image: %@", error);
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
