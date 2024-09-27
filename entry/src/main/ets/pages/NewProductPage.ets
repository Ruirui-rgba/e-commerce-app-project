import { GetNewBrandIndex, InTopNormal, newProduct } from '@hm/basic';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct NewProductPage {
  @State message: string = 'Hello World';
  @State pageNum:number=1
  @State pageSize:number=8
  @State brandList:Array<newProduct>=[]
  @State cansoller:boolean=true
  aboutToAppear(): void {
    GetNewBrandIndex(this.pageNum,this.pageSize)
      .then((value)=>{
        this.brandList=value
      })
  }


  @Builder
  InGrid(item:newProduct){
    Column(){
      Column(){
        Image(item.pic)
          .height(200)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      Text(item.name)
        .fontColor($r('app.color.MainFontColor'))
        .fontSize($r('app.string.MainFontColor'))
      Text(`商品数量: ${item.stock}`)
        .fontColor($r('app.color.GrayFontColor'))
        .fontSize($r('app.string.GrayFontColor'))
    }
    .onClick(()=>{
      router.pushUrl({
        url:'pages/ShopItemPage',
        params:{
          id:item.id
        }
      })
    })
    .alignItems(HorizontalAlign.Start)
  }
  GetMore(){
    this.pageNum++
    GetNewBrandIndex(this.pageNum,this.pageSize)
      .then((value)=>{
        if (value.length > 0) {
          this.brandList.push(...value)
        }else {
          this.cansoller=false
        }

      })
  }


  build() {
    Column() {
      InTopNormal({
        title:'新鲜好物'
      })
      Scroll(){
        Column(){
          Image($r('app.media.new_product_banner'))
            .height(200)

          Grid(){
            ForEach(this.brandList,(item:newProduct)=>{
              GridItem(){
                this.InGrid(item)
              }
            })
          }
          .backgroundColor(Color.White)
          .columnsTemplate('1fr 1fr')
          .width('100%')
          if (!this.cansoller){
            Text('没有更多数据......')
              .margin({top:10,left:10})
          }
        }
      }
      .height('92%')
      .onScrollEdge((edge)=>{
        if (edge==Edge.Bottom&&this.cansoller) {
          this.GetMore()
        }
      })

    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
  }
}