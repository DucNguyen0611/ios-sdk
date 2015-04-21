

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
#import "QueryTransectionRequestModalClass.h"//import this header
#import "VelocityPaymentTransaction.h"//import this header
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
@property BOOL isTestAccount;
@property BOOL checkbox;
- (IBAction)cardTypeBtn:(id)sender;
- (IBAction)processPaymentBtn:(id)sender;
- (IBAction)stateBtn:(id)sender;
- (IBAction)transactionTypebtn:(id)sender;

- (IBAction)buttonIsTestMode:(id)sender;
- (IBAction)buttonIsCaptureAll:(id)sender;
- (IBAction)buttonSimplemethods:(id)sender;
- (IBAction)buttonIsP2PE:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnIsCaptureAll;
@property (weak, nonatomic) IBOutlet UIButton *btnIsP2PE;
@property (weak, nonatomic) IBOutlet UIButton *buttonIsTestMode;
@property (weak, nonatomic) IBOutlet UIButton *buttonSimpleMethod;
@property int buttonPosition;
@property (weak, nonatomic) IBOutlet UIButton *buttonAppProfileID;

@property (weak, nonatomic) IBOutlet UITextView *securePaymentAccountDataTextView;
@property (weak, nonatomic) IBOutlet UITextView *encryptionKeyIDTextView;
@property (weak, nonatomic) IBOutlet UIButton *buttonWorkFlowID;
- (IBAction)buttonAppProfileIDClicked:(id)sender;
- (IBAction)ButtonWorkFlowIDClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *queryTransactionIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *queryBatchID;
@property (weak, nonatomic) IBOutlet UIButton *entryModeButton;
- (IBAction)entryModeButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *track1databutton;
- (IBAction)track1DataButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *track2DataButton;
- (IBAction)track2DataButton:(id)sender;


