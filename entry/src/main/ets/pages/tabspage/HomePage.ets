import {
  TopHaveSearch,
  GetMessageIndex,
  IndexModer,
  BannerModel,
  IndexgridView,
  IndexgridModel,
  HomePinPai,
  HomeMiaosha,
  HomeNewProduct,
  HomeHotProduct,
  HomeLoveProduct} from  '@hm/basic'
import { effectKit } from '@kit.ArkGraphics2D';

@Component
export struct HomePage{
  @State infomessage:IndexModer=new IndexModer()
  @State pageNum:number=1
  private swiperController:SwiperController=new SwiperController()
  @State ColorInSwiper:string=''
  aboutToAppear(): void {
      GetMessageIndex()
      .then((value)=>{
        this.infomessage=value
      })
  }
  @Builder
  SwiperView(){
    Text()
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Yellow)
    Swiper(this.swiperController){
      ForEach(this.infomessage.advertiseList,(item:BannerModel,index:number)=>{
        Image(item.pic)
      })
    }
    .autoPlay(true)
  }
  @Builder
  downSwiper(){
    Grid(){
      ForEach(IndexgridView,(item:IndexgridModel)=>{
        GridItem(){
          this.InGrid(item)
        }
      })
    }
    .margin({top:10})
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .width('100%')
    .backgroundColor(Color.White)
  }
  @Builder
  InGrid(item:IndexgridModel){
    Column(){
      Image(item.icon)
        .width(55)
        .height(55)
      Text(item.title)
    }
  }


  build() {
    Stack({alignContent:Alignment.Top}){
      Scroll(){
        Column(){
          Stack(){
            this.SwiperView()
          }
          .backgroundColor(Color.Yellow)
          .width('100%')
          .height(200)
          this.downSwiper()
          Line()
            .height(10)
          HomePinPai({
            BrandList:this.infomessage.brandList
          })
          Line()
            .height(10)
          HomeMiaosha()
          Line()
            .height(10)
          HomeNewProduct({
            newProductList:this.infomessage.newProductList
          })
          Line()
            .height(10)
          HomeHotProduct({
            hotProductList:this.infomessage.hotProductList
          })
          Line()
            .height(10)
          HomeLoveProduct({
            pageNum:this.pageNum
          })
        }
      }
      .onScrollEdge((edge)=>{
        if (edge==Edge.Bottom) {
          this.pageNum++
        }
      })
      TopHaveSearch()
    }
    .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
    .height('100%')
  }
}