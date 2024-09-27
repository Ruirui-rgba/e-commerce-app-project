import { Product, sendFriend, SendView, shopinfoIndatil } from '../model'

@CustomDialog
@Component
export struct SendDiag{
  private controller:CustomDialogController
  build() {
    Column(){
      Text('分享到')
        .fontSize($r('app.string.TopFontSize'))
        .margin({top:10})
      Grid(){
        ForEach(SendView,(item:sendFriend)=>{
          GridItem(){
            Column(){
              Image(item.icon)
                .width(40)
                .height(40)
              Text(item.title)
            }
            .margin({top:20})
            .onClick(()=>{
              item.callback()
              this.controller.close()
            })
          }
        })
      }
      .margin({top:10})
      .width('100%')
      .height(300)
      .columnsTemplate('1fr 1fr 1fr')
    }
    .backgroundColor(Color.White)
  }
}

@CustomDialog
@Component
export struct ShopDiagchooseColor{
  private controller:CustomDialogController
  @Link value:string
  @Prop shop:Product=new Product()
  @Prop color:Array<string>=[]
  @Prop HaveNumber:Array<string>=[]
  @State selectindex:number=0
  @State selectindext:number=0
  @Prop selectcolor:string=''
  @Prop selectnumber:string=''
  build() {
    Column({space:10}){


      Row(){
        Image(this.shop.pic)
          .height(60)
        Column({space:5}){
          Text('￥'+this.shop.price)
          Text('库存'+this.shop.stock)
          Text('已选'+this.value)
        }
      }
      .width('95%')


      Column(){
        Text('颜色')
        Grid(){
          ForEach(this.color,(item:string,index:number)=>{
            GridItem(){
              Text(item)
                .backgroundColor(this.selectindex==index?'#fc95a1':$r('app.color.Neutral_Colors_BackgroundColor'))
                .fontColor(this.selectindex==index?Color.Red:Color.Black)
                .width(70)
                .textAlign(TextAlign.Center)
                .borderRadius(50)
            }
            .margin({left:20})
            .onClick(()=>{
              this.selectindex=index
              this.selectcolor=item
              this.value=this.selectcolor+' '+this.selectnumber
            })
          })
        }
      }
      .width('95%')





      Column(){
        Text('容量')
        Grid(){
          ForEach(this.HaveNumber,(item:string,index:number)=>{
            GridItem(){
              Text(item)
                .backgroundColor(this.selectindext==index?'#fc95a1':$r('app.color.Neutral_Colors_BackgroundColor'))
                .fontColor(this.selectindext==index?Color.Red:Color.Black)
                .width(70)
                .borderRadius(50)
                .textAlign(TextAlign.Center)
            }
            .margin({left:20})
            .onClick(()=>{
              this.selectindext=index
              this.selectnumber=item
              this.value=this.selectcolor+' '+this.selectnumber
            })
          })
        }
      }
      .width('95%')

      Button('完成')
        .backgroundColor(Color.Red)
        .width('95%')
        .onClick(()=>{
          this.controller.close()
        })
        .margin({bottom:20})


    }
    .width('100%')
    .backgroundColor(Color.White)
  }
}

@CustomDialog
@Component
export struct ShopDiagInfo{
  private controller:CustomDialogController
  @Prop shopdatil:Array<shopinfoIndatil>=[]
  @Builder
  Inrow(item:shopinfoIndatil){
    Row({space:10}){
      Text(item.key)
      Text(item.value)
    }
    .width('100%')
    .backgroundColor(Color.White)
    .padding(5)
  }
  build() {
    Column(){
      ForEach(this.shopdatil,(item:shopinfoIndatil)=>{
        this.Inrow(item)
        Line().height(1)
      })
    }
    .width('100%')
    .height(300)
    .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
  }
}


