import { CouponList, RowCard, ShopYouhui, UserLogin } from '@hm/basic'
import { router } from '@kit.ArkUI'

@Component
export struct MyPage{
  @StorageLink('login') login:boolean=false
  @StorageLink('UserInfo') userinfo:UserLogin=new UserLogin()
  @State useStatus:number=0
  @State UserCoupon:Array<ShopYouhui>=[]
  @State Couponquantitly:number=0
  aboutToAppear(): void {
    CouponList(this.useStatus)
      .then((value)=>{
        this.UserCoupon=value
        this.Couponquantitly=value.length
      })
  }
  build() {
    Column(){
      Stack(){
        Image($r('app.media.user_bg'))
          .width('100%')
          .height(200)
        Column(){
          Row({space:10}){
            Image($r('app.media.errorImage'))
              .width(30)
              .height(30)
            Image($r('app.media.errorImage'))
              .width(30)
              .height(30)
              .onClick(()=>{
                if (this.login) {
                  router.pushUrl({
                    url:'pages/UserSheZhiPage'
                  })
                }
                else {
                  router.pushUrl({
                    url:'pages/LoginPage'
                  })
                }
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.End)
          .padding(5)
          Row({space:10}){
            Image(this.login?$r('app.media.errorImage'):$r('app.media.missing_face'))
              .width(70)
              .height(70)
            Text(this.login?this.userinfo.username:'游客')
          }
          .width('95%')
        }
      }

      Row(){
        Column(){
          Text('暂无')
          Text('积分')
        }

        Column(){
          Text('暂无')
          Text('成长值')
        }


        Column(){
          Text(this.Couponquantitly>0?this.Couponquantitly+'':'暂无')
          Text('优惠券')
        }
        .onClick(()=>{
          if (this.login) {
            router.pushUrl({
              url:'pages/CouponListPage'
            })
          }
          else {
            router.pushUrl({
              url:'pages/LoginPage'
            })
          }
        })


      }
      .margin({top:10})
      .borderRadius(10)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding(10)
      .backgroundColor(Color.White)
      .width('95%')


      // 订单
      Row(){
        Column(){
          Image($r('app.media.errorImage'))
            .width(30)
            .height(30)
          Text('全部订单')
        }
        .onClick(()=>{
          if (this.login) {
            router.pushUrl({
              url:'pages/MyOrderPage',
              params:{
                currentIndex:0
              }
            })
          }
          else {
            router.pushUrl({
              url:'pages/LoginPage'
            })
          }
        })
        // 待付款
        Column(){
          Image($r('app.media.errorImage'))
            .width(30)
            .height(30)
          Text('待付款')
        }
        .onClick(()=>{
          if (this.login) {
            router.pushUrl({
              url:'pages/MyOrderPage',
              params:{
                currentIndex:0
              }
            })
          }else {
            router.pushUrl({
              url:'pages/LoginPage'
            })
          }
        })


        Column(){
          Image($r('app.media.errorImage'))
            .width(30)
            .height(30)
          Text('待收货')
        }
        .onClick(()=>{
          if (this.login) {
            router.pushUrl({
              url:'pages/MyOrderPage',
              params:{
                currentIndex:0
              }
            })
          }else {
            router.pushUrl({
              url:'pages/LoginPage'
            })
          }
        })


        Column(){
          Image($r('app.media.errorImage'))
            .width(30)
            .height(30)
          Text('退款/售后')
        }
      }
      .margin({top:10})
      .borderRadius(10)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding(10)
      .backgroundColor(Color.White)
      .width('95%')

      RowCard({
        icon:$r('app.media.errorImage'),
        title:'地址管理'
      })
        .onClick(()=>{
          if (this.login) {
            router.pushUrl({
              url:'pages/UserAddressPage'
            })
          }
          else {
            router.pushUrl({
              url:'pages/LoginPage'
            })
          }
        })

      RowCard({
        icon:$r('app.media.errorImage'),
        title:'我的足迹'
      })
        .onClick(()=>{
          if (this.login) {
            router.pushUrl({
              url:'pages/MyFootPage'
            })
          }
          else {
            router.pushUrl({
              url:'pages/LoginPage'
            })
          }
        })
      RowCard({
        icon:$r('app.media.errorImage'),
        title:'我的关注'
      })
        .onClick(()=>{
          if (this.login) {
            router.pushUrl({
              url:'pages/MyLoveBrandPage'
            })
          }
          else {
            router.pushUrl({
              url:'pages/LoginPage'
            })
          }
        })

      RowCard({
        icon:$r('app.media.errorImage'),
        title:'我的收藏'
      })
        .onClick(()=>{
          if (this.login) {
            router.pushUrl({
              url:'pages/MyLoveProducePage'
            })
          }
          else {
            router.pushUrl({
              url:'pages/LoginPage'
            })
          }
        })

      RowCard({
        icon:$r('app.media.errorImage'),
        title:'我的评价'
      })

      RowCard({
        icon:$r('app.media.errorImage'),
        title:'设置'
      })
        .onClick(()=>{
          if (this.login) {
            router.pushUrl({
              url:'pages/UserSheZhiPage'
            })
          }
          else {
            router.pushUrl({
              url:'pages/LoginPage'
            })
          }
        })

    }
    .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .width('100%')
    .height('100%')
  }
}