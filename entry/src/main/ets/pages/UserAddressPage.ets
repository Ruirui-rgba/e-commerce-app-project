import { DelAddress, InTopNormal, ShowAddressList, UserAddress } from '@hm/basic'
import { router } from '@kit.ArkUI'
import { emitter } from '@kit.BasicServicesKit'

@Entry
@Component
struct UserAddressPage {
  @State useraddresss:Array<UserAddress>=[]
  aboutToAppear(): void {
    emitter.on({eventId:5},()=>{
      this.getvalue()
    })
    this.getvalue()
  }
  getvalue(){
    ShowAddressList()
      .then((value)=>{
        this.useraddresss=value
      })
  }
  @Builder
  Inrow(item:UserAddress){
    Row(){
      Column(){
        Row(){
          if (item.defaultStatus==1){
            Text('默认')
              .fontColor(Color.Red)
              .border({
                color:Color.Red,
                width:2
              })
          }
          Text(item.province+' '+item.detailAddress)
        }
        Text(item.name+' '+item.phoneNumber)
      }
      Row(){
        // 修改地址
        Image($r('app.media.errorImage'))
          .width(25)
          .height(25)
          .onClick(()=>{
            router.pushUrl({
              url:'pages/UpdateUserAddressPage',
              params:{
                address:item
              }
            })
          })

        // 删除地址
        Image($r('app.media.errorImage'))
          .width(25)
          .height(25)
          .margin({left:20})
          .onClick(()=>{
            DelAddress(item.id)
              .then((value)=>{
                if (value == 200) {
                  this.getvalue()
                }
              })
          })
      }
      .padding(10)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(10)
    .width('100%')
  }
  build() {
    Column(){
      InTopNormal({
        title:'地址管理'
      })
      Scroll(){
        Column(){
          if (this.useraddresss.length>0){
            ForEach(this.useraddresss,(item:UserAddress)=>{
              this.Inrow(item)
            })
          }else {
            Text('暂无收货地址')
          }
        }
      }
      .align(Alignment.Top)
      .width('100%')
      .height('80%')
      Button('新增地址')
        .width('80%')
        .height('10%')
        .margin({bottom:10})
        .type(ButtonType.Normal)
        .onClick(()=>{
          router.pushUrl({
            url:'pages/AddUserAddressPage'
          })
        })
    }
    .height('100%')
    .backgroundColor(Color.White)
    .width('100%')
  }
}