import { CancelUserOrder, InTopNormal, OrderDetailModel, OrderInList, RowCardHaveLeftIcon } from '@hm/basic';
import { router } from '@kit.ArkUI';
import { emitter } from '@kit.BasicServicesKit';

class pageinfo{
  order:OrderInList=new OrderInList()
}
@Entry
@Component
struct OrderInfoPage {
  @State order:OrderInList=new OrderInList()
  aboutToAppear(): void {
    this.order=(router.getParams() as pageinfo).order
    this.order.createTime=this.changetime( this.order.createTime)
    if (this.order.status == 2 || this.order.status == 3 || this.order.status == 1) {
      this.order.paymentTime=this.changetime(this.order.paymentTime)
    }
  }

  changetime(time:string):string{
    // 给定的 ISO 格式日期时间字符串
    const isoDateTime = time

    // 创建一个新的 Date 对象
    const date = new Date(isoDateTime);

    // 转换为中国时区（UTC+8）
    const chinaTimeZoneOffset = 8 * 60; // 中国时区偏移量，单位为分钟
    const chinaDate = new Date(date.getTime() + chinaTimeZoneOffset * 1000);

    // 格式化日期时间为 "yyyy-mm-dd hh:mm:ss" 格式
    const year = chinaDate.getFullYear();
    const month = (chinaDate.getMonth() + 1).toString().padStart(2, '0');
    const day = chinaDate.getDate().toString().padStart(2, '0');
    const hours = chinaDate.getHours().toString().padStart(2, '0');
    const minutes = chinaDate.getMinutes().toString().padStart(2, '0');
    const seconds = chinaDate.getSeconds().toString().padStart(2, '0');

    const formattedDateTime = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;

    return formattedDateTime
  }

  @Builder
  ShopMessage(item:OrderDetailModel){
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
        Text(item.promotionName)
          .textdo()
          .fontColor(Color.Red)
        Row(){
          Text('￥'+item.productPrice)
            .fontSize($r('app.string.TopFontSize'))
          Text(' x '+item.productQuantity)
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
        title:'订单详情'
      })
      Scroll(){
        Column(){
          Row(){
            Text(this.order.status==0?'待付款':
              this.order.status==1?'待发货':
                this.order.status==2?'已发货':
                  this.order.status==3?'已完成':
                    this.order.status==4?'已关闭':
                      this.order.status==5?'无效订单':'未知'
            )
              .fontColor(Color.White)
          }
          .padding(10)
          .backgroundColor(Color.Pink)
          .justifyContent(FlexAlign.Start)
          .width('100%')
          .height(100)



          Row(){
            Column(){
              Text(this.order.receiverName+'   '+this.order.receiverPhone)
              Text(this.order.receiverProvince)
              Text(this.order.receiverDetailAddress)
            }
          }
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

          ForEach(this.order.orderItemList,(item:OrderDetailModel)=>{
            this.ShopMessage(item)
          })

          Line().height(5)
          RowCardHaveLeftIcon({
            title:'商品合计',
            endtitle:'￥'+this.order.totalAmount
          })
          Line().height(1)
          RowCardHaveLeftIcon({
            title:'运费',
            endtitle:'￥'+this.order.freightAmount
          })
          Line().height(1)
          RowCardHaveLeftIcon({
            title:'活动优惠',
            endtitle:'-￥'+this.order.promotionAmount,
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
          Row(){
            Text('备注')
              .margin({left:15})
          }
          .justifyContent(FlexAlign.Start)
          .padding(10)
          .width('100%')
          .backgroundColor(Color.White)

          Line().height(5)
          RowCardHaveLeftIcon({
            title:'订单编号',
            endtitle:this.order.orderSn
          })
          Line().height(1)
          RowCardHaveLeftIcon({
            title:'提交时间',
            endtitle:this.order.createTime
          })
          Line().height(1)
          RowCardHaveLeftIcon({
            title:'支付方式',
            endtitle:this.order.payType==0?'未支付':
                      this.order.payType==1?'支付宝支付':
                        this.order.payType==2?'微信支付':'未知'
          })
          if (this.order.status==2||this.order.status==3||this.order.status==1){
            Line().height(1)
            RowCardHaveLeftIcon({
              title:'实付金额',
              endtitle:this.order.payAmount+''
            })
            Line().height(1)
            RowCardHaveLeftIcon({
              title:'付款时间',
              endtitle:this.order.paymentTime+''
            })
          }
          Row(){
            Row(){
              Text('应付金额')
              Text('￥'+this.order.payAmount)
                .fontColor(Color.Red)
            }
            Row(){
              Button('取消订单')
                .backgroundColor(Color.White)
                .fontColor(Color.Black)
                .borderWidth(1)
                .borderColor(Color.Black)
                .onClick(()=>{
                  CancelUserOrder(this.order.id)
                    .then(()=>{
                      router.back()
                      emitter.emit({eventId:4})
                    })
                })
              Button('立即付款')
                .onClick(()=>{
                  router.pushUrl({
                    url:'pages/PayPage',
                    params:{
                      order:this.order,
                      back:1
                    }
                  })
                })
            }
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          .backgroundColor(Color.White)

        }

      }
      .width('100%')
      .height('90%')

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