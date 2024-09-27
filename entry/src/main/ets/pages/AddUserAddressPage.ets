import { AddAddress, InTopNormal, UserAddress, validateChinesePhoneNumber } from '@hm/basic'
import { promptAction, router } from '@kit.ArkUI'
import { emitter } from '@kit.BasicServicesKit'

@Entry
@Component
struct AddUserAddressPage {
  @State name:string=''
  @State phonenumber:string=''
  @State Emailcode:string=''
  @State province:string=''
  @State detailAddress:string=''
  @State ison:boolean=false
  @State useraddress:UserAddress=new UserAddress()
  addAddress(){
    if (this.name != '' && this.phonenumber != '' && this.Emailcode != '' && this.province != '' &&
      this.detailAddress != '') {

      if (validateChinesePhoneNumber(this.phonenumber)) {
        this.useraddress.defaultStatus=this.ison?1:0
        this.useraddress.detailAddress=this.detailAddress
        this.useraddress.name=this.name
        this.useraddress.phoneNumber=this.phonenumber
        this.useraddress.postCode=this.Emailcode
        this.province=this.province
        AddAddress(this.useraddress)
          .then((value)=>{
            if (value == 200) {
              router.back()
              emitter.emit({eventId:3})
              emitter.emit({eventId:5})
              promptAction.showToast({
                message:'success'
              })
            }
          })

      }else {
        promptAction.showToast({
          message:'手机号码错误'
        })
      }

    }else {
      promptAction.showToast({
        message:'请检查输入格式'
      })
    }
  }
  
  build() {
    Column() {
      InTopNormal({
        title:'新增收货地址'
      })

      InpRowCard({
        title:'姓名',
        inp:this.name,
        placeholder:'请输入姓名'
      })

      InpRowCard({
        title:'手机号',
        inp:this.phonenumber,
        placeholder:'请输入手机号',
        Type:InputType.PhoneNumber
      })

      InpRowCard({
        title:'邮政编码',
        inp:this.Emailcode,
        placeholder:'请输入邮政编码'
      })

      InpRowCard({
        title:'所在区域',
        inp:this.province,
        placeholder:'请输入所在区域'
      })

      InpRowCard({
        title:'详细地址',
        inp:this.detailAddress,
        placeholder:'请输入详细地址'
      })
      Line()
        .width('100%')
        .height(5)
        .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
      Row(){
        Text('设为默认')
        Toggle({
          isOn: this.ison,
          type: ToggleType.Switch
        })
          .onChange((value)=>{
            this.ison=value
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .padding(10)
      .width('100%')

      Button('添加')
        .onClick(()=>{
          this.addAddress()
        })
        .width('90%')
        .type(ButtonType.Normal)
        .padding(10)
    }
    .height('100%')
    .width('100%')
  }
}

@Component
export struct InpRowCard{
  @Prop title:string=''
  @Link inp:string
  @Prop placeholder:string=''
  @Prop Type:InputType=InputType.Normal
  build() {
    Row(){
      Text(this.title)
        .width('20%')
      TextInput({placeholder:this.placeholder,text:this.inp})
        .onChange((value)=>{
          this.inp=value
        })
        .type(this.Type)
        .borderRadius(0)
        .width('70%')
    }
    .padding(10)
    .width('100%')
  }
}