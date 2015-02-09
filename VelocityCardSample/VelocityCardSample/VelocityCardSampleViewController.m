//
//  VelocityCardSampleViewController.m
//  VelocityCardSample
//
//  Created by Chetu on 1/16/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "VelocityCardSampleViewController.h"
#import "VelocityConstant.h"
#import "VelocityProcessor.h"
#import "VelocityPaymentTransaction.h"
#import "BankcardTransactionResponsePro.h"
#import "ErrorPaymentResponse.h"
#import "ResponseViewViewController.h"
#import "MBProgressHUD.h"
@interface VelocityCardSampleViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,VelocityProcessorDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UITextField *nameTxtField;
@property (strong, nonatomic) IBOutlet UITextField *streetTxtField;
@property (strong, nonatomic) IBOutlet UITextField *cityTxtField;
@property (strong, nonatomic) IBOutlet UITextField *zipTxtField;
@property (strong, nonatomic) IBOutlet UITextField *countryTxtField;
@property (strong, nonatomic) IBOutlet UITextField *emailTxtField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTxtField;
@property (strong, nonatomic) IBOutlet UITextField *testCashTxtField;
@property (strong, nonatomic) IBOutlet UITextField *testCashAdjustTxtFeild;
@property (strong, nonatomic) IBOutlet UITextField *creditCardNotxtField;
@property (strong, nonatomic) IBOutlet UITextField *cVCtxtField;
@property (weak, nonatomic)   IBOutlet UITextField *yearTextField;
@property (weak, nonatomic)   IBOutlet UITextField *monthTextField;
@property (weak, nonatomic)   IBOutlet UIButton *processPaymentBtn;
@property (weak, nonatomic)   IBOutlet UIButton *stateBtn;
@property (weak, nonatomic)   IBOutlet UIButton *cardTypeBtn;
@property (weak, nonatomic)   IBOutlet UIButton *transactionTypebtn;
@property (weak, nonatomic) IBOutlet UITextField *currencyCodeTxtField;
@property (weak, nonatomic) IBOutlet UITextField *customerIDtxtField;

- (IBAction)cardTypeBtn:(id)sender;
- (IBAction)processPaymentBtn:(id)sender;
- (IBAction)stateBtn:(id)sender;
- (IBAction)transactionTypebtn:(id)sender;




@end

@implementation VelocityCardSampleViewController
{
    NSArray *tranxTypearr;
    NSArray *cardTypearr;
    NSArray *stateArr;
    //velocity processor object
    VelocityProcessor *velocityProcessorObj;
    UIButton *btntag;
    UIView *chiledView;
    //velocityProcessorTransactionModelClass Object
    VelocityPaymentTransaction *vPTMCObj;
    
    
    UIToolbar *toolBar;
    ResponseViewViewController *respViewObj;
    int switchcaseInput;
}
/*!
 *  @author sumit suman, 15-01-23 17:01:36
 *
 *  @brief  Velocity card sample app
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.scrollView.contentSize  = CGSizeMake(self.view.frame.size.width, 2300);
    self.pickerView.hidden=YES;
    
    self.transactionTypebtn.layer.cornerRadius=5;
    self.transactionTypebtn.layer.masksToBounds = YES;
    self.processPaymentBtn.layer.cornerRadius=5;
    self.processPaymentBtn.layer.borderWidth=1.0;
    self.processPaymentBtn.layer.borderColor=[[UIColor whiteColor]CGColor];
    self.processPaymentBtn.layer.masksToBounds = YES;
    self.stateBtn.layer.cornerRadius=5;
    self.stateBtn.layer.masksToBounds = YES;
    self.cardTypeBtn.layer.cornerRadius=5;
    self.cardTypeBtn.layer.masksToBounds = YES;
    
    
     tranxTypearr=[[NSArray alloc]initWithObjects:@"Verify",@"Authorize w/ Token",@"Authorise w/o Token",@"AuthAndCapture w/ Token",@"AuthAndCapture w/o token",@"Capture",@"Void(Undo)",@"Adjust",@"ReturnById",@"ReturnUnlinked", nil];
    cardTypearr=[[NSArray alloc]initWithObjects:@"Visa",@"Master",@"Discover",@"American Express", nil];
    stateArr=[[NSArray alloc]initWithObjects:@"Colorado",@"Newyork", nil];
    [self.transactionTypebtn setTitle:[NSString stringWithFormat:@"%@",[tranxTypearr objectAtIndex:0]] forState:UIControlStateNormal];
    [self.stateBtn setTitle:[NSString stringWithFormat:@"%@",[stateArr objectAtIndex:0]] forState:UIControlStateNormal];
    [self.cardTypeBtn setTitle:[NSString stringWithFormat:@"%@",[cardTypearr objectAtIndex:0]] forState:UIControlStateNormal];
    
     toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-_pickerView.frame.size.height-42,_pickerView.frame.size.width,44)];
    /*!
     initializing velocity processor object
     
     */
    
    velocityProcessorObj=[[VelocityProcessor alloc] init];
    velocityProcessorObj.delegate=self;
    
   
    /*!
     passing required data to velocity processor class

     
     set the mode of operation i.e testing or production
     */
        [velocityProcessorObj initWith:kIdentityToken forAppProfileId:kAppProfileId forMerchantProfileId:kMerchantProfileId forWorkflowId:KWorkflowId andType:kisTestAccountBOOL];
    
    /*!
     *  @author sumit suman, 15-01-23 18:01:30
     *
     *  @brief  call sign on method
     */
    //[velocityProcessorObj signOnWithIdentityToken];
    
    /*!
     velocity payment transaction modal calss
     velocity transactionmodalclass object
     */
    
    vPTMCObj=[PaymentObjecthandler getModelObject];
        
    respViewObj =[[ResponseViewViewController alloc]init];
}

