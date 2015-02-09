//
//  ResponseViewViewController.m
//  VelocityCardSample
//
//  Created by Chetu on 30/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "ResponseViewViewController.h"
#import "ErrorPaymentResponse.h"
#import "BankcardTransactionResponsePro.h"
#import "VelocityResponse.h"
#import "MBProgressHUD.h"
@interface ResponseViewViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *httpCodeLbl;
@property (weak, nonatomic) IBOutlet UILabel *httpStatusLbl;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *ststusCodeLbl;
@property (weak, nonatomic) IBOutlet UILabel *transactionStateLbl;
@property (weak, nonatomic) IBOutlet UILabel *captureStatelbl;
@property (weak, nonatomic) IBOutlet UILabel *originatorTxIDlbl;
@property (weak, nonatomic) IBOutlet UILabel *transactionIDlbl;
@property (weak, nonatomic) IBOutlet UILabel *paymentAccDataTokenLbl;
@property (strong, nonatomic) VelocityResponse *_txRespons_obj;
- (IBAction)doneBtn:(id)sender;

@end

@implementation ResponseViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self._txRespons_obj = [VelocityResponseObjectHandlers getModelObject];
    // Do any additional setup after loading the view.
    //for bancard tx response
    if (__txRespons_obj!=nil && [self._txRespons_obj isKindOfClass:[BankcardTransactionResponsePro class]] ) {
        self.titleLabel.text=@"Success Response";
        self.httpCodeLbl.text = [@"HTTP STATUS CODE:" stringByAppendingString:self._txRespons_obj.statusCodeHttpResponse];//self._txRespons_obj.statusCodeHttpResponse;
        self.httpStatusLbl.text = [@"HTTP STATUS MESSAGE:" stringByAppendingString:self._txRespons_obj.statusMessage];
        self.statusLbl.text = [@"STATUS MESSAGE:" stringByAppendingString:self._txRespons_obj.statusMessage];
        self.ststusCodeLbl.text = [@"STATUS CODE:" stringByAppendingString:self._txRespons_obj.statusCode];
        self.transactionStateLbl.text = [@"TRANSACTION STATE :" stringByAppendingString:self._txRespons_obj.transactionState];
        self.captureStatelbl.text = [@"CAPTURE STATE :" stringByAppendingString:self._txRespons_obj.captureState];
        self.originatorTxIDlbl.text = [@"ORIGINATOR TX ID:" stringByAppendingString:self._txRespons_obj.originatorTransactionId];
        self.transactionIDlbl.text = [@"TRANSACTTION ID:" stringByAppendingString:self._txRespons_obj.transactionId];
        if ([self._txRespons_obj.paymentAccountDataToken isKindOfClass:[NSDictionary class]]) {
            self.paymentAccDataTokenLbl.text = [@"PAYMENT ACCOUNT DATA TOKEN:" stringByAppendingString:@"no token"];
        }
        else
            
            self.paymentAccDataTokenLbl.text = [@"PAYMENT ACCOUNT DATA TOKEN:" stringByAppendingString:self._txRespons_obj.paymentAccountDataToken];
    }
    //for error response
    else if (__txRespons_obj!=nil && [self._txRespons_obj isKindOfClass:[ErrorPaymentResponse class]]){
        self.titleLabel.text=@"Error Response";
        self.httpCodeLbl.text = [@"HTTP STATUS CODE:" stringByAppendingString:self._txRespons_obj.statusCodeHttpResponse];//self._txRespons_obj.statusCodeHttpResponse;
        self.httpStatusLbl.text =[@"REASON:" stringByAppendingString:self._txRespons_obj.reason];
        self.statusLbl.text = [@"HTTP STATUS MESSAGE:" stringByAppendingString:self._txRespons_obj.helpUrl];
        [self.statusLbl sizeToFit ];
        [self.ststusCodeLbl setHidden:YES];
        self.transactionStateLbl.text = [@"ERROR ID:" stringByAppendingString:self._txRespons_obj.errorId];
        [self.transactionStateLbl setHidden:YES ];
        self.captureStatelbl.text = [@"ERROR ID:" stringByAppendingString:self._txRespons_obj.errorId];
        [self.captureStatelbl sizeToFit ];
        self.originatorTxIDlbl.text = [@"OPERATION :" stringByAppendingString:self._txRespons_obj.operation];
        [self.originatorTxIDlbl sizeToFit ];
        self.transactionIDlbl.text = [@"RULE MESSAGE :" stringByAppendingString:self._txRespons_obj.ruleMessage];
        [self.paymentAccDataTokenLbl setHidden:YES];
        [self.transactionIDlbl sizeToFit ];
        
    }
    else
    {
        
            [[[UIAlertView alloc]initWithTitle:@"Error" message:@"!!Error!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            [self.titleLabel setHidden:YES];
            [self.httpCodeLbl setHidden:YES];
            [self.httpStatusLbl setHidden:YES];
            [self.statusLbl setHidden:YES];
            [self.transactionStateLbl setHidden:YES];
            [self.captureStatelbl setHidden:YES];
            [self.originatorTxIDlbl setHidden:YES];
            [self.transactionIDlbl setHidden:YES];
        }
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

- (IBAction)doneBtn:(id)sender {
    
     [self dismissViewControllerAnimated:YES completion:nil]; 
}
@end
