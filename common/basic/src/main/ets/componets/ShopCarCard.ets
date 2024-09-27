import { ShopCarClear, ShopCardelete, ShopCarList, ShopCarUpdate } from '../api'
import { ShopCar, ShopCarDel } from '../model'
import { emitter } from '@kit.BasicServicesKit'
import { router } from '@kit.ArkUI'

@Component
export struct Shopcard{
  @State @Watch('doall')shopcar:Array<ShopCar>=[]
  @State idall:ShopCarDel=new ShopCarDel()
  @State ifselecrt:boolean=true
  @State @Watch('ClearAllAndMoney')selectID:Array<number>=[]
  @State Allmoney:number=0

  doall(){
    this.addall()
    this.ClearAllAndMoney()
  }
  ClearAllAndMoney(){
    if(this.selectID.length==this.shopcar.length){
      this.ifselecrt=true
    }else {
      this.ifselecrt=false
    }
    let c=0
    for (const element of this.selectID) {
      for (const ele of this.shopcar) {
        if (ele.id==element) {
          c+=ele.price*ele.quantity
          break
        }
      }
    }
    this.Allmoney=c
  }
  addall(){
    for (const element of this.shopcar) {
      if (!this.selectID.includes(element.id)) {
        this.selectID.push(element.id)
      }
    }
  }
  aboutToAppear(): void {

    emitter.on({eventId:2}, ()=>{
      ShopCarList()
        .then((value)=>{
          this.shopcar=value
          this.ifselecrt=true
        })
    })
    ShopCarList()
      .then((value)=>{
        this.shopcar=value
      })
  }
  // @Builder
  // Inrow(shop:ShopCar){
  //   Row(){
  //     Stack({alignContent:Alignment.TopStart}){
  //      Image(shop.productPic)
  //        .width(100)
  //       Image($r('app.media.select'))
  //         .width(20)
  //         .height(20)
  //     }
  //     Column(){
  //      Row(){
  //        Text(shop.productName)
  //          .width(240)
  //          .maxLines(1)
  //          .textOverflow({
  //            overflow:TextOverflow.Ellipsis
  //          })
  //        Image($r('app.media.icon_close'))
  //          .backgroundColor(Color.Black)
  //          .width(20)
  //          .height(20)
  //          .onClick(()=>{
  //            this.idall.ids=shop.id
  //            ShopCardelete(this.idall)
  //              .then(()=>{
  //                ShopCarList()
  //                  .then((value)=>{
  //                    this.shopcar=value
  //                  })
  //              })
  //          })
  //      }
  //
  //      Text(shop.productAttr)
  //
  //       Row(){
  //         Text('-')
  //           .textdo()
  //           .onClick(()=>{
  //             if (shop.quantity>1) {
  //               shop.quantity--
  //             }
  //           })
  //         Text(shop.quantity+'')
  //           .width(60)
  //           .height(40)
  //           .backgroundColor(Color.Gray)
  //           .fontColor(Color.Black)
  //         // TextInput({text:shop.quantity.toString()})
  //         //   .borderRadius(0)
  //         //   .width(60)
  //         //   .height(40)
  //         //   .backgroundColor(Color.Gray)
  //         //   .fontColor(Color.Black)
  //         //   .textAlign(TextAlign.Center)
  //         //   .onChange((value)=>{
  //         //     shop.quantity=Number(value)
  //         //     ShopCarUpdate(shop.id,shop.quantity)
  //         //   })
  //         Text('+')
  //           .textdo()
  //           .onClick(()=>{
  //             shop.quantity++
  //             console.info(`=====`+shop.quantity)
  //           })
  //       }
  //
  //     }
  //     .width(240)
  //   }
  //   .width('95%')
  // }
  build() {
    Column(){
      if (this.shopcar.length>0){
        Stack({alignContent:Alignment.Bottom}){
          Scroll(){
            Column(){
              ForEach(this.shopcar,(item:ShopCar)=>{
                OnShopCard({
                  shop:item,
                  selectID:this.selectID
                })
              })
            }
          }
          .align(Alignment.Top)
          .height('100%')
          Row(){
            Row(){
              Image(this.ifselecrt?$r('app.media.selected'):$r('app.media.select'))
                .onClick(()=>{
                  this.ifselecrt=!this.ifselecrt
                  if (!this.ifselecrt) {
                    this.selectID=[]
                  }else {
                    this.addall()
                  }
                })
                .width(20)
                .height(20)
              if (this.ifselecrt) {
                Text('清空')
                  .backgroundColor(Color.Gray)
                  .fontColor(Color.Black)
                  .borderRadius(50)
                  .width(50)
                  .textAlign(TextAlign.Center)
                  .onClick(()=>{
                    ShopCarClear()
                      .then(()=>{
                        this.Allmoney=0
                        this.ifselecrt=false
                        this.selectID=[]
                        ShopCarList()
                          .then((value)=>{
                            this.shopcar=value
                          })
                      })
                  })
              }
            }

            Row(){
              Text('￥'+this.Allmoney+'元')
              Button('去结算')
                .margin({left:20})
                .onClick(()=>{
                  router.pushUrl({
                    url:'pages/CreateOrderPage',
                    params:{
                      ids:this.selectID
                    }
                  })
                })
            }

          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('95%')
          .padding(10)
          .linearGradient({
            //渐变方向
            direction: GradientDirection.Right,
            //数组末尾元素占比小于1时，满足重复着色的效果
            colors: [['#dfded934', 0.0], ['#ff4ffaca', 0.5]]
          })
        }
      }else {
        Image($r('app.media.emptyCart'))
          .width(200)
        Text(`暂无商品`)
          .fontColor(Color.Red)
      }
    }
  }
}

@Extend(Text)
function textdo(){
  .width(40)
  .height(40)
  .fontColor(Color.Black)
  .backgroundColor(Color.Gray)
  .textAlign(TextAlign.Center)
}
@Component
export struct OnShopCard{
  @Prop shop:ShopCar=new ShopCar()
  @State idall:ShopCarDel=new ShopCarDel()
  @State @Watch('addInselect')ifselect:boolean=true
  @Link @Watch('ifdo')selectID:Array<number>
  ifdo(){
    let bool=false
    for (const element of this.selectID) {
      if (element==this.shop.id) {
        bool=true
        break
      }
    }
    this.ifselect=bool
  }
  addInselect(){
    if (this.ifselect) {
      this.selectID.push(this.shop.id)
    }else {
      let index=this.selectID.indexOf(this.shop.id)
      if (index > -1) {
        this.selectID.splice(index, 1)
      }
      // this.selectID.filter(number=>number!==this.shop.id)
    }
  }
  build() {
    Row(){
      Stack({alignContent:Alignment.TopStart}){
        Image(this.shop.productPic)
          .width(100)
        Image(this.ifselect?$r('app.media.selected'):$r('app.media.select'))
          .width(20)
          .height(20)
          .onClick(()=>{
            this.ifselect=!this.ifselect
          })
      }
      Column(){
        Row(){
          Text(this.shop.productName)
            .width(240)
            .maxLines(1)
            .textOverflow({
              overflow:TextOverflow.Ellipsis
            })
          Image($r('app.media.icon_close'))
            .backgroundColor(Color.Black)
            .width(20)
            .height(20)
            .onClick(()=>{
              this.idall.ids=this.shop.id
              let index=this.selectID.indexOf(this.shop.id)
              if (index > -1) {
                this.selectID.splice(index, 1)
              }
              ShopCardelete(this.idall)
                .then(()=>{
                    emitter.emit({eventId:2})
                })
            })
        }

        Text(this.shop.productAttr)

        Row(){
          Text('-')
            .textdo()
            .onClick(()=>{
              if (this.shop.quantity>1) {
                this.shop.quantity--
                ShopCarUpdate(this.shop.id,this.shop.quantity)
                  .then(()=>{
                    emitter.emit({eventId:2})
                  })
              }
            })
          Text(this.shop.quantity+'')
            .width(60)
            .height(40)
            .backgroundColor(Color.Gray)
            .fontColor(Color.Black)
            .textAlign(TextAlign.Center)
          Text('+')
            .textdo()
            .onClick(()=>{
              this.shop.quantity++
              ShopCarUpdate(this.shop.id,this.shop.quantity)
                .then(()=>{
                  emitter.emit({eventId:2})
                })
            })
        }

      }
      .width(240)
    }
    .width('95%')
  }
}