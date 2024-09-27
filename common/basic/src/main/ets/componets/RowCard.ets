@Component
export struct RowCard{
  @Prop icon:Resource=$r('app.media.errorImage')
  @Prop title:string=''
  @State endicon:Resource=$r('app.media.ic_btn_more')
  build() {
    Row(){
      Row(){
        Image(this.icon)
          .width(30)
          .height(30)
        Text(this.title)
          .margin({left:15})
      }
      Image(this.endicon)
        .width(30)
        .height(30)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(10)
    .backgroundColor(Color.White)
    .width('95%')
  }
}

@Component
export struct RowCardHaveLeftIcon{
  @Prop icon?:Resource
  @Prop title:string=''
  @Prop endtitle:string=''
  @Prop endtextColor:Color=Color.Black
  build() {
    Row(){
      Row(){
        if (this.icon){
          Image(this.icon)
            .width(30)
            .height(30)
        }
        Text(this.title)
          .margin({left:15})
      }
      Text(this.endtitle)
        .fontColor(this.endtextColor)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(10)
    .backgroundColor(Color.White)
    .width('100%')
  }
}

@Component
export struct RowCardEndIcon{
  @Prop title:string=''
  @State endicon:Resource=$r('app.media.ic_btn_more')
  build() {
    Row(){
        Text(this.title)
          .margin({left:15})
      Image(this.endicon)
        .width(30)
        .height(30)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(10)
    .backgroundColor(Color.White)
    .width('100%')
  }
}