#pragma mark-VelocityProcessorDelegate
//for sucess of velocity processor object
/*!
 *  @author sumit suman, 15-01-23 17:01:50
 *
 *  @brief  delegate method of velocity processor class
 *  @param successString provides sucess message passed by velocity processor class
 */
-(void)VelocityProcessorFinishedWithSuccess:(id )successAny{
  //  NSLog(@"%@",successString);
    
//    [[[UIAlertView alloc]initWithTitle:@"Message" message:successAny delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"bundle:nil];
    ResponseViewViewController *subView =[storyboard instantiateViewControllerWithIdentifier:@"ResponseViewViewController"];
    
    [self presentViewController:subView
                       animated:YES
                     completion:nil];
     [MBProgressHUD hideHUDForView:self.view animated:YES];
}
//for faileur of methods call from velocity processor object
-(void)VelocityProcessorFailedWithErrorMessage:( id)failedAny{
    [[[UIAlertView alloc]initWithTitle:@"Error" message:failedAny delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
     [MBProgressHUD hideHUDForView:self.view animated:YES];
}

//creating piker view
-(void)labelTapped{
   
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(donePiker:)];
    toolBar.items = [[NSArray alloc] initWithObjects:barButtonDone,nil];
    barButtonDone.tintColor=[UIColor whiteColor];
    [self.view addSubview:toolBar];
    [self.view addSubview:self.pickerView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerView.hidden=NO;


        _pickerView.frame = CGRectMake(_pickerView.frame.origin.x,
                                       self.view.frame.size.height-160,                                        _pickerView.frame.size.width,
                                       _pickerView.frame.size.height);
        
        
    }];
    
    
    [_pickerView reloadAllComponents];
}

