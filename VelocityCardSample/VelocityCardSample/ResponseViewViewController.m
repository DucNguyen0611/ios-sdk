//
//  ResponseViewViewController.m
//  VelocityCardSample
//
//  Created by Chetu on 30/01/15.
//  Copyright (c) 2015 NorthAmericanBancard. All rights reserved.
//

#import "ResponseViewViewController.h"
#import "ErrorPaymentResponse.h"//import this header
#import "BankcardTransactionResponsePro.h"//import this header
#import "BancardCaptureResponse.h"//import this header
#import "VelocityResponse.h"//import this header
#import "MBProgressHUD.h"
#import "VelocityPaymentTransaction.h"//import this header
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
    /**
     *  Initiallizig velocity response modal class to get values of the request transaction methods
     */
    self._txRespons_obj = [VelocityResponseObjectHandlers getModelObject];
    // Do any additional setup after loading the view.
    //for bancard tx response
    /**
     *  check whether the response is type of BancardTransactionPro class
     */
    if (__txRespons_obj!=nil && [self._txRespons_obj isKindOfClass:[BankcardTransactionResponsePro class]]&& __txRespons_obj.status!=nil ) {
        /**
         *  setting value for transaction id,and paymen account datatoken and Batch id ,this will be further used as parameter for any other reuest method
         */
        
        VelocityPaymentTransaction *obj =[PaymentObjecthandler getModelObject];
        /**
         *  transaction id
         */
        obj.transectionID=self._txRespons_obj.transactionId;
        /**
         *  Payment account data token
         */
        obj.paymentAccountDataToken = self._txRespons_obj.paymentAccountDataToken;
        /**
         *  Batch Id
         */
        obj.batchID =self._txRespons_obj.batchId;
        /**
         *  User interface for representation of values comming in bancard transaction response
         */
        self.titleLabel.text=@"Success Response";
        self.httpCodeLbl.text = [@"HTTP STATUS CODE:" stringByAppendingString:self._txRespons_obj.statusCodeHttpResponse];//self._txRespons_obj.statusCodeHttpResponse;
        self.httpStatusLbl.text =[@"STATUS:" stringByAppendingString:self._txRespons_obj.status];

        self.statusLbl.text =  [@"STATUS MESSAGE:" stringByAppendingString:self._txRespons_obj.statusMessage];        self.ststusCodeLbl.text = [@"STATUS CODE:" stringByAppendingString:self._txRespons_obj.statusCode];
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
    /**
     *  If response is error response
     *
     */
    else if (__txRespons_obj!=nil && [self._txRespons_obj isKindOfClass:[ErrorPaymentResponse class]]&&__txRespons_obj.errorId!=nil){
        /**
         *  User interface for representation of values comming in bancard transaction response
         */
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
        if (self._txRespons_obj.ruleMessage == nil) {
            self.transactionIDlbl.text = [@"RULE MESSAGE :" stringByAppendingString:@""];
        }
        else
        self.transactionIDlbl.text = [@"RULE MESSAGE :" stringByAppendingString:self._txRespons_obj.ruleMessage];
        [self.paymentAccDataTokenLbl setHidden:YES];
        [self.transactionIDlbl sizeToFit ];
        
    }
    /**
     *  check the transaction response is BancardCapture response
     *
     */
    else if (__txRespons_obj!=nil && [self._txRespons_obj isKindOfClass:[BancardCaptureResponse class]]&&__txRespons_obj.status!=nil){
        VelocityPaymentTransaction *obj =[PaymentObjecthandler getModelObject];
        /**
         *  setting value for transaction id,and paymen account datatoken and Batch id ,this will be further used as parameter for any other reuest method
         */
        /**
         *  transaction id
         */
        obj.transectionID=self._txRespons_obj.transactionId;
        /**
         *  Payment account data token
         */
        obj.paymentAccountDataToken = self._txRespons_obj.paymentAccountDataToken;
        /**
         *  Batch Id
         */
        obj.batchID =self._txRespons_obj.batchId;
        /**
         *  User interface for representation of values comming in bancard transaction response
         */
        self.titleLabel.text=@"Capture Response";
        self.httpCodeLbl.text = [@"HTTP STATUS CODE:" stringByAppendingString:self._txRespons_obj.httpCode];//self._txRespons_obj.statusCodeHttpResponse;
        self.httpStatusLbl.text = [@"HTTP STATUS MESSAGE:" stringByAppendingString:self._txRespons_obj.statusMessage];
        self.statusLbl.text = [@"STATUS MESSAGE:" stringByAppendingString:self._txRespons_obj.status];
        self.ststusCodeLbl.text = [@"STATUS CODE:" stringByAppendingString:self._txRespons_obj.statusCode];
        self.transactionStateLbl.text = [@"TRANSACTION STATE :" stringByAppendingString:self._txRespons_obj.transactionState];
        self.captureStatelbl.text = [@"CAPTURE STATE :" stringByAppendingString:self._txRespons_obj.captureState];
        self.originatorTxIDlbl.text = [@"ORIGINATOR TX ID:" stringByAppendingString:self._txRespons_obj.originatorTransactionId];
        self.transactionIDlbl.text = [@"TRANSACTTION ID:" stringByAppendingString:self._txRespons_obj.transactionId];
        self.paymentAccDataTokenLbl.text = [[@"BATCH ID:" stringByAppendingString:self._txRespons_obj.batchId]stringByAppendingString:[NSString stringWithFormat:@"\nNet Amount:%@",__txRespons_obj.netAmount]];
    }
    else
    /**
     *  When requesting parameter is missed or faulty then this part will execute
     */
    {
            [[[UIAlertView alloc]initWithTitle:@"Message" message:@"!!Error!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            [self.titleLabel setHidden:YES];
            [self.httpCodeLbl setHidden:YES];
            [self.httpStatusLbl setHidden:YES];
            [self.statusLbl setHidden:YES];
            [self.transactionStateLbl setHidden:YES];
            [self.captureStatelbl setHidden:YES];
            [self.originatorTxIDlbl setHidden:YES];
            [self.transactionIDlbl setHidden:YES];
            [self.transactionIDlbl setHidden:YES];
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  Dismiss view controller
 *
 *
 */
- (IBAction)doneBtn:(id)sender {
    
     [self dismissViewControllerAnimated:YES completion:nil]; 
}
@end
