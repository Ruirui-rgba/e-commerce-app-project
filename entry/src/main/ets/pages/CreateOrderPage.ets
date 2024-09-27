import { cearteOrder,
  CreateOrderModel,
  CreateUserOrder,
  CreateUserOrderEnd,
  InTopNormal,
  MyOrderModel,
  OrderProduct,
  RowCardHaveLeftIcon,
  UserAddress, UserAddressDialog } from '@hm/basic'
import { router } from '@kit.ArkUI'
import { emitter } from '@kit.BasicServicesKit'
import { InpRowCard } from './AddUserAddressPage'

class pageinfo{
  ids:number[]=[]
}
@Entry
@Component
struct CreateOrderPage {
  @State orderList:cearteOrder=new cearteOrder()
  @State address:UserAddress=new UserAddress()
  @State Beizhu:string=''
  @State order:CreateOrderModel=new CreateOrderModel()
  @State idsdo:Array<number>=[]
  @State MyOrder:MyOrderModel=new MyOrderModel()
  dialogController:CustomDialogController=new CustomDialogController({
    builder:UserAddressDialog({
      address:this.address
    }),
    customStyle:true,
    alignment:DialogAlignment.Bottom
  })
  aboutToAppear(): void {
    emitter.on({eventId:3},()=>{
      this.dialogController.open()
    })
    let ids=(router.getParams() as pageinfo).ids
    this.idsdo=ids
    CreateUserOrder(ids)
      .then((value)=>{
        this.orderList=value
        if (this.orderList.memberReceiveAddressList.length > 0) {
          let c=0
          for (const element of this.orderList.memberReceiveAddressList) {
            if (element.defaultStatus==1)   {
              this.address=element
              c=1
              break
            }
          }
          if (c == 0) {
            this.address=this.orderList.memberReceiveAddressList[0]
          }
        }

      })
  }

  // bug 下单报错库存不足  请求参数均相同
  // 网页参数
  // {
  //   "payType": 0,
  //   "couponId": null,
  //   "cartIds": [
  //     184
  //   ],
  //   "memberReceiveAddressId": 13,
  //   "useIntegration": 0
  // }
  // ide参数
  // {
  // "cartIds":[
  // 185
  // ],
  // "couponId":null,
  // "memberReceiveAddressId":13,
  // "payType":0,
  // "useIntegration":0
  // }

  subOrder(){
    this.order.cartIds=this.idsdo
    this.order.memberReceiveAddressId=this.address.id
    console.info(`=====`+JSON.stringify(this.order))
    CreateUserOrderEnd(this.order)
      .then((value)=>{
        this.MyOrder=value
        router.back()
        emitter.emit({eventId:2})
      })
  }
  @Builder
  ShopMessage(item:OrderProduct){
    Row(){
      Image(item.productPic)
        .width(100)
      Column(){
       Text(item.productName)
         .textdo()
         .fontSize($r('app.string.TopFontSize'))
       Text(item.productAttr)
         .textdo()
         .fontColor($r('app.color.GrayFontColor'))
       Text(item.promotionMessage)
         .textdo()
         .fontColor(Color.Red)
        Row(){
          Text('￥'+item.price)
            .fontSize($r('app.string.TopFontSize'))
          Text(' x '+item.quantity)
            .fontColor($r('app.color.GrayFontColor'))
        }
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .width(240)
    }
    .width('100%')
    .backgroundColor(Color.White)
    .padding(10)
  }
  build() {
    Column() {
      InTopNormal({
        title:'创建订单'
      })
      Scroll(){
        Column(){
          Row(){
            if (this.orderList.memberReceiveAddressList.length>0){
              Column(){
                Text(this.address.name)
                Text(this.address.province)
                Text(this.address.detailAddress)
              }
              Image($r('app.media.ic_btn_more'))
                .width(25)
                .height(25)
            }else {
              Text('请添加收货地址')
              Text('点击添加')
            }
          }
          .onClick(()=>{
            this.dialogController.open()
          })
          .justifyContent(FlexAlign.SpaceBetween)
          .padding(20)
          .width('100%')

          Row(){
            Text('商品信息')
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .padding(10)
          .backgroundColor(Color.White)
          .margin({top:10})

          
          ForEach(this.orderList.cartPromotionItemList,(item:OrderProduct)=>{
            this.ShopMessage(item)
          })

          Line().height(5)
          RowCardHaveLeftIcon({
            icon:$r('app.media.errorImage'),
            title:'优惠券',
            endtitle:'选择优惠券',
            endtextColor:Color.Red
          })
          Line().height(1)
          RowCardHaveLeftIcon({
            icon:$r('app.media.errorImage'),
            title:'积分抵扣',
            endtitle:'0'
          })
          Line().height(5)
          RowCardHaveLeftIcon({
            title:'商品合计',
            endtitle:'￥'+this.orderList.calcAmount.totalAmount
          })
          Line().height(1)
          RowCardHaveLeftIcon({
            title:'运费',
            endtitle:'￥'+this.orderList.calcAmount.freightAmount
          })
          Line().height(1)
          RowCardHaveLeftIcon({
            title:'活动优惠',
            endtitle:'-￥'+this.orderList.calcAmount.promotionAmount,
            endtextColor:Color.Red
          })
          Line().height(1)
          RowCardHaveLeftIcon({
            title:'优惠券',
            endtitle:'-￥0',
            endtextColor:Color.Red
          })
          Line().height(1)
          RowCardHaveLeftIcon({
            title:'积分抵扣',
            endtitle:'-￥0',
            endtextColor:Color.Red
          })
          Line().height(1)
          InpRowCard({
            title:'备注',
            inp:this.Beizhu,
            placeholder:'请填写备注信息'
          })
            .backgroundColor(Color.White)


          
        }
      }
      .align(Alignment.Top)
      .width('100%')
      .height('85%')
      .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
      Row(){
        Row(){
          Text('实付款')
          Text('￥'+(this.orderList.calcAmount.payAmount))
            .fontColor(Color.Red)
        }
        .padding(5)
        Button('提交订单')
          .height('100%')
          .type(ButtonType.Normal)
          .onClick(()=>{
            this.subOrder()
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .height('8%')
      .width('100%')
      .backgroundColor(Color.White)
    }
    .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
    .height('100%')
    .width('100%')
  }
}

@Extend(Text)
function textdo(){
  .maxLines(1)
  .width('100%')
  .textAlign(TextAlign.Start)
  .textOverflow({
    overflow:TextOverflow.Ellipsis
  })
}