//
//  SigningView.h
//  SigningViewTest
//
//  Created by SunShine on 13-8-9.
//  Copyright (c) 2013年 csair. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SigningView : UIView {
    NSMutableArray* allPoints;
	NSMutableArray* allLines;
}
@property (nonatomic, retain) UIColor* fontColor;
@property (nonatomic, assign) float fontSize;

/**
 *	@brief	通知视图开始绘制新的笔画
 */
-(void)beginDrawNewLine;

/**
 *	@brief	通知视图当前笔画已经绘制完成
 */
-(void)endDrawNewLine;

/**
 *	@brief	通知视图当前正在绘制某点
 *
 *	@param 	sender 	当前绘制的点
 */
-(void)drawingPoint:(CGPoint)sender;

/**
 *	@brief	清理上一次绘制的笔画
 */
-(void)cleanLastLine;

/**
 *	@brief	清理全部笔画
 */
-(void)cleanAllLines;

/**
 *	@brief	将签名视图生成图片
 *
 *	@return	生成的图片对象
 */
-(UIImage *)imageForSigning;

@end
