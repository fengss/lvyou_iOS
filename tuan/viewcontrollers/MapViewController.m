//
//  MapViewController.m
//
//  Created by coderss on 15/5/5.
//  Copyright (c) 2015年 coderss. All rights reserved.
//

#import "MapViewController.h"
#import "HeadFile.h"
@interface MapViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate>
{
    BMKMapView* _mapView;
     bool isGeoSearch;
    BMKGeoCodeSearch* _geocodesearch;
}
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [_mapView setZoomLevel:15];
    self.navigationController.navigationBar.translucent = NO;
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    [self.view addSubview:_mapView];
    for (int i=0; i<self.mapArray.count; i++) {
        ViewDetailModel *model=self.mapArray[i];
        [self Geocode:model];
    }
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)Geocode:(ViewDetailModel *)model
{
    isGeoSearch = true;
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
           geocodeSearchOption.city=model.region_name;
        NSLog(@"model.resion_name=%@,model.Address=%@",model.region_name,model.Address);
        geocodeSearchOption.address =model.Address;
        BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
        if(flag)
        {
            NSLog(@"geo检索发送成功");
        }
        else
        {
            NSLog(@"geo检索发送失败");
        }

    
   
    

}
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSString *AnnotationViewID = @"annotationViewID";
    //根据指定标识查找一个可被复用的标注View，一般在delegate中使用，用此函数来代替新申请一个View
    BMKAnnotationView *annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    annotationView.canShowCallout = TRUE;
    return annotationView;
}
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
//    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//    //[_mapView removeAnnotations:array];
//    array = [NSArray arrayWithArray:_mapView.overlays];
//   // [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        NSString* titleStr;
        NSString* showmeg;
        
        titleStr = @"正向地理编码";
        showmeg = [NSString stringWithFormat:@"经度:%f,纬度:%f",item.coordinate.latitude,item.coordinate.longitude];
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [myAlertView show];
    }
}


-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate = nil; // 不用时，置nil
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
