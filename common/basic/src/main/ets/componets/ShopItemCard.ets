import { ShopDiagchooseColor } from '.'
import { Product, ProductAttribute, productAttributeValue } from '../model'

@Component
export struct ShopItemInfoCard{
  @Prop lefttitle:string=''
  @Link value?:string
  @Prop titlevalue:string
  @Prop icon?:Resource
  build() {
    Row(){
      Row({space:10}){
        Text(this.lefttitle)
        Text(this.value)
      }
      if (this.icon){
        Image(this.icon)
          .height(35)
          .width(35)
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .backgroundColor(Color.White)
    .padding(10)
  }
}


@Component
export struct ShopItemInfoCardNovalue{
  @Prop lefttitle:string=''
  @Prop titlevalue:string
  @Prop icon?:Resource
  build() {
    Row(){
      Row({space:10}){
        Text(this.lefttitle)
        Text(this.titlevalue)
      }
      if (this.icon){
        Image(this.icon)
          .height(35)
          .width(35)
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .backgroundColor(Color.White)
    .padding(10)
  }
}

@Component
export struct PingJia{
  build() {
    Column(){
      Row(){
        Text('评价 '+86)
        Row({space:5}){
          Text('好评率 '+' 100%')
          Image($r('app.media.ic_btn_more'))
            .width(25)
            .height(25)
        }
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .padding(5)
    }
    .width('100%')
    .backgroundColor(Color.White)
  }
}
// @Component
// export struct ShopItemInfos{
//   @Prop product:Product=new Product()
//   @Prop color:Array<string>=[]
//   @Prop HaveNumber:string[]=[]
//   @Prop selectcolor:string=''
//   @Prop selectnumber:string=''
//   @Link value:string
//   dialogController:CustomDialogController=new CustomDialogController({
//     builder:ShopDiagchooseColor({
//       value:this.value,
//       shop:this.product,
//       color:this.color,
//       HaveNumber:this.HaveNumber,
//       selectcolor: this.selectcolor,
//       selectnumber:this.selectnumber
//     }),
//     customStyle:true,
//     alignment:DialogAlignment.Bottom
//   })
//   build() {
//     Column(){
//
//         ShopItemInfoCard({
//           lefttitle:'购买类型',
//           value:this.value,
//           icon:$r('app.media.ic_btn_more'),
//         })
//
//
//       Line().height(1)
//       ShopItemInfoCard({
//         lefttitle:'商品参数',
//         value:'查看',
//         icon:$r('app.media.ic_btn_more')
//       })
//       Line().height(1)
//       ShopItemInfoCard({
//         lefttitle:'优惠券',
//         value:'领取优惠券',
//         icon:$r('app.media.ic_btn_more')
//       })
//     }
//   }
// }