//
//  VelocityCardSampleViewController.m
//  VelocityCardSample
//
//  Created by Chetu on 1/16/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "VelocityCardSampleViewController.h"
#import "VelocityConstant.h"
#import "VelocityProcessor.h"//import this header
#import "VelocityPaymentTransaction.h"//import this header
#import "BankcardTransactionResponsePro.h"//import this header
#import "ErrorPaymentResponse.h"//import this header
#import "ResponseViewViewController.h"
#import "MBProgressHUD.h"
@interface VelocityCardSampleViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,VelocityProcessorDelegate>//Velocity processor delegate

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
@property (weak,nonatomic) NSString* transactionID;
@property (weak,nonatomic) NSString* paymentDataToken;
@property (weak, nonatomic) IBOutlet UITextField *tipAmountTxtField;

- (IBAction)cardTypeBtn:(id)sender;
- (IBAction)processPaymentBtn:(id)sender;
- (IBAction)stateBtn:(id)sender;
- (IBAction)transactionTypebtn:(id)sender;
@end
@implementation VelocityCardSampleViewController
{
    NSArray *tranxTypearr;
    NSArray *cardTypearr;
    NSArray *currencyCodeArr;
    NSArray *stateArr;
    VelocityProcessor *velocityProcessorObj;//velocity processor object
    UIButton *btntag;
    UIView *chiledView;
    VelocityPaymentTransaction *vPTMCObj;//velocityProcessorTransactionModelClass Object
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
    self.scrollView.contentSize  = CGSizeMake(self.view.frame.size.width, 3000);
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
    /**
     transaction types
     */
    tranxTypearr=[[NSArray alloc]initWithObjects:@"SignOn",@"Verify",@"Authorize w/ Token",@"Authorise w/o Token",@"AuthAndCapture w/ Token",@"AuthAndCapture w/o token",@"Capture",@"Void(Undo)",@"Adjust",@"ReturnById",@"ReturnUnlinked",@"ReturnUnlinkedW/oToken", nil];
    /**
     card type
     */
    cardTypearr=[[NSArray alloc]initWithObjects:@"Visa",@"Master",@"Discover",@"American Express", nil];
    stateArr=[[NSArray alloc]initWithObjects:@"CO",@"NK", nil];
    [self.transactionTypebtn setTitle:[NSString stringWithFormat:@"%@",[tranxTypearr objectAtIndex:0]] forState:UIControlStateNormal];
    [self.stateBtn setTitle:[NSString stringWithFormat:@"%@",[stateArr objectAtIndex:0]] forState:UIControlStateNormal];
    [self.cardTypeBtn setTitle:[NSString stringWithFormat:@"%@",[cardTypearr objectAtIndex:0]] forState:UIControlStateNormal];
    toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-_pickerView.frame.size.height-42,_pickerView.frame.size.width,44)];
    /**
     Intialize the object of velocity processor class ans settting the required parameter
     
     :returns: velocity processor object
     */

    velocityProcessorObj= [[VelocityProcessor alloc] initWith:kIdentityToken forAppProfileId:kAppProfileId forMerchantProfileId:kMerchantProfileId forWorkflowId:KWorkflowId andSessionToken:nil andType:kisTestAccountBOOL ];
        velocityProcessorObj.delegate=self;
    /*!
     this will be used to hold and pass values to the library
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
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (switchcaseInput == 0) {
        
        [[[UIAlertView alloc]initWithTitle:@"Session Token" message:[successAny objectForKey:@"SessionToken"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
    else{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"bundle:nil];
    ResponseViewViewController *subView =[storyboard instantiateViewControllerWithIdentifier:@"ResponseViewViewController"];
    [self presentViewController:subView animated:YES completion:nil];
        
    }
    
    
}
//for faileur of methods call from velocity processor object
/**
 *  velocity processor delegate responsible for passing messages and informing the user that the process is failed
 *
 */
