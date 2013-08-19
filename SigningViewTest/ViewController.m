//
//  ViewController.m
//  SigningViewTest
//
//  Created by SunShine on 13-8-9.
//  Copyright (c) 2013年 csair. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.signingView.fontColor = [UIColor blackColor];
    self.signingView.fontSize = 1.0f;
    self.signingView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.signingView.layer.borderWidth = 1.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_signingView release];
    [super dealloc];
}
- (IBAction)saveAction:(id)sender {
    NSLog(@"click save button");
    UIImage *image = [self.signingView imageForSigning];
    NSString *imagePath = [[self getPath] stringByAppendingPathComponent:@"image1.png"];
    NSData *imageData = UIImagePNGRepresentation(image);
    //保存到本地文件
    [imageData writeToFile:imagePath atomically:YES];
    //保存到用户相册
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    NSString *msg = [NSString stringWithFormat:@"文件%@已经保存。",imagePath];
    UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] autorelease];
    [alert show];
}

-(NSString *)getPath{
    NSFileManager *theFileManager = [NSFileManager defaultManager];

    NSURL *theDocsURL = [[theFileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    return [theDocsURL path];
}

- (IBAction)dischargeAction:(id)sender {
    NSLog(@"click discharge button");
    [self.signingView cleanLastLine];
}

- (IBAction)clearAction:(id)sender {
    NSLog(@"click clear button");
    [self.signingView cleanAllLines];
}

- (IBAction)backAction:(id)sender {
    NSLog(@"click back action");
    UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@"Tips" message:@"click back!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
    [alert show];
}

#pragma mark - Touch Events
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch=[touches anyObject];
	CGPoint beganpoint=[touch locationInView:self.signingView];
    [self.signingView beginDrawNewLine];
    [self.signingView drawingPoint:beganpoint];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSArray* MovePointArray=[touches allObjects];
	CGPoint movepoint=[[MovePointArray objectAtIndex:0] locationInView:self.signingView];
    [self.signingView drawingPoint:movepoint];
    [self.signingView setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.signingView endDrawNewLine];
}
@end
