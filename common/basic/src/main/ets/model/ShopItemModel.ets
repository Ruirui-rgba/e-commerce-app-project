import { promptAction } from '@kit.ArkUI'
import { UserAddress } from '.'

export class sendFriend{
  icon:Resource=$r('app.media.share_qq')
  title:string='QQ好友'
  callback:()=>void=()=>{
    promptAction.showToast({
      message:'分享到'+this.title
    })
  }

  constructor(icon: Resource, title: string) {
    this.icon = icon
    this.title = title
  }

}

export const SendView:Array<sendFriend>=[
  new sendFriend($r('app.media.share_wechat'),'微信好友'),
  new sendFriend($r('app.media.share_moment'),'朋友圈'),
  new sendFriend($r('app.media.share_qq'),'QQ好友'),
  new sendFriend($r('app.media.share_qqzone'),'QQ空间')
]

export class shopinfoIndatil{
  key:string=''
  value:string=''

  constructor(key: string, value: string) {
    this.key = key
    this.value = value
  }

}

// 商品分类
export class ShopClass{
  description: string = "";
  icon: string = "";
  id: number = 0;
  keywords: string = "";
  level: number = 0;
  name: string = "";
  navStatus: number = 0;
  parentId: number = 0;
  productCount: number = 0;
  productUnit: string = "";
  showStatus: number = 0;
  sort: number = 0;
}

export class ShopTreeModel{
  id: number = 1;
  parentId: number = 0;
  name: string = "服装";
  level: number = 0;
  productCount: number = 100;
  productUnit: string = "件";
  navStatus: number = 1;
  showStatus: number = 1;
  sort: number = 1;
  keywords: string = "服装";
  children:Array<ShopClass>=[]
}

export class ShopYouhui{
  amount: number = 0;
  code: string = "";
  count: number = 0;
  enableTime: string = "2024-09-25T03:12:06.672Z";
  endTime: string = "2024-09-25T03:12:06.672Z";
  id: number = 0;
  memberLevel: number = 0;
  minPoint: number = 0;
  name: string = "";
  note: string = "";
  perLimit: number = 0;
  platform: number = 0;
  publishCount: number = 0;
  receiveCount: number = 0;
  startTime: string = "2024-09-25T03:12:06.672Z";
  type: number = 0;
  useCount: number = 0;
  useType: number = 0;
}

export class ShopCar{
  createDate: string = "2024-09-25T03:22:12.311Z";
  deleteStatus: number = 0;
  id: number = 0;
  memberId: number = 0;
  memberNickname: string = "";
  modifyDate: string = "2024-09-25T03:22:12.311Z";
  price: number = 0;
  productAttr: string = "";
  productBrand: string = "";
  productCategoryId: number = 0;
  productId: number = 0;
  productName: string = "";
  productPic: string = "";
  productSkuCode: string = "";
  productSkuId: number = 0;
  productSn: string = "";
  productSubTitle: string = "";
  quantity: number = 0;
  reduceAmount:number=0
}

export class ShopCarDel{
  ids:number=0
}

export class cearteOrder{
  cartPromotionItemList:Array<OrderProduct>=[]
  memberReceiveAddressList:Array<UserAddress>=[]
  couponHistoryDetailList:object=new Object()
  integrationConsumeSetting:CouponDetails=new CouponDetails()
  calcAmount:OrderDetails=new OrderDetails()
}

export class OrderProduct {
  id: number = 161;
  productId: number = 29;
  productSkuId: number = 106;
  memberId: number = 27;
  quantity: number = 1;
  price: number = 5499;
  productPic: string = "http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg";
  productName: string = "Apple iPhone 8 Plus 64GB 红色特别版 移动联通电信4G手机";
  productSubTitle: string = "【限时限量抢购】Apple产品年中狂欢节，好物尽享，美在智慧！速来 >> 勾选[保障服务][原厂保2年]，获得AppleCare+全方位服务计划，原厂延保售后无忧。";
  productSkuCode: string = "201808270029001";
  createDate: string = "2024-09-25T08:37:34.000+00:00";
  deleteStatus: number = 0;
  productCategoryId: number = 19;
  productBrand: string = "苹果";
  productSn: string = "7437799";
  productAttr: string = '[{"key":"颜色","value":"金色"},{"key":"容量","value":"32G"}]';
  promotionMessage: string = "单品促销";
  reduceAmount: number = 500;
  realStock: number = 107;
  integration: number = 5499;
  growth: number = 5499;
}

export class CouponDetails {
  id: number = 1;
  deductionPerAmount: number = 100;
  maxPercentPerOrder: number = 50;
  useUnit: number = 100;
  couponStatus: number = 1;
}

export class OrderDetails {
  totalAmount: number = 7598;
  freightAmount: number = 0;
  promotionAmount: number = 500;
  payAmount: number = 7098;
}

