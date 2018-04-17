//
//  ViewController.m
//  YBImageBrowserDemo
//
//  Created by 杨少 on 2018/4/10.
//  Copyright © 2018年 杨波. All rights reserved.
//

#import "ViewController.h"
#import "YBImageBrowser.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDWebImageDownloader.h>
#import "YBImageBrowserAnimatedTransitioning.h"

#define CELLSIZE CGSizeMake(YB_SCREEN_WIDTH/3, (YB_SCREEN_WIDTH/3))
static int tagOfImageOfCell = 100;

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, YBImageBrowserDataSource, YBImageBrowserDelegate> {
    NSArray *dataArr;
    NSIndexPath *touchIndexPath;
}
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController


#pragma mark core code
- (void)showWithIndexPath:(NSIndexPath *)indexPath {
    
    touchIndexPath = indexPath;
    
    YBImageBrowserModel *model0 = [YBImageBrowserModel new];
    model0.image = [UIImage imageNamed:dataArr[0]];
    model0.sourceImageView = [self getImageViewOfCellByIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    YBImageBrowserModel *model1 = [YBImageBrowserModel new];
    model1.gifName = dataArr[1];
    model1.sourceImageView = [self getImageViewOfCellByIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    YBImageBrowserModel *model2 = [YBImageBrowserModel new];
    model2.url = [NSURL URLWithString:dataArr[2]];
    model2.sourceImageView = [self getImageViewOfCellByIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    YBImageBrowserModel *preview2 = [YBImageBrowserModel new];
    preview2.image = [UIImage imageNamed:@"image2"];
    model2.previewModel = preview2;
    
    YBImageBrowserModel *model3 = [YBImageBrowserModel new];
    model3.url = [NSURL URLWithString:dataArr[3]];
    model3.sourceImageView = [self getImageViewOfCellByIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    YBImageBrowserModel *model4 = [YBImageBrowserModel new];
    model4.image = [UIImage imageNamed:dataArr[4]];
    model4.sourceImageView = [self getImageViewOfCellByIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.currentIndex = indexPath.row;
    browser.dataArray = @[model0, model1, model2, model3, model4];
    browser.yb_supportedInterfaceOrientations = UIInterfaceOrientationMaskAll;
    
    YBImageBrowserFunctionModel *shareModel = [YBImageBrowserFunctionModel new];
    shareModel.name = @"分享给好友";
    browser.fuctionDataArray = @[[YBImageBrowserFunctionModel functionModelForSavePictureToAlbum], shareModel];
    
//    browser.dataSource = self;
    browser.delegate = self;
    [browser show];
}

#pragma mark YBImageBrowserDelegate
- (void)yBImageBrowser:(YBImageBrowser *)imageBrowser didScrollToIndex:(NSInteger)index {
//    NSLog(@"%@ : %ld", NSStringFromSelector(_cmd), index);
}
- (void)yBImageBrowser:(YBImageBrowser *)imageBrowser clickFunctionBarWithModel:(YBImageBrowserFunctionModel *)model {
//    NSLog(@"%@ : %@", NSStringFromSelector(_cmd), model.name);
}

#pragma mark YBImageBrowserDataSource
- (UIImageView *)imageViewOfTouchForImageBrowser:(YBImageBrowser *)imageBrowser {
    return [self getImageViewOfCellByIndexPath:touchIndexPath];
}
- (YBImageBrowserModel *)yBImageBrowser:(YBImageBrowser *)imageBrowser modelForCellAtIndex:(NSInteger)index {
    YBImageBrowserModel *model = [YBImageBrowserModel new];
    if (index == 0) {
        model.image = [UIImage imageNamed:dataArr[0]];
        model.sourceImageView = [self getImageViewOfCellByIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    } else if (index == 1) {
        model.gifName = dataArr[1];
        model.sourceImageView = [self getImageViewOfCellByIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    } else if (index == 2) {
        model.url = [NSURL URLWithString:dataArr[2]];
        model.sourceImageView = [self getImageViewOfCellByIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    } else if (index == 3) {
        model.url = [NSURL URLWithString:dataArr[3]];
        model.sourceImageView = [self getImageViewOfCellByIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    } else if (index == 4) {
        model.image = [UIImage imageNamed:dataArr[4]];
        model.sourceImageView = [self getImageViewOfCellByIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    }
    return model;
}
- (NSInteger)numberInYBImageBrowser:(YBImageBrowser *)imageBrowser {
    return dataArr.count;
}












- (UIImageView *)getImageViewOfCellByIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    if (!cell) return nil;
    return [cell.contentView viewWithTag:tagOfImageOfCell];
}


#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr = @[@"image0", @"gif0", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1523382489676&di=bcd55b2dd64141ced8c52b46309280da&imgtype=0&src=http%3A%2F%2Ff2.topitme.com%2F2%2Fb9%2F71%2F112660598401871b92l.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1523386869420&di=015d95da30b54296e10cb63ee740d8d9&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01c6e25889bd4ca8012060c80f8067.gif", @"imageLong"];
    [self.view addSubview:self.collectionView];
}
#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    FLAnimatedImageView *imgView = [cell.contentView viewWithTag:tagOfImageOfCell];
    if (!imgView) {
        imgView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, CELLSIZE.width, CELLSIZE.height)];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.layer.masksToBounds = YES;
        imgView.tag = tagOfImageOfCell;
        [cell.contentView addSubview:imgView];
    }
    //演示程序，请不要在意性能
    switch (indexPath.row) {
        case 0: {
            imgView.image = [UIImage imageNamed:dataArr[0]];
        }
            break;
        case 1: {
            NSString *filePath = [[NSBundle mainBundle] pathForResource:dataArr[1] ofType:@"gif"];
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            imgView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
        }
            break;
        case 2: {
            [imgView sd_setImageWithURL:[NSURL URLWithString:dataArr[2]]];
        }
            break;
        case 3: {
            [imgView sd_setImageWithURL:[NSURL URLWithString:dataArr[3]]];
//            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:dataArr[3]] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//                imgView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
//            }];
        }
            break;
        case 4: {
            imgView.image = [UIImage imageNamed:@"imageLong"];
        }
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CELLSIZE;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self showWithIndexPath:indexPath];
}
#pragma mark getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, YB_SCREEN_WIDTH, CELLSIZE.height*2) collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}

#pragma mark test button event

- (IBAction)clickClearButton:(id)sender {
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
}

#pragma mark orientation

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end