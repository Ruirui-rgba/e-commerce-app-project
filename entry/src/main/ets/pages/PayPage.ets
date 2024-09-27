import { InTopNormal, OrderInList, PayOrder } from '@hm/basic'
import { promptAction, router } from '@kit.ArkUI'
import { emitter } from '@kit.BasicServicesKit'

class pageinfo{
  order:OrderInList=new OrderInList()
  back:number=0
}
@Entry
@Component
struct PayPage {
  @State order:OrderInList=new OrderInList()
  @State back:number=0
  @State payType:number=1
  aboutToAppear(): void {
    this.order=(router.getParams() as pageinfo).order
    this.back=(router.getParams() as pageinfo).back
  }

  @Builder
  PayMethod(icon:Resource,title:string,index:number){
    Row(){
      Row(){
        Image(icon)
          .width(40)
          .height(40)
        Text(title)
          .margin({left:10})
      }
      Toggle({
        type: ToggleType.Checkbox,
        isOn:this.payType==index?true:false
      })
        .enabled(false)
    }
    .onClick(()=>{
      this.payType=index
    })
    .width('100%')
    .padding(10)
    .justifyContent(FlexAlign.SpaceBetween)
  }
  build() {
    Column() {
      InTopNormal({
        title:'支付'
      })
      Column(){
        Text('支付金额')
        Text('￥ '+this.order.payAmount)
          .fontColor(Color.Black)
          .fontSize(30)
        Column(){

          this.PayMethod($r('app.media.errorImage'),'支付宝支付',1)
          this.PayMethod($r('app.media.errorImage'),'微信支付',2)
        }
        .margin({top:50})

        Button('确认支付')
          .type(ButtonType.Normal)
          .width('90%')
          .margin({top:20})
          .onClick(()=>{
            PayOrder(this.order.id,this.payType)
              .then((value)=>{
                promptAction.showToast({
                  message:value
                })
                if (this.back == 0) {
                  router.back()
                }else {
                  router.back({url:'pages/MyOrderPage'})
                }
                emitter.emit({eventId:4})
              })
          })
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('90%')
    }
    .height('100%')
    .width('100%')
  }
}