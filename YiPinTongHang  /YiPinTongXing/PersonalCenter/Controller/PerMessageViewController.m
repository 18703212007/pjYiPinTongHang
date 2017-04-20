//
//  PerMessageViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/23.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "PerMessageViewController.h"
#import "PersonalViewController.h"
#import "PersonalTableViewCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "SetUpView.h"
#import "NickNameView.h"

@interface PerMessageViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic,strong)PersonView *personView;
///
@property(nonatomic,strong)UIImagePickerController *imgPicker;
///
@property(nonatomic,strong)UIImage *headerImg;

@property(nonatomic,strong)UIButton *backBtn;

///
@property(nonatomic,strong)NickNameView *nickNameView;

@end

@implementation PerMessageViewController

-(void)loadView{
    self.personView = [[PersonView alloc]initWithFrame:rect(0, 0, screen_width, screen_height)];
    self.personView.backgroundColor = [UIColor whiteColor];
    self.view = self.personView;
    self.personView.tableView.bounces = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self CostomNav];
    
    
    self.personView.tableView .delegate = self;
    self.personView.tableView.dataSource =self;
    
    [self.personView.tableView registerClass:[PreMessageHeaderTableViewCell class] forCellReuseIdentifier:@"PreMessageHeaderTableViewCell"];
     
    [self.personView.tableView registerClass:[PreMessageTableViewCell class] forCellReuseIdentifier:@"PreMessageTableViewCell"];

}






-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 2;
    }else{
        return 1;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     
     UITableViewCellAccessoryNone,                                                      // don't show any accessory view
     UITableViewCellAccessoryDisclosureIndicator,                                       // regular chevron. doesn't track
     UITableViewCellAccessoryDetailDisclosureButton __TVOS_PROHIBITED,                 // info button w/ chevron. tracks
     UITableViewCellAccessoryCheckmark,                                                 // checkmark. doesn't track
     UITableViewCellAccessoryDetailButton NS_ENUM_AVAILABLE_IOS(7_0)  __TVOS_PROHIBITED // info button. tracks
     
     */
    
    if (indexPath.section == 0) {
        PreMessageHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PreMessageHeaderTableViewCell"];
        if (cell == nil) {
            cell = [[PreMessageHeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PreMessageHeaderTableViewCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        if (indexPath.row == 0) {
            cell.textLabel.text = @"头像";
            cell.imgHeader.image = self.headerImg;
        }
        return cell;

    }else if(indexPath.section ==1){
        PreMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PreMessageTableViewCell"];
        if (cell == nil) {
            cell = [[PreMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"PreMessageTableViewCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.row) {
            case 0:{
                cell.textLabel.text = @"昵称";
                cell.showLabel.text = @"";
                break;
            }case 1:{
                cell.textLabel.text = @"性别";
                cell.showLabel.text = @"男";
                break;
            }
            default:
                break;
        }
        
        
        
        return cell;
    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PerMsgCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PerMsgCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        if (indexPath.section == 2) {
           cell.textLabel.text = @"微信";
        }else if (indexPath.section == 3){
            cell.textLabel.text = @"QQ";

        }else if (indexPath.section == 4){
            cell.textLabel.text = @"新浪微博";

        }
        
        
        return cell;
        
    }
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 45;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    PreMessageHeaderTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    [self selectedThePhoto];
                    break;
                }
                default:
                    break;
            }
            
            
            
            break;
        }case 1:{
            switch (indexPath.row) {
                case 0:{
                    
                    break;
                }case 1:{
                    PreMessageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    if ([cell.showLabel.text isEqualToString:@"男"]) {
                        cell.showLabel.text = @"女";
                    }else{
                       cell.showLabel.text = @"男";
                    }
                    break;
                }
                default:
                    break;
            }
            
            break;
        }case 2:{
            switch (indexPath.row) {
                case 0:{
                    
                    break;
                }
                default:
                    break;
            }
            
            break;
        }case 3:{
            switch (indexPath.row) {
                case 0:{
                    
                    break;
                }
                default:
                    break;
            }
            
            break;
        }

        default:
            break;
    }
    
    
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [UIView new];
    headerView.backgroundColor = RGBA(200, 200, 200, 0.3);
//    self.personView.tableView.tableHeaderView = headerView;
    return headerView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return 20;
            break;
        case 2:
            return 20;
            break;
        case 3:
            return 20;
            break;
        case 4:
            return 20;
            break;
            
        default:
            return 0;
            break;
    }
    
}


#warning 修改了!!!!

-(void)selectedThePhoto{
#warning ?

    self.modalPresentationStyle=UIModalPresentationOverCurrentContext;

    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self  selectPhoto];
    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    }];
    
    [alert addAction:photoAction];
    [alert addAction:cameraAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}



