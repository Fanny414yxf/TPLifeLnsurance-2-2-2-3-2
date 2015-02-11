//
//  RegistrationViewController.m
//  TPLifeLnsurance
//
//  Created by rimi on 15-2-2.
//  Copyright (c) 2015年 Yangxiaofen. All rights reserved.
//

#import "RegistrationViewController.h"
#import "MyNavcView.h"
#import "MyTextField.h"
@interface RegistrationViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong)UIButton * type_button;
@property (nonatomic,strong)UIButton * next_button;
@property (nonatomic,strong)UIPickerView * typePicker;
@property (nonatomic,strong)NSArray * type;
@property (nonatomic,strong)UIView * pickerBackground ;

@property (nonatomic,strong)MyTextField * idNbumebr;
@property (nonatomic,strong)MyTextField * nametf;
@property (nonatomic,assign)NSInteger credentialsTyp;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView  * navc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)]
    ;
    navc.backgroundColor = COLOR(33, 63, 123, 1);
    [self.view addSubview:navc];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 100, 30)];
    titleLabel.text = @"用户注册";
    titleLabel.textColor = [UIColor whiteColor];
    [navc addSubview:titleLabel];
    UIButton * comeBack = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 40, 40)];
    [comeBack setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [comeBack addTarget:self action:@selector(processComeBackButton) forControlEvents:UIControlEventTouchUpInside];
    [navc addSubview:comeBack];
//    MyNavcView * navcView = [[MyNavcView alloc] init];
//    [self.view addSubview:navcView];
    
    
    _next_button = [[UIButton alloc] initWithFrame:CGRectMake(30, 280, 280, 50)];
    [_next_button setTitle:@"下一步" forState:UIControlStateNormal];
    [_next_button addTarget:self action:@selector(processNextButton) forControlEvents:UIControlEventTouchUpInside];
    _next_button.backgroundColor = [UIColor blueColor];
    _next_button.layer.cornerRadius = 5;
    [self.view addSubview:_next_button];
    
    
    _type = @[@"身份证",@"军官证",@"护照"];
    _pickerBackground  =[[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _pickerBackground.hidden = YES;
    _pickerBackground.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.4];
    [self.view addSubview:_pickerBackground];
    _typePicker  = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 400, SCREEN_WIDTH, 240)];
    _typePicker.showsSelectionIndicator = YES;
    _typePicker.dataSource = self;
    _typePicker.delegate = self;
    _typePicker.backgroundColor = [UIColor whiteColor];
    [_pickerBackground addSubview:_typePicker];

    _type_button = [[UIButton alloc] initWithFrame:CGRectMake(30, 80, 280, 50)];
    _type_button.layer.borderWidth = 1;
    [_type_button setTitle:@"身份证" forState:UIControlStateNormal];
    [_type_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _type_button.backgroundColor = [UIColor cyanColor];
    [_type_button setImage:[UIImage imageNamed:@"arrowDown.png"] forState:UIControlStateNormal];
    _type_button.imageEdgeInsets = UIEdgeInsetsMake(10, 240, 10, 10);
    [_type_button addTarget:self action:@selector(processTypeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_type_button];
    
    

    _idNbumebr = [[MyTextField alloc] initWithFrame:CGRectMake(30, 150, 280, 50)];
    _idNbumebr.placeholder = @"请输入证件号码";
    _idNbumebr.layer.borderColor = [[UIColor grayColor]CGColor];
    _idNbumebr.layer.cornerRadius = 5;
    [self.view addSubview:_idNbumebr];
    
    _nametf = [[MyTextField alloc] initWithFrame:CGRectMake(30, 220, 280, 50)];
    _nametf.placeholder = @"请输入真是姓名";
    _nametf.layer.borderColor = [[UIColor grayColor]CGColor];
    _nametf.layer.cornerRadius = 5;
    [self.view addSubview:_nametf];
    
    

    
    
    

    
}







- (void)processComeBackButton
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


- (void)processNextButton
{
    if ([_type_button.titleLabel.text isEqualToString:@"身份证"]) {
        _credentialsTyp = 1;
    }else if ([_type_button.titleLabel.text isEqualToString:@"军官证"]){
        _credentialsTyp = 2;
    }else{
        _credentialsTyp = 3;
    }
    if (_idNbumebr == nil) {
        NSLog(@"dfsgs");
    }else if (_nametf == nil){
        NSLog(@"ccccccccccccccccc");
    }else{
    [NetWork sendRegister1WithRequestWithCredentialsNo:_idNbumebr.text credentialsType:[NSString stringWithFormat:@"%ld",(long)_credentialsTyp] name:_nametf.text Callback:^(id result) {
        NSLog(@"注册的一步%@",result);
    }];
        
    }
}


- (void)processTypeButton:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        _pickerBackground.hidden = NO;
    }else{
        _pickerBackground.hidden = YES;
    }
}

//列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _type.count;
}


//行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%@",_type[row]];
    
}
//选择了某粒某行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _type_button.titleLabel.text = _type[row];

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
