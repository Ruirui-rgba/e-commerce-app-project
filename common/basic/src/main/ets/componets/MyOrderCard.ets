import { CancelUserOrder, GetShopOrderList } from '../api'
import { OrderDetailModel, OrderInList, OrderListModel } from '../model'
import { emitter } from '@kit.BasicServicesKit'
import { router } from '@kit.ArkUI'

@Component
export struct MyOrderCardAll{
  @State OrderList:Array<OrderInList>=[]
  @Prop status:number=-1
  @State pageNum:number=1
  @State pageSize:number=6
  @State canscroller:boolean=true

  aboutToAppear(): void {
    emitter.on({eventId:4},()=>{
      GetShopOrderList(this.status,this.pageNum,this.pageSize)
        .then((value)=>{
          this.OrderList=value.list
          if (this.pageNum>=value.totalPage) {
            this.canscroller=false
          }
        })
    })
     GetShopOrderList(this.status,this.pageNum,this.pageSize)
      .then((value)=>{
        this.OrderList=value.list
        if (this.pageNum>=value.totalPage) {
          this.canscroller=false
        }
      })
  }

  getmore(){
    this.pageNum++
    GetShopOrderList(this.status,this.pageNum,this.pageSize)
      .then((value)=>{
        this.OrderList.push(...value.list)
        if (this.pageNum>=value.totalPage) {
          this.canscroller=false
        }
      })
  }
  build() {
    Scroll(){
      Column(){
        ForEach(this.OrderList,(item:OrderInList)=>{
          InOrderRow({
            order: item
          })
        })
        if (!this.canscroller){
          Text('没有更多数据......')
            .margin({top:10,left:10})
        }
      }
    }
    .onScrollEdge((edge)=>{
      if (edge==Edge.Bottom&&this.canscroller) {
        this.getmore()
      }
    })
    .align(Alignment.Top)
    .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
    .width('100%')
    .height('100%')
  }
}

@Component
export struct InOrderRow{
  @Prop order:OrderInList=new OrderInList()
  @State shuliang:number=0
  @Builder
  InRowProcudt(item:OrderDetailModel){
    Row(){
      Image(item.productPic)
        .width('20%')
      Column(){
        Text(item.productName)
          .maxLines(1)
          .width('100%')
          .textOverflow({
            overflow:TextOverflow.Ellipsis
          })
        Text(item.productAttr+'; x'+item.productQuantity)
          .fontColor($r('app.color.GrayFontColor'))
          .fontSize($r('app.string.GrayFontColor'))
          .maxLines(1)
          .width('100%')
          .textOverflow({
            overflow:TextOverflow.Ellipsis
          })
        Text('￥'+item.productPrice)
      }
      .alignItems(HorizontalAlign.Start)
      .width('70%')
    }
    .padding(10)
    .width('100%')
  }

  aboutToAppear(): void {
    this.order.createTime=this.changetime( this.order.createTime)
    for (const element of this.order.orderItemList) {
      this.shuliang+=element.productQuantity
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
  build() {
    Column(){
      Row(){
        Text(this.order.createTime)
        Row(){
          Text(this.order.status==0?'待付款':
              this.order.status==1?'待发货':
              this.order.status==2?'已发货':
              this.order.status==3?'已完成':
              this.order.status==4?'已关闭':
              this.order.status==5?'无效订单':'未知'
          )
            .fontColor(Color.Red)

          if (this.order.status!=0&&this.order.status!=1){
            Text('|')
              .margin({left:10})
            Image($r('app.media.errorImage'))
              .width(15)
              .height(15)
              .margin({left:10})
          }
        }
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .padding(10)
      .onClick(()=>{
        router.pushUrl({
          url:'pages/OrderInfoPage',
          params:{
            order:this.order
          }
        })
      })
      Line().width('95%').height(1).backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))

      Column(){
        ForEach(this.order.orderItemList,(item:OrderDetailModel)=>{
          this.InRowProcudt(item)
        })
      }
      .width('100%')
      Row(){
        Text(`共${this.shuliang}件商品 实付款`)
          .fontColor($r('app.color.Neutral_Colors_BackgroundColor'))
        Text('￥'+this.order.payAmount)
          .fontColor(Color.Black)
      }
      .justifyContent(FlexAlign.End)
      .padding(10)
      .width('100%')

      if (this.order.status==0){
        Line().width('95%').height(1).backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
        Row({space:10}){
          Button('取消订单')
            .backgroundColor(Color.White)
            .fontColor(Color.Black)
            .borderWidth(1)
            .borderColor(Color.Black)
            .onClick(()=>{
              CancelUserOrder(this.order.id)
                .then(()=>{
                  emitter.emit({eventId:4})
                })
            })
          Button('立即付款')
            .onClick(()=>{
              router.pushUrl({
                url:'pages/PayPage',
                params:{
                  order:this.order,
                  back:0
                }
              })
            })
        }
        .justifyContent(FlexAlign.End)
        .padding(10)
        .width('100%')
      }
    }
    .width('100%')
    .backgroundColor(Color.White)
  }
}