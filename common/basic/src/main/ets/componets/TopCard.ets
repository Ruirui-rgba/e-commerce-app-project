import { router } from '@kit.ArkUI'

@Component
export struct TopHaveSearch{
  @State lefticon:Resource=$r('app.media.errorImage')
  @State righticon:Resource=$r('app.media.errorImage')
  @State searchtitle:string='请输入商品 如：手机'
  @State searchvalue:string=''
  build() {
    Stack(){
      Row(){
        Image(this.lefticon)
          .imagedo()
        Image(this.righticon)
          .imagedo()
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .padding(10)
      Search({placeholder:this.searchtitle,value:this.searchvalue})
        .onChange((value)=>{
          this.searchvalue=value
        })
        .width('80%')
    }
  }
}

@Component
export struct InTopNormal{
  @Prop icon:Resource=$r('app.media.ic_btn_nav_back')
  @Prop title:string=''
  build() {
    Stack(){
      Row(){
        Image(this.icon)
          .width(30)
          .height(30)
          .onClick(()=>{
            router.back()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .padding(15)
      Text(this.title)
        .fontSize($r('app.string.TopFontSize'))
        .fontColor($r('app.color.MainFontColor'))
    }
    .backgroundColor(Color.White)
  }
}

@Extend(Image)
function imagedo(){
  .width(20)
  .height(20)
}