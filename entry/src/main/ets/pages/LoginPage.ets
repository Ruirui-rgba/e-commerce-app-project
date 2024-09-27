import { InTopNormal, LoginDo, UserLogin } from '@hm/basic';
import { text } from '@kit.ArkGraphics2D';
import { promptAction, router } from '@kit.ArkUI';
import preferencesUtil from '../utils/PreferencesUtil';

@Entry
@Component
struct LoginPage {
  @StorageLink('login') login:boolean=false
  @StorageLink('UserInfo') userinfo:UserLogin=new UserLogin()
  @State account:string=''
  @State passwrod:string=''
  @State user:UserLogin=new UserLogin()
  aboutToAppear(): void {
    router.clear()
  }
  build() {
    Column() {
      InTopNormal()
      Column({space:30}){
        Text('欢迎回来!')
          .fontSize($r('app.string.TopFontSize'))
        Column(){
          Text('用户名')
            .textdo()
          TextInput({placeholder:'请输入用户名',text:this.account})
            .textinp()
            .onChange((value)=>{
              this.account=value
            })
        }
        Column(){
          Text('密码')
            .textdo()
          TextInput({placeholder:'8-18位不含特殊字符的数字，字母组合',text:this.passwrod})
            .textinp()
            .onChange((value)=>{
              this.passwrod=value
            })
            .type(InputType.Password)
        }
        Button('登陆')
          .width('95%')
          .onClick(()=>{
            this.user.username=this.account
            this.user.password=this.passwrod
            LoginDo(this.user)
              .then((value)=>{
                if (value) {
                  this.login=true
                  this.userinfo=this.user
                  preferencesUtil.putValue('userinfo',JSON.stringify(this.userinfo))
                  router.pushUrl({
                    url:'pages/Index'
                  })
                }else {
                  promptAction.showToast({
                    message:'错误'
                  })
                }
              })
          })
        Button('去注册')
          .width('95%')
          .onClick(()=>{
            router.pushUrl({
              url:'pages/RegisterPage'
            })
          })
      }
      .height('100%')
      .margin({top:150})
    }
    .height('100%')
    .width('100%')
  }
}

@Extend(TextInput)
function textinp(){
  .width('95%')
  .height(50)
  .borderRadius({
    topLeft:0,
    topRight:0,
    bottomLeft:20,
    bottomRight:20
  })
  .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
}

@Extend(Text)
function textdo(){
  .width('95%')
  .textAlign(TextAlign.Start)
  .padding(5)
  .borderRadius({
    topLeft:20,
    topRight:20,
  })
  .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
}