-(void)selectPhoto{
    self.imgPicker.delegate = self;
    self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imgPicker.allowsEditing = YES;
    self.imgPicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:self.imgPicker animated:YES completion:^{
        
    }];
    
}

-(void)openCamera{
    /*
     UIImagePickerControllerCameraDeviceFront 前置
     UIImagePickerControllerCameraDeviceRear 后置
     
     */
    if (iOS7&&[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]||[UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])) {
        
        self.imgPicker.delegate = self;
        self.imgPicker.allowsEditing = YES;
        self.imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imgPicker animated:YES completion:^{
            
        }];
        
    }else{
        [self alertWithMassage:@"相机不可用"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        });

    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image;
//    = [info objectForKey:UIImagePickerControllerEditedImage];
    picker.allowsEditing = YES;
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
/*************************************************************************/
        
        if (self.imgPicker.allowsEditing) {
            image = [info objectForKey:UIImagePickerControllerEditedImage];
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);


        }else{
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);

        }
        self.headerImg = [self circleImage:image withParam:1.0];
        
        
#pragma 这个地方有问题  明天继续调节

                
        
 /*************************************************************************/
    }else{
         image = [info objectForKey:UIImagePickerControllerEditedImage];
        
//        NSLog(@"%@",info);
        
        
        self.headerImg = [self circleImage:image withParam:1.0];
        
//
        
        

    }
    [self updateImgwithImg:image];

    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
   /*
    //01104 工号
    */
       [self.personView.tableView reloadData];
    
    
}




-(void)updateImgwithImg:(UIImage*)img{
    
    NSString *urlstring = @"m=Customer&c=Users&a=userLogo";
    
    NSData *imgData = UIImageJPEGRepresentation(img, 1.0f);
    
    [imgData bytes];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"yyMMddHHmm";
    
    NSString *fileName = [formatter stringFromDate:[NSDate date]];
    
    NSString *nameStr = @"file";

    
    [[AFHTTPClient shareInstance] updateWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlstring] Method:HTTPRequestPost parameters:@{@"uid":UserID,@"file":fileName} PrepareExecute:^{
        
    } constructing:^(id<AFMultipartFormData> formData) {
        
       
        
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [formData appendPartWithFileData:imgData name:nameStr fileName:[NSString stringWithFormat:@"%@.png", fileName] mimeType:@"image/png"];
        
    } progress:^(NSProgress *progress) {
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]);
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
    
    
    
    
    
    
    
}

#pragma mark - 回传 -
-(void)sendimage:(UIImage*)image{
    PersonalViewController *per = [PersonalViewController new];
    per.img = image;
}


-(UIImage*)circleImage:(UIImage*) image withParam:(CGFloat)inset{
    
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rect = rect(inset, inset, image.size.width-inset *2.0f, image.size.height- inset *2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    
    CGContextStrokePath(context);
    
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImg;
}

#pragma mark - 自定义NV -
-(void)CostomNav{
    
    __weak typeof(self) weakself = self;
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"cf292e"];
    [self.personView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.personView.mas_top).with.offset(0);
        make.left.equalTo(weakself.personView.mas_left).with.offset(0);
        make.right.equalTo(weakself.personView.mas_right).with.offset(0);
        make.height.mas_equalTo(@74);
    }];
    
    [self.backBtn setImage:[UIImage imageNamed:(@"sign_in_return.png")] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).with.offset(8);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.width.mas_equalTo(@22);
        make.height.mas_equalTo(@22);
    }];
    
    UILabel *title = [UILabel new];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.text = @"设置";
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.width.mas_equalTo(view);
        make.height.mas_equalTo(@26);
    }];
    
}


-(void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    
    
    if (error) {
        [self alertWithMassage:@"保存失败"];
    }else{
        [self alertWithMassage:@"保存成功"];
    }
    
    
}


-(void)alertNickNameEdited{
    
    
    
}



















-(void)backBtn:(UIButton*)sebder{
    [self dismissViewControllerAnimated:YES completion:nil];
    
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



#pragma mark -- 提示弹框 --
-(void)alertWithMassage:(NSString*)massage{
    
    
    CGFloat version = [[[UIDevice currentDevice]systemVersion] floatValue];
    
    if (version >= 8.0) {
        
        
      
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:massage preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertVC animated:YES completion:^{
            
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        });
        
    }
    
}




-(UIImagePickerController *)imgPicker{
    if (_imgPicker == nil) {
        _imgPicker = [UIImagePickerController new];
        _imgPicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
    }
    return _imgPicker;
}

-(UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _backBtn;
}


-(UIImage *)headerImg{
    if (_headerImg == nil) {
        _headerImg = [UIImage new];
    }
    return _headerImg;
}

@end
