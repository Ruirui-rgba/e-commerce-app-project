import { CouponList, InTopNormal, ShopYouhui } from '@hm/basic'

@Entry
@Component
struct CouponListPage {
  @State @Watch('changescroller')currentIndex:number=0
  private tabcontroller:TabsController=new TabsController()
  changescroller(){
    this.tabcontroller.changeIndex(this.currentIndex)
  }
  @Builder
  TabsContentD0(title:string,index:number){
    Row(){
      Text(title)
        .fontColor(this.currentIndex==index?Color.Red:Color.Black)
    }
    .border({
      width:{
        bottom:1
      },
      color:this.currentIndex==index?Color.Red:Color.White
    })
    .onClick(()=>{
      this.currentIndex=index
    })
    .padding(10)
  }
  build() {
    Column() {
      InTopNormal({
        title:'优惠券列表'
      })
      Tabs(){
        TabContent(){
          CouponInList({
            useStatus:0
          })
        }
        .tabBar(this.TabsContentD0('未使用',0))

        TabContent(){
          CouponInList({
            useStatus:1
          })
        }
        .tabBar(this.TabsContentD0('已使用',1))


        TabContent(){
          CouponInList({
            useStatus:2
          })
        }
        .tabBar(this.TabsContentD0('已过期',2))
      }
      .width('100%')
      .height('90%')
      .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))

    }
    .height('100%')
    .width('100%')
  }
}

@Component
export struct CouponInList{
  @State useStatus:number=0
  @State UserCoupon:Array<ShopYouhui>=[]
  aboutToAppear(): void {
    CouponList(this.useStatus)
      .then((value)=>{
        this.UserCoupon=value
      })
  }
  build() {
    if (this.UserCoupon.length>0){
      Scroll(){
        Column(){
          ForEach(this.UserCoupon,(item:ShopYouhui)=>{
            Text(JSON.stringify(item))
          })
        }
      }
      .width('100%')
      .height('100%')
    }else {
      Text('暂无优惠券')
    }

  }
}