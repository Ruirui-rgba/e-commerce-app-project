import {
  AddAttentionBrand,
  brand,
  DelBrandLove,
  GetBrandDetail, GetBrandProduct,
  GetMyAttentionBrand,
  InTopNormal,
  LoveBrand,
  Product, ProductBrand } from '@hm/basic';
import { router } from '@kit.ArkUI';

class myclass{
  brandId:number=0
}
@Entry
@Component
struct BrandInfo {
  @StorageLink('login') login:boolean=false
  @State message: string = 'Hello World';
  @State Brand:brand=new brand()
  @State pageNum:number=1
  @State pageSize:number=8
  @State BrandProduct:ProductBrand=new ProductBrand()
  @State BrandList:Array<Product>=[]
  @State canscroller:boolean=true
  @State brandid:number=0
  @State iflove:boolean=false
  @State BrandAddLove:LoveBrand=new LoveBrand()
  @State iflovecanclick:boolean=true
  @State brandiflovedo:LoveBrand=new LoveBrand()
  aboutToAppear(): void {
    let brandid=(router.getParams() as myclass).brandId
    this.brandid=brandid
    GetBrandDetail(brandid)
      .then((value)=>{
        this.Brand=value
      })
    GetMyAttentionBrand(brandid)
      .then((value)=>{
        this.brandiflovedo=value
        if (this.brandiflovedo.brandId!=0) {
          this.iflove=true
        }
      })
    GetBrandProduct(brandid,this.pageNum,this.pageSize)
      .then((value)=>{
        if (this.BrandProduct.pageNum >= this.BrandProduct.totalPage) {
            this.canscroller=false
        }
        this.BrandList=value.list

      })
  }
  GetMore(){
    GetBrandProduct(this.brandid,this.pageNum,this.pageSize)
      .then((value)=>{
        if (this.BrandProduct.pageNum >= this.BrandProduct.totalPage) {
          this.canscroller=false
        }
        this.BrandList.push(...(value.list))

      })
  }
  @Builder
  Ingrid(item:Product){
    Column(){
      Image(item.pic)
        .width('80%')
      Text(item.name)
        .fontSize($r('app.string.MainFontColor'))
        .fontColor($r('app.color.MainFontColor'))
        .maxLines(1)
        .textOverflow({
          overflow:TextOverflow.Clip
        })
      Text(item.subTitle)
        .fontSize($r('app.string.GrayFontColor'))
        .fontColor($r('app.color.GrayFontColor'))
        .maxLines(1)
        .textOverflow({
          overflow:TextOverflow.Clip
        })
      Row(){
        Text(`￥${item.price}`)
          .fontSize($r('app.string.GrayFontColor'))
          .fontColor(Color.Red)
        Text(item.sale>100?'已售100+':`已售`+item.sale)
          .fontSize($r('app.string.GrayFontColor'))
          .fontColor($r('app.color.GrayFontColor'))
      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)
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
  build() {
    Column() {
      InTopNormal({
        title:'品牌详情'
      })
      Scroll(){
        Column(){
          Image(this.Brand.bigPic)
            .height(200)
          Line()
            .height(5)
          Row(){
            Image(this.Brand.logo)
              .width('40%')
            Column(){
              Text(this.Brand.name)
              Text('品牌首字母'+this.Brand.firstLetter)
            }
            .margin({left:10})
            .width('40%')
            .alignItems(HorizontalAlign.Start)
            // 待做  喜欢
            Image(this.iflove?$r('app.media.tab_home_current'):$r('app.media.tab_home'))
              .height(40)
              .width(40)
              .onClick(()=>{
                if (this.login&&this.iflovecanclick) {
                  this.iflovecanclick=false
                  if (this.iflove) {
                    DelBrandLove(this.brandid)
                      .then((value)=>{
                        value==200?this.iflove=false:this.iflove=true
                        this.iflovecanclick=true
                      })
                  }else {
                    this.BrandAddLove.brandId=this.brandid
                    this.BrandAddLove.brandLogo=this.Brand.logo
                    this.BrandAddLove.brandName=this.Brand.name
                    AddAttentionBrand(this.BrandAddLove)
                      .then(()=>{
                        this.iflove=true
                        this.iflovecanclick=true
                      })
                  }
                }
              })
          }
          .width('100%')
          .backgroundColor(Color.White)
          .padding(10)
          Line()
            .height(5)
          Row(){
            Column(){
              Text('品牌故事')
              Text(this.Brand.brandStory)
                .width('90%')
                .margin({top:20})
            }
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .backgroundColor(Color.White)
          .width('100%')
          .padding(10)
          Line()
            .height(5)

        //   相关商品
          Grid(){
            ForEach(this.BrandList,(item:Product)=>{
              GridItem(){
                this.Ingrid(item)
              }
            })
          }
          .backgroundColor(Color.White)
          .columnsTemplate('1fr 1fr')
          .width('100%')
          if (!this.canscroller){
            Text('没有更多数据......')
              .margin({top:10,left:10})
          }
        }
      }
      .onScrollEdge((edge)=>{
        if (edge==Edge.Bottom&&this.canscroller) {
          this.GetMore()
        }
      })
      .align(Alignment.Top)
      .height('92%')
    }
    .backgroundColor($r('app.color.Neutral_Colors_BackgroundColor'))
    .height('100%')
    .width('100%')
  }
}