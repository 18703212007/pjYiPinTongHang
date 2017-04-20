//
//  Pro_city_areaViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/26.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "Pro_city_areaViewController.h"
#import "PersonalModel.h"
#import "AddressChooseModel.h"
@interface Pro_city_areaViewController ()
//**<UITableViewDelegate,UITableViewDataSource>

<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)UIPickerView *pickerView;
//
@property(nonatomic,strong)UIView *navView;
@property(nonatomic,strong)UIButton *btn_save;

@property(nonatomic,strong)UITableView *provinceTableView;
@property(nonatomic,strong)UITableView *cityTableView;
@property(nonatomic,strong)UITableView *areaTableView;

@property(nonatomic,assign)NSInteger   indexPro;
@property(nonatomic,assign)NSInteger   indexCity;
@property(nonatomic,assign)NSInteger   indexArea;


@property(nonatomic,strong)NSString *contantStr;

//
//@property(nonatomic,assign)BOOL   isSecond;
//
//@property(nonatomic,assign)BOOL   isThird;
//
@property(nonatomic,strong)AddressChooseModel *addressChooseModel;

@end

@implementation Pro_city_areaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self CostomNav];
    [self setPickerView];
    //    [self setTableView];
    
}


/*
 -(void)setTableView{
 
 self.provinceTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
 [self.view addSubview:self.provinceTableView];
 self.provinceTableView.tableFooterView = [UIView new];
 self.provinceTableView.delegate = self;
 self.provinceTableView.dataSource = self;
 [self.provinceTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"addressProvCell"];
 [self.provinceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
 
 make.top.equalTo(self.navView.mas_bottom).with.offset(0);
 make.left.equalTo(self.view.mas_left).with.offset(0);
 make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
 make.width.mas_equalTo(screen_width/3.0);
 
 }];
 
 
 self.cityTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
 [self.view addSubview:self.cityTableView];
 self.cityTableView.tableFooterView = [UIView new];
 self.cityTableView.delegate = self;
 self.cityTableView.dataSource = self;
 [self.cityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"addressCityCell"];
 
 self.areaTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
 [self.view addSubview:self.areaTableView];
 self.areaTableView.tableFooterView = [UIView new];
 self.areaTableView.delegate = self;
 self.areaTableView.dataSource = self;
 [self.areaTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"addressAreaCell"];
 //    [self.areaTableView mas_makeConstraints:^(MASConstraintMaker *make) {
 //
 //        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
 //        make.left.equalTo(self.cityTableView.mas_right).with.offset(0);
 //        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
 //        make.right.equalTo(self.view.mas_right).with.offset(0);
 //
 //    }];
 
 
 }
 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
 
 
 return self.provinceArray.count;
 
 }
 
 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressProvCell"];
 if (!cell) {
 cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addressProvCell"];
 }
 cell.selectionStyle =UITableViewCellSelectionStyleNone;
 
 PersonalModel *model = self.provinceArray[indexPath.row];
 cell.textLabel.adjustsFontSizeToFitWidth = YES;
 cell.textLabel.text = model.aname;
 
 return cell;
 }
 
 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 
 UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
 _contantStr = cell.textLabel.text;
 
 //    self.tableArray = self.cityArray[indexPath.row];
 //    [self.provinceTableView reloadData];
 if (tableView == _provinceTableView) {
 
 [UIView animateWithDuration:0.5 animations:^{
 
 [self.cityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
 
 make.top.equalTo(self.navView.mas_bottom).with.offset(0);
 make.left.equalTo(self.provinceTableView.mas_right).with.offset(0);
 make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
 make.width.mas_equalTo(screen_width/3.0);
 
 }];
 
 
 }];
 }
 
 
 }
 */





-(void)getMessageWithBlock:(AddressChooseBlock)block
{
    _block = block;
}




-(void)setPickerView{
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.pickerView];
    self.pickerView.backgroundColor = [UIColor lightGrayColor];
    
    // 显示选中框
    self.pickerView.showsSelectionIndicator=YES;
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).with.offset(74);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(screen_width, 300));
        
    }];
    
    [self firstString];
    
}





-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return  self.provinceArray.count;
    }else if (component ==1){
        return  [self.cityArray[self.indexPro] count];
    }else {
        return  [self.areaArray[self.indexPro][self.indexCity] count];
    }
    
    
}


-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel*)view;
    if (!pickerLabel) {
        pickerLabel = [UILabel new];
        pickerLabel.font = [UIFont systemFontOfSize:17.0];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.backgroundColor = [UIColor clearColor];
        //        pickerLabel.minimumScaleFactor
        pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    }
    
    return pickerLabel;
}