@end
@implementation VelocityCardSampleViewController
{
    NSArray *tranxTypearr;
    NSArray *cardTypearr;
    NSArray *currencyCodeArr;
    NSArray *stateArr;
    NSArray *workflowIDArray;
    NSArray *appProfileIDArray;
    NSArray *entryModeArray;
    NSArray *track1DataArray;
    NSArray *track2dataArray;
    VelocityProcessor *velocityProcessorObj;//velocity processor object
    UIButton *btntag;
    UIView *chiledView;
    VelocityPaymentTransaction *vPTMCObj;//velocityProcessorTransactionModelClass Object
    UIToolbar *toolBar;
    ResponseViewViewController *respViewObj;
    int switchcaseInput;
    QueryTransectionRequestModalClass *queryTransactionRequestModalObject;
    VelocityPaymentTransaction *paymentObj;
}
/*!
 *  @author sumit suman, 15-01-23 17:01:36
 *
 *  @brief  Velocity card sample app
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView.contentSize  = CGSizeMake(self.view.frame.size.width, 4100);
    self.pickerView.hidden = YES;
    self.transactionTypebtn.layer.cornerRadius = 5;
    self.transactionTypebtn.layer.masksToBounds = YES;
    self.processPaymentBtn.layer.cornerRadius = 5;
    self.processPaymentBtn.layer.borderWidth = 1.0;
    self.processPaymentBtn.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.processPaymentBtn.layer.masksToBounds = YES;
    self.stateBtn.layer.cornerRadius = 5;
    self.stateBtn.layer.masksToBounds = YES;
    self.cardTypeBtn.layer.cornerRadius = 5;
    self.cardTypeBtn.layer.masksToBounds = YES;
    self.btnIsCaptureAll.layer.cornerRadius = 5;
    self.btnIsCaptureAll.layer.masksToBounds = YES;
    self.btnIsP2PE.layer.cornerRadius = 5;
    self.btnIsP2PE.layer.masksToBounds = YES;
    self.buttonSimpleMethod.layer.cornerRadius = 5;
    self.buttonSimpleMethod.layer.masksToBounds = YES;
    self.buttonAppProfileID.layer.cornerRadius = 5;
    self.buttonAppProfileID.layer.masksToBounds = YES;
    self.buttonWorkFlowID.layer.cornerRadius = 5;
    self.buttonWorkFlowID.layer.masksToBounds = YES;
    self.securePaymentAccountDataTextView.layer.cornerRadius = 5;
    self.securePaymentAccountDataTextView.layer.masksToBounds = YES;
    self.encryptionKeyIDTextView.layer.cornerRadius = 5;
    self.encryptionKeyIDTextView.layer.masksToBounds = YES;
    self.entryModeButton.layer.cornerRadius = 5;
    self.entryModeButton.layer.masksToBounds = YES;
    self.track1databutton.layer.cornerRadius = 5;
    self.track1databutton.layer.masksToBounds = YES;
    self.track2DataButton.layer.cornerRadius = 5;
    self.track2DataButton.layer.masksToBounds = YES;
    _checkbox = kisTestAccountBOOL;
    if (_checkbox) {
        [_buttonIsTestMode setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
        _isTestAccount =YES;
        _checkbox = NO;
    }
    
    else if (!_checkbox) {
        [_buttonIsTestMode setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
        _isTestAccount =NO;
        _checkbox = YES;
    }

    /**
     workflowIDArray
     */
    workflowIDArray = [[NSArray alloc]initWithObjects:@"14644  (Normal)",@" 15464  (capturerall)",@"14560  (P2PE)", nil];
    /**
     appProfileIDArray
     */
    appProfileIDArray = [[NSArray alloc]initWithObjects:@"2317000001  (Normal)",@" A39DF00001  (capturerall)",@"BBBAAA0001  (P2PE)", nil];
    /**
     transaction types
     */
    tranxTypearr=[[NSArray alloc]initWithObjects:@"SignOn",@"Verify",@"Authorize w/ Token",@"Authorise w/o Token",@"P2PE Authorise",@"AuthAndCapture w/ Token",@"AuthAndCapture w/o token",@"P2PE AuthAndCapture ",@"Capture",@"Void(Undo)",@"Adjust",@"ReturnById",@"ReturnUnlinkedW/oToken",@"ReturnUnlinked ",@"P2PE ReturnUnlinked",@"QueryTransactionDetails",@"CaptureAll", nil];
    /**
     card type
     */
    cardTypearr = [[NSArray alloc]initWithObjects:@"Visa",@"Master",@"Discover",@"American Express", nil];
    stateArr=[[NSArray alloc]initWithObjects:@"CO",@"NK", nil];
    entryModeArray=[[NSArray alloc]initWithObjects:@"Keyed",@"TrackDataFromMSR", nil];
    track1DataArray=[[NSArray alloc]initWithObjects:@"Null",@"%B4012000033330026^NAJEER/SHAIK ^0904101100001100000000123456780?", nil];
    track2dataArray=[[NSArray alloc]initWithObjects:@"Null",@"4012000033330026=09041011000012345678", nil];
    [self.transactionTypebtn setTitle:[NSString stringWithFormat:@"%@",[tranxTypearr objectAtIndex:0]] forState:UIControlStateNormal];
    
    [self.stateBtn setTitle:[NSString stringWithFormat:@"%@",[stateArr objectAtIndex:0]] forState:UIControlStateNormal];
    
    [self.cardTypeBtn setTitle:[NSString stringWithFormat:@"%@",[cardTypearr objectAtIndex:0]] forState:UIControlStateNormal];
    [self.buttonWorkFlowID setTitle:[NSString stringWithFormat:@"%@",[workflowIDArray objectAtIndex:0]] forState:UIControlStateNormal];
    [self.buttonAppProfileID setTitle:[NSString stringWithFormat:@"%@",[appProfileIDArray objectAtIndex:0]] forState:UIControlStateNormal];
    [self.entryModeButton setTitle:[NSString stringWithFormat:@"%@",[entryModeArray objectAtIndex:0]] forState:UIControlStateNormal];
    [self.track1databutton setTitle:[NSString stringWithFormat:@"%@",[track1DataArray objectAtIndex:0]] forState:UIControlStateNormal];
    [self.track2DataButton setTitle:[NSString stringWithFormat:@"%@",[track2dataArray objectAtIndex:0]] forState:UIControlStateNormal];
    toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-_pickerView.frame.size.height-42,_pickerView.frame.size.width,44)];
   
    vPTMCObj = [PaymentObjecthandler getModelObject];
    
    /**
     Intialize the object of velocity processor class ans settting the required parameter
     
     :returns: velocity processor object
     */
    
  
    
    velocityProcessorObj = [[VelocityProcessor alloc] initWith:kIdentityToken forAppProfileId:kAppProfileId forMerchantProfileId:kMerchantProfileId forWorkflowId:KWorkflowId andSessionToken:nil andType:kisTestAccountBOOL ];
    _buttonPosition = 2;
    
    velocityProcessorObj.delegate=self;
    /*!
     this will be used to hold and pass values to the library
     velocity payment transaction modal calss
     velocity transactionmodalclass object
    */
    
    respViewObj = [[ResponseViewViewController alloc]init];
    queryTransactionRequestModalObject = [QueryTransectionRequestObjecthandler getModelObject];
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
    ResponseViewViewController *subView = [storyboard instantiateViewControllerWithIdentifier:@"ResponseViewViewController"];
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
    barButtonDone.tintColor = [UIColor whiteColor];
    [self.view addSubview:toolBar];
    [self.view addSubview:self.pickerView];
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerView.hidden = NO;
        _pickerView.frame = CGRectMake(_pickerView.frame.origin.x,
                                       self.view.frame.size.height-160,                                        _pickerView.frame.size.width,
                                       _pickerView.frame.size.height);
    }];
    [_pickerView reloadAllComponents];
    [_pickerView selectRow:0 inComponent:0 animated:YES];
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
    else if(btntag .tag == 3000)
        return [appProfileIDArray count];
    else if (btntag.tag == 4000)
        return [workflowIDArray count];
    else if (btntag.tag == 5000)
        return [entryModeArray count];
    else if (btntag.tag == 6000)
        return [track1DataArray count];
    else if (btntag.tag == 7000)
        return [track2dataArray count];
    else
        return [cardTypearr count];
   }

