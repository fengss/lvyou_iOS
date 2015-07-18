//
//  UserAdviceViewController.m
//
//  Created by coderss on 15/5/6.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "UserAdviceViewController.h"
#import "AdviceTuanView.h"
#import "HeadFile.h"
@interface UserAdviceViewController ()<AdviceTuanViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation UserAdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"我的评论";
    AdviceTuanView *view=[[[NSBundle mainBundle]loadNibNamed:@"AdviceTuanView" owner:self options:nil]lastObject];
    view.UseId=self.UserId;
    view.WayId=self.WayId;
    view.tag=162;
    view.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:view];
    view.tuanDelegate=self;
    // Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  //  self.block();
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)presentPhotoPicker
{
    UIImagePickerController *ctrl=[[UIImagePickerController alloc]init];
    ctrl.delegate=self;
    ctrl.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
   
    [self presentViewController:ctrl animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    UIButton *btn=(UIButton *)[self.view viewWithTag:900];
    [btn setImage:image forState:UIControlStateNormal];
    AdviceTuanView *view=(AdviceTuanView *)[self.view viewWithTag:162];
    view.image=image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
