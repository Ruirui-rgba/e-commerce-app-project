import { GetShopClass, ShopClass } from '@hm/basic'
import { router } from '@kit.ArkUI'

@Component
export struct ShopClassPage{
  @State shopClass:Array<ShopClass>=[]
  @State shops:Array<ShopClass>=[]
  @State @Watch('changeview')chooseindex:number=0
  @State ids:number=0
  async aboutToAppear(): Promise<void> {
    await GetShopClass(0)
      .then((value)=>{
        this.shopClass=value
      })
    // this.shopClass[0].id
    await GetShopClass(this.shopClass[0].id)
      .then((value)=>{
        this.shops=value
      })
  }

  changeview(){
    GetShopClass(this.ids)
      .then((value)=>{
        this.shops=value
      })
  }

  @Builder
  Title(title:string,index:number,idparent:number){
    Row(){
      Text(title)
        .width('100%')
        .textAlign(TextAlign.Center)
        .border({
          width:{
            left:4
          },
          color:this.chooseindex==index?Color.Red:Color.White
        })
    }
    .onClick(()=>{
      this.ids=idparent
      this.chooseindex=index
    })
    .height(40)

  }
  @Builder
  ShopsView(item:ShopClass){
    Column(){
      Image(item.icon)
        .width(100)
        .height(100)
      Text(item.name)
    }
    .onClick(()=>{
      router.pushUrl({
        url:'pages/ShopListPage',
        params:{
          id:item.id
        }
      })
    })
  }

  build() {
    Row({space:5}){
      Column(){
        ForEach(this.shopClass,(item:ShopClass,index:number)=>{
          this.Title(item.name,index,item.id)
          Line().height(1)
        })
      }
      .width('26%')
      .height('100%')
      .backgroundColor(Color.White)
      Column(){
        Grid(){
          ForEach(this.shops,(item:ShopClass)=>{
            GridItem(){
              this.ShopsView(item)
            }
          })
        }
        .backgroundColor(Color.White)
        .padding({bottom:20})
        .backgroundColor(Color.White)
        .columnsTemplate('1fr 1fr 1fr')
        .width('100%')
      }
      .width('70%')
      .backgroundColor(Color.Black)
    }
    .alignItems(VerticalAlign.Top)
    .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
  }
}