#pragma mark- Picker View Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
 

    if (btntag.tag==2000){
       [self.transactionTypebtn setTitle:[NSString stringWithFormat:@"%@",[tranxTypearr objectAtIndex:row]] forState:UIControlStateNormal];
    vPTMCObj.transactionName = [NSString stringWithFormat:@"%@",[tranxTypearr objectAtIndex:row]];
        switchcaseInput = (int)row;
    }
    else if (btntag.tag==1000)
        [self.stateBtn setTitle:[NSString stringWithFormat:@"%@",[stateArr objectAtIndex:row]] forState:UIControlStateNormal];
    else if (btntag.tag==3000)
        [self.buttonAppProfileID setTitle:[NSString stringWithFormat:@"%@",[appProfileIDArray objectAtIndex:row]] forState:UIControlStateNormal];

        
    else if (btntag.tag==4000)
        [self.buttonWorkFlowID setTitle:[NSString stringWithFormat:@"%@",[workflowIDArray objectAtIndex:row]] forState:UIControlStateNormal];
    
    else if (btntag.tag==5000)
        [self.entryModeButton setTitle:[NSString stringWithFormat:@"%@",[entryModeArray objectAtIndex:row]] forState:UIControlStateNormal];
    else if (btntag.tag==6000)
        [self.track1databutton setTitle:[NSString stringWithFormat:@"%@",[track1DataArray objectAtIndex:row]] forState:UIControlStateNormal];
    else if (btntag.tag==7000)
        [self.track2DataButton setTitle:[NSString stringWithFormat:@"%@",[track2dataArray objectAtIndex:row]] forState:UIControlStateNormal];
    else
        [self.cardTypeBtn setTitle:[NSString stringWithFormat:@"%@",[cardTypearr objectAtIndex:row]] forState:UIControlStateNormal];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    if (btntag.tag==2000)
     return [tranxTypearr objectAtIndex:row];
    else if (btntag.tag==1000)
     return [stateArr objectAtIndex:row];
    else if (btntag.tag==3000)
        return [appProfileIDArray objectAtIndex:row];
    else if (btntag.tag==4000)
        return [workflowIDArray objectAtIndex:row];
    else if (btntag.tag==5000)
        return [entryModeArray objectAtIndex:row];
    else if (btntag.tag==6000)
        return [track1DataArray objectAtIndex:row];
    else if (btntag.tag==7000)
        return [track2dataArray objectAtIndex:row];
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
    else if (btntag.tag==3000){
        attString = [[NSAttributedString alloc] initWithString:[appProfileIDArray objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return attString;
    }

    else if (btntag.tag==4000){
        attString = [[NSAttributedString alloc] initWithString:[workflowIDArray objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return attString;
    }
    
    else if (btntag.tag==5000){
        attString = [[NSAttributedString alloc] initWithString:[entryModeArray objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return attString;
    }
    else if (btntag.tag==6000){
        attString = [[NSAttributedString alloc] initWithString:[track1DataArray objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return attString;
    }
    else if (btntag.tag==7000){
        attString = [[NSAttributedString alloc] initWithString:[track2dataArray objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
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
    self.pickerView.hidden = YES;
    self.scrollView.hidden = NO;
        [self.pickerView removeFromSuperview];
        [[self view] endEditing:YES];
    [super touchesBegan:touches withEvent:event];
    }
     [toolBar removeFromSuperview];
}
#pragma textview delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
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
- (IBAction)buttonAppProfileIDClicked:(id)sender {
    btntag=(UIButton*)sender;
    [self labelTapped];
}

- (IBAction)ButtonWorkFlowIDClicked:(id)sender {
    btntag=(UIButton*)sender;
    [self labelTapped];
}
- (IBAction)buttonIsTestMode:(id)sender {
    if (_checkbox) {
        [_buttonIsTestMode setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
        _isTestAccount =YES;
        _checkbox = NO;
    }
    else if (!_checkbox) {
        [_buttonIsTestMode setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
        _isTestAccount =NO;
        _checkbox = YES;
    }
    
}

- (IBAction)buttonIsCaptureAll:(id)sender {
    _buttonPosition = 0 ;
    ///ForCapture all the values are changed////comment this part if not used
    
     velocityProcessorObj = [[VelocityProcessor alloc] initWith:kIdentityTokenCaptureAll forAppProfileId:kAppProfileIdCaptureAll forMerchantProfileId:kMerchantProfileIdCaptureAll forWorkflowId:KWorkflowIdCaptureAll andSessionToken:nil andType:kisTestAccountBOOL ];
    vPTMCObj.securePaymentAccountData = @"";
    vPTMCObj.encryptionKeyId = @"";
    vPTMCObj.swipeStatus = @"";
    velocityProcessorObj.delegate=self;
    [self selectMethodType:0];
    
}

- (IBAction)buttonSimplemethods:(id)sender {
    _buttonPosition = 2;
    velocityProcessorObj = [[VelocityProcessor alloc] initWith:kIdentityToken forAppProfileId:kAppProfileId forMerchantProfileId:kMerchantProfileId forWorkflowId:KWorkflowId andSessionToken:nil andType:kisTestAccountBOOL ];
    vPTMCObj.securePaymentAccountData = @"";
    vPTMCObj.encryptionKeyId = @"";
    vPTMCObj.swipeStatus = @"";
    velocityProcessorObj.delegate=self;
      [self selectMethodType:2];
}

- (IBAction)buttonIsP2PE:(id)sender {
    _buttonPosition = 1;
    ///ForDUKT Cardswaper  the values are changed////comment this part if not used
        velocityProcessorObj = [[VelocityProcessor alloc] initWith:kIdentityToken forAppProfileId:kAppProfileIdDUKT forMerchantProfileId:kMerchantProfileId forWorkflowId:KWorkflowIdDUKT andSessionToken:nil andType:kisTestAccountBOOL ];
        vPTMCObj.securePaymentAccountData = _securePaymentAccountDataTextView.text;
         vPTMCObj.encryptionKeyId = _encryptionKeyIDTextView.text;
        vPTMCObj.swipeStatus = @"";
    velocityProcessorObj.delegate=self;
 vPTMCObj.paymentAccountDataToken = nil;
    [self selectMethodType:1];
    
}
-(void)selectMethodType:(NSInteger)switchCase
{
    switch (switchCase ) {
        case 0:
            [_btnIsCaptureAll setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
            [_btnIsP2PE setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
            [_buttonSimpleMethod setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];

            break;
        case 1:
            [_btnIsCaptureAll setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
            [_btnIsP2PE setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
            [_buttonSimpleMethod setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
            break;
        case 2:
            [_btnIsCaptureAll setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
            [_btnIsP2PE setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
            [_buttonSimpleMethod setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];            break;
            
        default:
            [_btnIsCaptureAll setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
            [_btnIsP2PE setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
            [_buttonSimpleMethod setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
            break;
    }
    
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
    vPTMCObj.entryMode = [self.entryModeButton titleForState:UIControlStateNormal];
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
    vPTMCObj.tipAmount = self.tipAmountTxtField.text;//this amount is
    vPTMCObj.isPartialShipment = false;
    vPTMCObj.isSignatureCaptured = false;
    vPTMCObj.partialApprovalCapable = @"NotSet";
    vPTMCObj.isQuasiCash = false;
    vPTMCObj.track1Data = [self.track1databutton titleForState:UIControlStateNormal];
    vPTMCObj.track2Data = [self.track2DataButton titleForState:UIControlStateNormal];
    self.pickerView.hidden = YES;
    [PaymentObjecthandler setModelObject:vPTMCObj];
    switch (switchcaseInput ) {
        case 0:
            /**
             *  Calling  signon
             */

             [velocityProcessorObj signON];
            break;
        case 1:
            /**
             *  Calling creat card token method for verify
             */
             [velocityProcessorObj createCardToken];
            break;
        case 2:
            /**
             *  Calling Authwith token method
             */
            [velocityProcessorObj authorise];
            break;
        case 3:
            /**
             *  calling authwithout token method
             */
            vPTMCObj.paymentAccountDataToken = nil;
            [velocityProcessorObj authorise];
            break;
        case 4:
            /**
             *  calling authP2PE token method
             */
            vPTMCObj.paymentAccountDataToken = nil;
            [velocityProcessorObj authorise];
            break;
        case 5:
            /**
             *  calling auth and capture method with token
             */
            [velocityProcessorObj authorizeAndCapture];
            
            break;
        case 6:
            /**
             *  calling auth and capture method with out token
             */
            vPTMCObj.paymentAccountDataToken = nil;
            [velocityProcessorObj authorizeAndCapture];
            break;
        case 7:
            /**
             *  calling auth and capture P2PE method 
             */
            vPTMCObj.paymentAccountDataToken = nil;
            [velocityProcessorObj authorizeAndCapture];
            break;
        case 8:
            /**
             *  calling capture method
             */
            [velocityProcessorObj capture];
            break;
        case 9:
            /**
             *  calling void method
             */
            [velocityProcessorObj undo];
            break;
        case 10:
            /**
             *  calling adjust method
             */
            [velocityProcessorObj adjust];
            break;
        case 11:
            /**
             *  calling return by id method
             */
            [velocityProcessorObj returnById];
            break;
        case 12:
            /**
             *  calling returned unlinked method
             */
            [velocityProcessorObj returnUnlinked];
            break;
        case 13:
            /**
             *  calling returned unlinked method without token
             */
            vPTMCObj.paymentAccountDataToken = nil;
            [velocityProcessorObj returnUnlinked];
            break;
        case 14:
            /**
             *  calling returned unlinked P@2PE method
             */
            vPTMCObj.paymentAccountDataToken = nil;
            [velocityProcessorObj returnUnlinked];
            break;
        case 15:
            /**
             *  calling Query transaction details method
             */
            queryTransactionRequestModalObject.page = @"0";
            queryTransactionRequestModalObject.pageSize = @"10";
            queryTransactionRequestModalObject.transactionStartDateTime = @"";
            queryTransactionRequestModalObject.transactionEndDateTime = @"";
            queryTransactionRequestModalObject.includeRelated = @"true";
            queryTransactionRequestModalObject.isAcknowledged = @"NotSet";
            queryTransactionRequestModalObject.transactionIds = @[_queryTransactionIDTextField.text];
            queryTransactionRequestModalObject.batchIds = @[
                                                            _queryBatchID.text
                                                            ];
            
//            queryTransactionRequestModalObject.transactionIds = @[
//                                                                  @"8D90B6F54CAC440B9B67727437EE27CD",
//                                                                  @"8DC205563381413EA81DE1290B1872D1",
//                                                                  @"3A94BA5FB07E4549893881699D75ABEF"
//                                                                  ];
            
            //            queryTransactionRequestModalObject.captureEndDateTime = @"";
            //            queryTransactionRequestModalObject.captureStartDateTime = @"";
            //            queryTransactionRequestModalObject.transactionClass = @"";
            //            queryTransactionRequestModalObject.transactionType = @"";
            //            queryTransactionRequestModalObject.amountArray = @[
            //                                                               @"12.34"
            //                                                               ];
            //
            //            queryTransactionRequestModalObject.approvalCodes = @[
            //                                                                 @"VI1000"
            //                                                                 ];
//                        queryTransactionRequestModalObject.batchIds = @[
//                                                                        @"0539"
//                                                                        ];
            //            queryTransactionRequestModalObject.merchantProfileIds = @[
            //                                                                      @""
            //                                                                      ];
            //            queryTransactionRequestModalObject.orderNumbers = @[
            //                                                                @""
            //                                                                ];
            //
            //            queryTransactionRequestModalObject.serviceIds = @[
            //                                                              @"2317000001"
            //                                                              ];
            //
            //            queryTransactionRequestModalObject.serviceKeys= @[
            //                                                              @"FF3BB6DC58300001"
            //                                                              ];
            
            [velocityProcessorObj queryTransactionsDetail];
            
            break;
        case 16:
            /**
             *  calling Capture All method
             */
           
            
            [velocityProcessorObj captureAll];
            break;

        default:
            break;
            
    }

}


- (IBAction)entryModeButton:(id)sender {
    btntag=(UIButton*)sender;
    [self labelTapped];
}
- (IBAction)track1DataButton:(id)sender {
    btntag=(UIButton*)sender;
    [self labelTapped];
}
- (IBAction)track2DataButton:(id)sender {
    btntag=(UIButton*)sender;
    [self labelTapped];
}
@end
