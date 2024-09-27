import { axiosInstance, InTopNormal, RowCardEndIcon, UserLogin } from '@hm/basic'
import { router } from '@kit.ArkUI'
import preferencesUtil from '../utils/PreferencesUtil'

@Entry
@Component
struct UserSheZhiPage {
  @StorageLink('login') login:boolean=false
  @StorageLink('UserInfo') userinfo:UserLogin=new UserLogin()
  @State pushmessage:boolean=false
  aboutToAppear(): void {
    this.pushmessage=preferencesUtil.getValue('pushmessage',false) as boolean
  }
  build() {
    Column() {
      InTopNormal({
        title:'设置'
      })
      Line().height(5)
      RowCardEndIcon({
        title:'个人资料'
      })
      Line().height(1)
      RowCardEndIcon({
        title:'收货地址'
      })
        .onClick(()=>{
          router.pushUrl({
            url:'pages/UserAddressPage'
          })
        })
      Line().height(1)
      RowCardEndIcon({
        title:'实名认证'
      })
      Line().height(5)
      Row(){
        Text('消息推送')
          .margin({left:15})
        Toggle({
          type: ToggleType.Switch,
          isOn:this.pushmessage
        })
          .onChange((value)=>{
            preferencesUtil.putValue('pushmessage',value)
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .padding(10)
      .backgroundColor(Color.White)
      Line().height(5)
      RowCardEndIcon({
        title:'清除缓存'
      })
      Line().height(1)
      RowCardEndIcon({
        title:'检查更新'
      })
      Line().height(5)
      Button('退出登录')
        .backgroundColor(Color.White)
        .fontColor(Color.Red)
        .type(ButtonType.Normal)
        .width('95%')
        .onClick(()=>{
          router.pushUrl({
            url:'pages/LoginPage'
          })
          this.login=false
          this.userinfo=new UserLogin()
          preferencesUtil.putValue('userinfo', '')
          axiosInstance.defaults.headers.common['Authorization'] =''
        })
    }
    .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
    .height('100%')
    .width('100%')
  }
}

