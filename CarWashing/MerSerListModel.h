//
//  MerSerListModel.h
//  CarWashing
//
//  Created by apple on 2017/9/11.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MerComList.h"
@interface MerSerListModel : JSONModel
@property(nonatomic,strong)NSString<Optional> *CurrentPrice,*OriginalPrice,*SerComment,*SerName;
@property(nonatomic,assign)int MerCode,SerCode;
@end
@interface MerchantModel : JSONModel
@property(nonatomic,strong)NSString<Optional> *Area,*City,*Img,*MerAddress,*MerFlag,*MerName,*MerPhone,*ServiceTime,*StoreProfile,*MerCode;
@property(nonatomic,assign)CGFloat Distance,Score,Xm,Ym;//距离
@property(nonatomic,assign)int Iscert,ServiceCount,ShopType,IsCollection;
@property(nonatomic,strong)NSArray <MerComList *> *MerComList;
@property(nonatomic,strong)NSArray <MerSerListModel *> *MerSerList;
@end