-(void)VelocityProcessorFailedWithErrorMessage:( id)failedAny{
    [[[UIAlertView alloc]initWithTitle:@"Message" message:failedAny delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
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
        switchcaseInput = (int)row;
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
/**
 *  Picker View
 */
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

#pragma mark-textfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{    [toolBar removeFromSuperview];
    [_pickerView removeFromSuperview];
    return YES;
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
    /**
     *  Velocity Payment transaction modal class objects holds value from user and forward this values to the libraray
     */
    vPTMCObj.transactionName = [self.transactionTypebtn titleForState:UIControlStateNormal];
    vPTMCObj.state = [self.stateBtn titleForState:UIControlStateNormal];;
    vPTMCObj.country = self.countryTxtField.text;
    vPTMCObj.amountforadjust = self.testCashAdjustTxtFeild.text;
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
    vPTMCObj.transactionDateTime=@"2013-04-03T13:50:16";
    vPTMCObj.cashBackAmount = @"0.0";
    vPTMCObj.goodsType = @"NotSet";
    vPTMCObj.invoiceNumber = @"808";
    vPTMCObj.orderNumber = @"629203";
    vPTMCObj.FeeAmount = @"1000.05";
    vPTMCObj.tipAmount = self.tipAmountTxtField.text;//this amount is used for capture
    vPTMCObj.keySerialNumber=@"";
    vPTMCObj.identificationInformation=@"";
    vPTMCObj.ecommerceSecurityData = @"";
    vPTMCObj.track1Data = @"";
    vPTMCObj.street2 = @"";
    vPTMCObj.fax = @"";
    vPTMCObj.customerTaxId = @"";
    vPTMCObj.shippingData = @"";
    vPTMCObj.securePaymentAccountData = @"";
    vPTMCObj.encryptionKeyId = @"";
    vPTMCObj.swipeStatus = @"";
    vPTMCObj.approvalCode = @"";
    vPTMCObj.internetTransactionData = @"";
    vPTMCObj.isPartialShipment = false;
    vPTMCObj.isSignatureCaptured = false;
    vPTMCObj.terminalID = @"";
    //vPTMCObj.batchID = @"";
    vPTMCObj.partialApprovalCapable = @"NotSet";
    vPTMCObj.scoreThreshold = @"";
    vPTMCObj.isQuasiCash=false;
    self.pickerView.hidden=YES;
    [PaymentObjecthandler setModelObject:vPTMCObj];
    switch (switchcaseInput ) {
        case 0:
            /**
             *  Calling creat card token method for signon
             */

             [velocityProcessorObj createCardTokenIsOnlySignOn:YES];
            break;
        case 1:
            /**
             *  Calling creat card token method for verify
             */
            
            [velocityProcessorObj createCardTokenIsOnlySignOn:NO];
            break;
        case 2:
            /**
             *  Calling Authwith token method
             */
            [velocityProcessorObj authoriseWToken:YES];
            break;
        case 3:
            /**
             *  calling authwithout token method
             */
            [velocityProcessorObj authoriseWToken:NO];
            break;
        case 4:
            /**
             *  calling auth and capture method with token
             */
            [velocityProcessorObj authNCaptureWithToken:YES];
            
            break;
        case 5:
            /**
             *  calling auth and capture method with out token
             */
            [velocityProcessorObj authNCaptureWithToken:NO];
            break;
        case 6:
            /**
             *  calling capture method
             */
            [velocityProcessorObj captureTransaction];
            break;
        case 7:
            /**
             *  calling void method
             */
            [velocityProcessorObj voidORundoTransaction];
            break;
        case 8:
            /**
             *  calling adjust method
             */
            [velocityProcessorObj adjustAmount];
            break;
        case 9:
            /**
             *  calling return by id method
             */
            [velocityProcessorObj returnById];
            break;
        case 10:
            /**
             *  calling returned unlinked method
             */
            [velocityProcessorObj returnUnlinkedisWithToken:YES];
            break;
        case 11:
            /**
             *  calling returned unlinked method without token
             */
            [velocityProcessorObj returnUnlinkedisWithToken:NO];
            break;

        default:
            break;
            
    }

}

@end