//hiding pikerview
-(IBAction)donePiker:(id)sender{
    
    
    [toolBar removeFromSuperview];
    [_pickerView removeFromSuperview];
    
    
}

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView 
numberOfRowsInComponent:(NSInteger)component{
    if (btntag.tag==2000)
        return [tranxTypearr count];
    else if (btntag.tag==1000)
        return [stateArr count];
    
    else
        return [cardTypearr count];
    
    
   }

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
 

    if (btntag.tag==2000){
       [self.transactionTypebtn setTitle:[NSString stringWithFormat:@"%@",[tranxTypearr objectAtIndex:row]] forState:UIControlStateNormal];
    vPTMCObj.transactionName =[NSString stringWithFormat:@"%@",[tranxTypearr objectAtIndex:row]];
        switchcaseInput = row;
    }
    else if (btntag.tag==1000)
        [self.stateBtn setTitle:[NSString stringWithFormat:@"%@",[stateArr objectAtIndex:row]] forState:UIControlStateNormal];
    
    else
        [self.cardTypeBtn setTitle:[NSString stringWithFormat:@"%@",[cardTypearr objectAtIndex:row]] forState:UIControlStateNormal];

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    
    if (btntag.tag==2000)
    return [tranxTypearr objectAtIndex:row];
     else if (btntag.tag==1000)
     return [stateArr objectAtIndex:row];
         else
             return [cardTypearr objectAtIndex:row];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch view] != self.pickerView){
        [self.pickerView endEditing:YES];
    self.pickerView.hidden=YES;
    self.scrollView.hidden=NO;
        [self.pickerView removeFromSuperview];
        [[self view] endEditing:YES];
      [super touchesBegan:touches withEvent:event];
       
        
    }
     [toolBar removeFromSuperview];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSAttributedString *attString;
    if (btntag.tag==2000){
        attString = [[NSAttributedString alloc] initWithString:[tranxTypearr objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    return attString;
    }
    else if (btntag.tag==1000){
        attString = [[NSAttributedString alloc] initWithString:[stateArr objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    return attString;
    }
    else
    {
       attString = [[NSAttributedString alloc] initWithString:[cardTypearr objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    return attString;
    }
    

    
}


#pragma mark-textfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{    [toolBar removeFromSuperview];
    [_pickerView removeFromSuperview];
//    CGPoint scrollPoint = CGPointMake(0, 800);
//    [_scrollView setContentOffset:scrollPoint animated:YES];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    //[_scrollView setContentOffset:CGPointZero animated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [toolBar removeFromSuperview];
    [_pickerView removeFromSuperview];
    return YES;
    
}
#define MAXLENGTH 2

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _monthTextField ||textField == _yearTextField  ) {
        NSUInteger oldLength = [textField.text length];
        
        NSUInteger replacementLength = [string length];
        NSUInteger rangeLength = range.length;
        
        NSUInteger newLength = oldLength - rangeLength + replacementLength;
        
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
         return newLength <= MAXLENGTH || returnKey;

    }
    else
        return YES;
   
 
}


- (IBAction)stateBtn:(id)sender {
    btntag=(UIButton*)sender;
     [self labelTapped];
}
- (IBAction)cardTypeBtn:(id)sender {
     btntag=(UIButton*)sender;
    
    
     [self labelTapped];
    
}

- (IBAction)transactionTypebtn:(id)sender {
     btntag=(UIButton*)sender;
        [self labelTapped];
    
}

//press this buttion to proceed payment
- (IBAction)processPaymentBtn:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    vPTMCObj.transactionName = [self.transactionTypebtn titleForState:UIControlStateNormal];
    vPTMCObj.state = [self.stateBtn titleForState:UIControlStateNormal];;
    vPTMCObj.country = self.countryTxtField.text;
    vPTMCObj.amountforadjust = self.testCashAdjustTxtFeild.text;
    //vPTMCObj.type = @"BankcardTransaction";
    vPTMCObj.cardType = [self.cardTypeBtn titleForState:UIControlStateNormal];
    vPTMCObj.cardholderName = self.nameTxtField.text;;
    vPTMCObj.panNumber=self.creditCardNotxtField.text;
    vPTMCObj.expiryDate = [self.monthTextField.text stringByAppendingString:self.yearTextField.text];
    vPTMCObj.isNullable = false;
    vPTMCObj.street = self.streetTxtField.text;
    vPTMCObj.city = self.cityTxtField.text;
    vPTMCObj.stateProvince = [self.stateBtn titleForState:UIControlStateNormal];
    vPTMCObj.accountType=@"NotSet";
    vPTMCObj.postalCode = self.zipTxtField.text;
    vPTMCObj.phone= self.phoneTxtField.text;
    vPTMCObj.cvDataProvided = @"Provided";
    vPTMCObj.cVData = self.cVCtxtField.text;
    vPTMCObj.amount = self.testCashTxtField.text;
    vPTMCObj.currencyCode = self.currencyCodeTxtField.text;
    vPTMCObj.customerPresent = @"Present";
    vPTMCObj.employeeId = self.customerIDtxtField.text;
    vPTMCObj.entryMode = @"Keyed";
    vPTMCObj.industryType = @"Ecommerce";
    vPTMCObj.email = self.emailTxtField.text;
    vPTMCObj.countryCode = @"USA";
    vPTMCObj.businnessName = @"MomCorp";
    vPTMCObj.CustomerId = @"11";
    vPTMCObj.comment = @"a test comment";
    vPTMCObj.discription = @"a test description";
    vPTMCObj.reportingDataReference = @"001";
    vPTMCObj.transactionDataReference = @"xyt";
    //vPTMCObj.paymentAccountDataToken = @"";
    vPTMCObj.transactionDateTime=@"2013-04-03T13:50:16";
    vPTMCObj.cashBackAmount = @"0.0";
    vPTMCObj.goodsType = @"NotSet";
    vPTMCObj.invoiceNumber = @"808";
    vPTMCObj.orderNumber = @"629203";
    vPTMCObj.FeeAmount = @"1000.05";
    vPTMCObj.tipAmount = @"12.34";
   
    self.pickerView.hidden=YES;
    [PaymentObjecthandler setModelObject:vPTMCObj];
    //
    //
    switch (switchcaseInput ) {
        case 0:
            [velocityProcessorObj createCardToken];
            break;
        case 1:
            [velocityProcessorObj authoriseWToken:YES];
            break;
        case 2:
            [velocityProcessorObj authoriseWToken:NO];
            break;
        case 3:
            [velocityProcessorObj authNCaptureWithToken:YES];
            
            break;
        case 4:
            [velocityProcessorObj authNCaptureWithToken:NO];
            break;
        case 5:
            
            break;
        case 6:
            
            break;
        case 7:
            
            break;
        case 8:
            
            break;
        case 9:
            
            break;
        case 10:
            
            break;
        case 11:
            
            break;
       
            
        default:
            break;
            
    }

}

//-(NSString *)getTime;
//{
//    NSDate* sourceDate = [NSDate date];
//    
//    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
//    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
//    
//    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
//    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
//    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
//    
//    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
//    return (NSString *)destinationDate;
//}
//

@end
