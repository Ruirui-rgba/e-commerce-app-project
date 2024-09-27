import { DelAddress, ShowAddressList } from '../api'
import { UserAddress } from '../model'
import { router } from '@kit.ArkUI'
import { emitter } from '@kit.BasicServicesKit'

@CustomDialog
@Component
export struct UserAddressDialog{
  private controller:CustomDialogController
  @State useraddresss:Array<UserAddress>=[]
  @Link address:UserAddress
  aboutToAppear(): void {
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
            this.controller.close()
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
    .onClick(()=>{
      this.address=item
      this.controller.close()
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(10)
    .width('100%')
  }
  build() {
    Column(){
      Scroll(){
        Column(){
          ForEach(this.useraddresss,(item:UserAddress)=>{
            this.Inrow(item)
          })
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
          this.controller.close()
        })
    }
    .height('70%')
    .backgroundColor(Color.White)
    .width('100%')
  }
}