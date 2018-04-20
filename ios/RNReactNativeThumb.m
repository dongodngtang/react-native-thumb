
#import "RNReactNativeThumb.h"
#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>


@implementation RNReactNativeThumb

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()


RCT_EXPORT_METHOD(getVideoCover:(NSString *)videoPath cover:(RCTResponseSenderBlock)callback){
  callback(@[[self thumbnailImageForVideo:[NSString stringWithFormat:@"file://%@",videoPath] atTime:1]]);
}


-(NSString *) thumbnailImageForVideo:(NSString *)videoPath atTime:(NSTimeInterval)time {

  AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoPath] options:nil];
  NSParameterAssert(asset);
  AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
  assetImageGenerator.appliesPreferredTrackTransform = YES;
  assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;

  CGImageRef thumbnailImageRef = NULL;
  CFTimeInterval thumbnailImageTime = time;
  NSError *thumbnailImageGenerationError = nil;
  thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];

  if(!thumbnailImageRef)
    NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);

  UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;

  NSData *data=UIImageJPEGRepresentation(thumbnailImage, 1.0);
  if (data.length>300*1024) {
    if (data.length>1024*1024) {//1M以及以上
      data=UIImageJPEGRepresentation(thumbnailImage, 0.1);
    }else if (data.length>512*1024) {//0.5M-1M
      data=UIImageJPEGRepresentation(thumbnailImage, 0.5);
    }else if (data.length>300*1024) {//0.25M-0.5M
      data=UIImageJPEGRepresentation(thumbnailImage, 0.9);
    }
  }

  NSArray * stringArray = [videoPath componentsSeparatedByString:@"/"];
  NSString * fileName = [stringArray.lastObject componentsSeparatedByString:@"."].firstObject;


  ///保存图片到本地
  NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
  NSString *filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:
                        [NSString stringWithFormat:@"%@.png",fileName]];  // 保存文件的名称

  BOOL result = [data writeToFile:filePath atomically:YES]; // 保存成功会返回YES
  if (result == YES) {
    return filePath;
  }
  return @"";
}

@end
  