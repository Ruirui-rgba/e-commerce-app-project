import {
  InTopNormal,
  GetBrandList,
  brand} from  '@hm/basic'
import { router } from '@kit.ArkUI';

// 推荐品牌列表
@Entry
@Component
struct RecommendPage {
  @State message: string = 'Hello World';
  @State pageNum:number=1
  @State pageSize:number=8
  @State brandList:Array<brand>=[]
  @State cansoller:boolean=true
  aboutToAppear(): void {
    GetBrandList(this.pageNum,this.pageSize)
      .then((value)=>{
        this.brandList=value
      })
  }


  @Builder
  InGrid(item:brand){
    Column(){
      Column(){
        Image(item.logo)
          .width('80%')
          .height(40)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .height(100)
      Text(item.name)
        .fontColor($r('app.color.MainFontColor'))
        .fontSize($r('app.string.MainFontColor'))
      Text(`商品数量: ${item.productCount}`)
        .fontColor($r('app.color.GrayFontColor'))
        .fontSize($r('app.string.GrayFontColor'))
    }
    .onClick(()=>{
      router.pushUrl({
        url:'pages/BrandInfo',
        params:{
          brandId:item.id
        }
      })
    })
    .alignItems(HorizontalAlign.Start)
  }
  GetMore(){
    this.pageNum++
    GetBrandList(this.pageNum,this.pageSize)
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
        title:'推荐品牌列表'
      })
      Scroll(){
        Column(){
          Image($r('app.media.recommend_brand_banner'))
            .height(200)

          Grid(){
            ForEach(this.brandList,(item:brand)=>{
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