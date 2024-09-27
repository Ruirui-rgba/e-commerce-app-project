import { brand, newProduct, Product } from '../model'
import { router } from '@kit.ArkUI'
import { GetMeybeLoveList } from '../api'

@Component
export struct  HomePinPai{
  @Prop BrandList:Array<brand>=[]

  @Builder
  InGrid(item:brand){
    Column(){
      Column(){
        Image(item.logo)
          .width('80%')
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .height(60)
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
  build() {
    Column(){
      Row(){
        Row(){
          Image($r('app.media.icon_home_brand'))
            .height(45)
            .width(45)
          Column(){
            Text('品牌制造商直供')
              .fontColor($r('app.color.MainFontColor'))
              .fontSize($r('app.string.MainFontColor'))
            Text('工厂直达消费者，剔除品牌溢价')
              .fontColor($r('app.color.GrayFontColor'))
              .fontSize($r('app.string.GrayFontColor'))
          }
          .alignItems(HorizontalAlign.Start)
        }
        Image($r('app.media.ic_btn_more'))
          .width(25)
          .height(25)
      }
      .onClick(()=>{
        router.pushUrl({
          url:'pages/RecommendPage'
        })
      })
      .width('100%')
      .padding(20)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.SpaceBetween)
      Grid(){
        ForEach(this.BrandList,(item:brand)=>{
          GridItem(){
            this.InGrid(item)
          }
        })
      }
      .padding({bottom:20})
      .backgroundColor(Color.White)
      .columnsTemplate('1fr 1fr')
      .width('100%')
    }
  }
}

@Component
export struct HomeMiaosha{

  build() {
    Column(){
      Row(){
        Row(){
          Image($r('app.media.icon_flash_promotion'))
            .height(45)
            .width(45)
          Column(){
            Text('秒杀专区')
              .fontColor($r('app.color.MainFontColor'))
              .fontSize($r('app.string.MainFontColor'))
            Text('下一场N/A开始')
              .fontColor($r('app.color.GrayFontColor'))
              .fontSize($r('app.string.GrayFontColor'))
          }
          .alignItems(HorizontalAlign.Start)
        }
        Column(){
          Text('本场结束剩余:')

        }
      }
      .width('100%')
      .padding(20)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
}


@Component
export struct  HomeNewProduct{
  @Prop newProductList:Array<newProduct>=[]

  @Builder
  InGrid(item:newProduct){
    Column(){
      Column(){
        Image(item.pic)
          .height(250)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      Text(item.name)
        .fontColor($r('app.color.MainFontColor'))
        .fontSize($r('app.string.MainFontColor'))
        .maxLines(1)
        .textOverflow({
          overflow:TextOverflow.Clip
        })
        .width(200)
      Text(`商品数量: ${item.stock}`)
        .fontColor($r('app.color.GrayFontColor'))
        .fontSize($r('app.string.GrayFontColor'))
        .maxLines(1)
        .textOverflow({
          overflow:TextOverflow.Clip
        })
      Text('￥'+item.price)
        .fontColor(Color.Red)
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
    Column(){
      Row(){
        Row(){
          Image($r('app.media.icon_new_product'))
            .height(45)
            .width(45)
          Column(){
            Text('新鲜好物')
              .fontColor($r('app.color.MainFontColor'))
              .fontSize($r('app.string.MainFontColor'))
            Text('为你寻觅世间好物')
              .fontColor($r('app.color.GrayFontColor'))
              .fontSize($r('app.string.GrayFontColor'))
          }
          .alignItems(HorizontalAlign.Start)
        }
        Image($r('app.media.ic_btn_more'))
          .width(25)
          .height(25)
      }
      .onClick(()=>{
        router.pushUrl({
          url:'pages/NewProductPage'
        })
      })
      .width('100%')
      .padding(20)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.SpaceBetween)
      List({space:5}){
        ForEach(this.newProductList,(item:newProduct)=>{
          ListItem(){
            this.InGrid(item)
          }
        })
      }
      .listDirection(Axis.Horizontal)


    }
    .backgroundColor(Color.White)
    .padding({bottom:20})
  }
}

@Component
export struct  HomeHotProduct{

  @Prop hotProductList:Array<newProduct>=[]

  @Builder
  InGrid(item:newProduct){
    Row(){
      Image(item.pic)
        .width(160)
        .constraintSize({
          maxHeight:160
        })
      Column(){
          Text(item.name)
            .fontColor($r('app.color.MainFontColor'))
            .fontSize($r('app.string.MainFontColor'))
            .maxLines(1)
            .textOverflow({
              overflow:TextOverflow.Clip
            })
            .width(200)
          Text(item.subTitle)
            .fontColor($r('app.color.GrayFontColor'))
            .fontSize($r('app.string.GrayFontColor'))
            .maxLines(3)
            .textOverflow({
              overflow:TextOverflow.Clip
            })
            .width(200)
        Text('￥'+item.price)
          .fontColor(Color.Red)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .onClick(()=>{
      router.pushUrl({
        url:'pages/ShopItemPage',
        params:{
          id:item.id
        }
      })
    })
  }
  build() {
    Column(){
      Row(){
        Row(){
          Image($r('app.media.icon_hot_product'))
            .height(45)
            .width(45)
          Column(){
            Text('人气推荐')
              .fontColor($r('app.color.MainFontColor'))
              .fontSize($r('app.string.MainFontColor'))
            Text('大家都赞不绝口的')
              .fontColor($r('app.color.GrayFontColor'))
              .fontSize($r('app.string.GrayFontColor'))
          }
          .alignItems(HorizontalAlign.Start)
        }
        Image($r('app.media.ic_btn_more'))
          .width(25)
          .height(25)
      }
      .onClick(()=>{
        router.pushUrl({
          url:'pages/HotProductPage'
        })
      })
      .width('100%')
      .padding(20)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.SpaceBetween)
      List({space:5}){
        ForEach(this.hotProductList,(item:newProduct)=>{
          ListItem(){
            this.InGrid(item)
          }
        })
      }


    }
    .backgroundColor(Color.White)
    .padding({bottom:20})
  }
}


@Component
export struct HomeLoveProduct{
  @State product:Array<Product>=[]
  @Prop  @Watch('getmore')pageNum:number=1
  @State pageSize:number=6
  @State canscroller:boolean=true
  aboutToAppear(): void {
    GetMeybeLoveList(this.pageNum,this.pageSize)
      .then((value)=>{
        this.product=value
      })
  }
  getmore(){
    if (this.canscroller){
      GetMeybeLoveList(this.pageNum,this.pageSize)
        .then((value)=>{
          if (value.length > 0) {
            this.product.push(...value)
          }else {
            this.canscroller=false
          }

        })
    }
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
    Column(){
      Row(){
        Row(){
          Image($r('app.media.icon_recommend_product'))
            .height(45)
            .width(45)
          Column(){
            Text('猜你喜欢')
              .fontColor($r('app.color.MainFontColor'))
              .fontSize($r('app.string.MainFontColor'))
            Text('你喜欢的都在这里了')
              .fontColor($r('app.color.GrayFontColor'))
              .fontSize($r('app.string.GrayFontColor'))
          }
          .alignItems(HorizontalAlign.Start)
        }
      }
      .width('100%')
      .padding(20)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Start)
      Grid(){
        ForEach(this.product,(item:Product)=>{
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
}