export class CreateOrderModel{
  cartIds:Array<number>=[]
  couponId:number|null=null
  memberReceiveAddressId:number=0
  payType:number=0
  useIntegration:number=0
}

export class MyOrderModel{
  orderItemList:Array<InMyOrderItem>=[]
  order:InMyOrderinfo=new InMyOrderinfo()
}

export class InMyOrderItem{
  orderId: number = 0;
  orderSn: string = "";
  productId: number = 0;
  productPic: string = "";
  productName: string = "";
  productBrand: string = "";
  productSn: string = "";
  productPrice: number = 0;
  productQuantity: number = 0;
  productSkuId: number = 0;
  productSkuCode: string = "";
  productCategoryId: number = 0;
  promotionName: string = "";
  promotionAmount: number = 0;
  couponAmount: number = 0;
  integrationAmount: number = 0;
  realAmount: number = 0;
  giftIntegration: number = 0;
  giftGrowth: number = 0;
  productAttr: string = '';
}

export class InMyOrderinfo{
  id: number = 0;
  memberId: number = 0;
  orderSn: string = "0";
  createTime: string = "";
  memberUsername: string = "0";
  totalAmount: number = 0;
  payAmount: number = 0;
  freightAmount: number = 0;
  promotionAmount: number = 0;
  integrationAmount: number = 0;
  couponAmount: number = 0;
  discountAmount: number = 0;
  payType: number = 0;
  sourceType: number = 1;
  status: number = 0;
  orderType: number = 0;
  autoConfirmDay: number = 0;
  integration: number = 0;
  growth: number = 0;
  promotionInfo: string = "";
  receiverName: string = "0";
  receiverPhone: string = "0";
  receiverPostCode: string = "0";
  receiverProvince: string = "0";
  receiverCity: string = "";
  receiverRegion: string = "";
  receiverDetailAddress: string = "0";
  confirmStatus: number = 0;
  deleteStatus: number = 0;
  useIntegration: number = 0;
}

export class OrderListModel{
  list:Array<OrderInList>=[]
  pageNum:number=0
  pageSize:number=0
  total:number=0
  totalPage:number=0
}

export class OrderDetailModel{
  couponAmount: number = 0;
  giftGrowth: number = 0;
  giftIntegration: number = 0;
  id: number = 0;
  integrationAmount: number = 0;
  orderId: number = 0;
  orderSn: string = "";
  productAttr: string = "";
  productBrand: string = "";
  productCategoryId: number = 0;
  productId: number = 0;
  productName: string = "";
  productPic: string = "";
  productPrice: number = 0;
  productQuantity: number = 0;
  productSkuCode: string = "";
  productSkuId: number = 0;
  productSn: string = "";
  promotionAmount: number = 0;
  promotionName: string = "";
  realAmount: number = 0;
}

export class OrderInList{
  autoConfirmDay: number = 0;
  billContent: string = "";
  billHeader: string = "";
  billReceiverEmail: string = "";
  billReceiverPhone: string = "";
  billType: number = 0;
  commentTime: string = "";
  confirmStatus: number = 0;
  couponAmount: number = 0;
  couponId: number = 0;
  createTime: string = "";
  deleteStatus: number = 0;
  deliveryCompany: string = "";
  deliverySn: string = "";
  deliveryTime: string = "";
  discountAmount: number = 0;
  freightAmount: number = 0;
  growth: number = 0;
  id: number = 0;
  integration: number = 0;
  integrationAmount: number = 0;
  memberId: number = 0;
  memberUsername: string = "";
  modifyTime: string = "";
  note: string = "";
  orderItemList:Array<OrderDetailModel>=[]
  orderSn: string = "";
  orderType: number = 0;
  payAmount: number = 0;
  payType: number = 0;
  paymentTime: string = "";
  promotionAmount: number = 0;
  promotionInfo: string = "";
  receiveTime: string = "";
  receiverCity: string = "";
  receiverDetailAddress: string = "";
  receiverName: string = "";
  receiverPhone: string = "";
  receiverPostCode: string = "";
  receiverProvince: string = "";
  receiverRegion: string = "";
  sourceType: number = 0;
  status: number = 0;
  totalAmount: number = 0;
  useIntegration: number = 0;
}

export class LoveBrand{
  brandCity: string = "";
  brandId: number = 0;
  brandLogo: string = "";
  brandName: string = "";
  createTime: string = "2024-09-27T01:27:39.731Z";
  id: string = "";
  memberIcon: string = "";
  memberId: number = 0;
  memberNickname: string = "";
}

export class ReadHistory{
  createTime: string = "2024-09-27T01:44:08.717Z";
  id: string = "";
  memberIcon: string = "";
  memberId: number = 0;
  memberNickname: string = "";
  productId: number = 0;
  productName: string = "";
  productPic: string = "";
  productPrice: number = 0;
  productSubTitle: string = "";
}