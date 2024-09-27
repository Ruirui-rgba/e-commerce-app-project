import { GetYanzheng, InTopNormal, RegisterDo, UserRegister, validateChinesePhoneNumber } from '@hm/basic'
import { promptAction, router } from '@kit.ArkUI'

@Entry
@Component
struct RegisterPage {
  @State account:string=''
  @State passwrod:string=''
  @State yanzheng:string=''
  @State phonenumber:string=''
  @State time:number=60
  @State ifcando:boolean=true
  @State userregister:UserRegister=new UserRegister()
  getYanZheng(){
    GetYanzheng(this.phonenumber)
      .then((value)=>{
        this.yanzheng=value
      })
    let timeyan=setInterval(()=>{
      this.ifcando=false
      this.time--
      if (this.time == 0) {
        clearInterval(timeyan)
        this.time=60
        this.ifcando=true
      }
    },1000)
  }

  Register(){
    if (this.account != '' && this.passwrod != '' && this.yanzheng != '' && this.phonenumber != '') {
      this.userregister.username=this.account
      this.userregister.telephone=this.phonenumber
      this.userregister.password=this.passwrod
      this.userregister.authCode=this.yanzheng
      RegisterDo(this.userregister)
        .then((value)=>{
          if (value) {
              router.back()
          }else {
            promptAction.showToast({
              message:'验证码错误'
            })
          }
        })
    }else {
      promptAction.showToast({
        message:'请检查输入格式'
      })
    }
  }
  build() {
    Column() {
      InTopNormal()
      Column({space:10}){
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
          Text('手机号')
            .textdo()
          TextInput({placeholder:'请输入手机号',text:this.phonenumber})
            .textinp()
            .onChange((value)=>{
              this.phonenumber=value
            })
        }
        Column(){
          Text('密码')
            .textdo()
          TextInput({placeholder:'8-18位不含特殊字符的数字，字母组合',text:this.passwrod})
            .textinp()
            .type(InputType.Password)
            .onChange((value)=>{
              this.passwrod=value
            })
        }
        Column(){
          Text('验证码')
            .textdo()
          Stack({alignContent:Alignment.End}){
            TextInput({placeholder:'请输入验证码',text:this.yanzheng})
              .textinp()
              .onChange((value)=>{
                this.yanzheng=value
              })
            Text(this.ifcando?'获取验证码':this.time+'s后重新获取')
              .margin({right:10})
              .onClick(()=>{
                if (this.ifcando) {
                  let iftrue=validateChinesePhoneNumber(this.phonenumber)
                  if (iftrue) {
                    this.getYanZheng()
                  }else {
                    promptAction.showToast({
                      message:'手机号格式错误，请检查'
                    })
                  }
                }
              })
          }
        }
        Button('注册')
          .width('95%')
          .onClick(()=>{
            this.Register()
          })
        Button('去登陆')
          .width('95%')
          .onClick(()=>{
            router.back()
          })
      }
      .height('100%')
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