-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return screen_width/3.0;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 100;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //    NSInteger indexPro =[pickerView selectedRowInComponent:0];
    //    NSInteger indexCity = [pickerView selectedRowInComponent:1];
    
    if (component == 0) {
        PersonalModel *model =self.provinceArray[row];
        [pickerView selectRow:self.indexCity inComponent:1 animated:YES];
        [pickerView selectRow:self.indexArea inComponent:2 animated:YES];
        return model.aname;
    }else if (component == 1){
        [pickerView selectRow:self.indexArea inComponent:2 animated:YES];
        PersonalModel *model = self.cityArray[self.indexPro][row];
        return  model.aname;
    }else{
        
        PersonalModel *model =self.areaArray[self.indexPro][self.indexCity][row];
        return model.aname;
        
    }
    
    
    
    
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    if (component == 0) {
        PersonalModel *model =self.provinceArray[row];
        self.indexCity = 0;
        self.indexArea = 0;
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectedRowInComponent:1];
        [pickerView selectedRowInComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        self.addressChooseModel.provinceName = model.aname;
        self.addressChooseModel.provinceID = model.aid;
        model = [self.cityArray[row] objectAtIndex:0];
        self.addressChooseModel.cityName = model.aname;
        self.addressChooseModel.cityID = model.aid;
        model = [self.areaArray[row][0] objectAtIndex:0];
        self.addressChooseModel.areaName = model.aname;
        self.addressChooseModel.areaID = model.aid;
        self.indexPro = [pickerView selectedRowInComponent:0];
        [pickerView reloadAllComponents];
        
        
    }
    if (component == 1) {
        PersonalModel *model = [self.cityArray[[pickerView selectedRowInComponent:0]] objectAtIndex:row];
        self.indexArea = 0;
        [pickerView reloadComponent:2];
        [pickerView selectRow:[pickerView selectedRowInComponent:0] inComponent:0 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        self.addressChooseModel.cityName = model.aname;
        self.addressChooseModel.cityID = model.aid;
        
        model = self.provinceArray[[pickerView selectedRowInComponent:0]];
        self.addressChooseModel.provinceName = model.aname;
        self.addressChooseModel.provinceID = model.aid;
        
        
        
        model = [self.areaArray[[pickerView selectedRowInComponent:0]][row] objectAtIndex:0];
        self.addressChooseModel.areaName = model.aname;
        self.addressChooseModel.areaID = model.aid;
        
        self.indexPro = [pickerView selectedRowInComponent:0];
        
        self.indexCity = [pickerView selectedRowInComponent:1];
        [pickerView reloadAllComponents];
        
        
        
    }
    if (component == 2) {
        PersonalModel *model =self.areaArray[[pickerView selectedRowInComponent:0]][[pickerView selectedRowInComponent:1]][row];
        self.addressChooseModel.areaName = model.aname;
        self.addressChooseModel.areaID = model.aid;
        model = self.provinceArray[[pickerView selectedRowInComponent:0]];
        self.addressChooseModel.provinceID = model.aid;
        self.addressChooseModel.provinceName = model.aname;
        model = self.cityArray[[pickerView selectedRowInComponent:0]][[pickerView selectedRowInComponent:1]];
        
        self.addressChooseModel.cityID = model.aid;
        self.addressChooseModel.cityName = model.aname;
        self.indexPro =  [pickerView selectedRowInComponent:0];
        
        self.indexCity = [pickerView selectedRowInComponent:1];
        
        self.indexArea = [pickerView selectedRowInComponent:2];
        [pickerView reloadAllComponents];
    }
    
    
    
    
    
    
}


-(void)firstString{
    
    PersonalModel *model = self.provinceArray[0];
    self.addressChooseModel.provinceName = model.aname;
    self.addressChooseModel.provinceID = model.aid;
    model = self.cityArray[0][0];
    self.addressChooseModel.cityName = model.aname;
    self.addressChooseModel.cityID = model.aid;
    model = self.areaArray[0][0][0];
    self.addressChooseModel.areaName = model.aname;
    self.addressChooseModel.areaID = model.aid;
    
    
}



-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSAttributedString *attrString = [NSAttributedString new];
    return attrString;
}



#pragma mark - 自定义NV -
-(void)CostomNav{
    __weak typeof(self) weakself = self;
    
    self.navView = [UIView new];
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.view.mas_top).with.offset(0);
        make.left.equalTo(weakself.view.mas_left).with.offset(0);
        make.right.equalTo(weakself.view.mas_right).with.offset(0);
        make.height.mas_equalTo(@74);
    }];
    
    
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"#cf292e"];
    [self.navView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UILabel *title = [UILabel new];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.text = @"新增收货地址";
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.width.mas_equalTo(view);
        make.height.mas_equalTo(@26);
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:(@"sign_in_return.png")] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).with.offset(8);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.width.mas_equalTo(@22);
        make.height.mas_equalTo(@22);
    }];
    
    
    self.btn_save = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_save.titleLabel.textColor = [UIColor whiteColor];
    [self.btn_save setTitle:@"保存" forState:UIControlStateNormal];
    [view addSubview:self.btn_save];
    [self.btn_save addTarget:self action:@selector(btn_save:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_save mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).with.offset(-10);
        make.top.equalTo(view.mas_top).with.offset(35);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@50);
    }];
    
    
}

-(void)backBtn:(UIButton*)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}




-(void)btn_save:(UIButton*)sender{
    
    self.contantStr =[NSString stringWithFormat:@"%@ %@ %@",self.addressChooseModel.provinceName,self.addressChooseModel.cityName,self.addressChooseModel.areaName];
    
    
    if (self.block) {
        self.block(self.contantStr,self.addressChooseModel);
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(AddressChooseModel *)addressChooseModel{
    if (!_addressChooseModel) {
        _addressChooseModel = [AddressChooseModel new];
    }
    return _addressChooseModel;
}
//
//
//
//-(void)dealloc{
//    self.provinceArray = nil;
//    self.cityArray = nil;
//    self.areaArray = nil;
//    self.addressChooseModel  = nil;
//}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
