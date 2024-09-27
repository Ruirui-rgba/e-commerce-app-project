export class IndexsBarModel{
  id:number=0
  icon:Resource=$r('app.media.errorImage')
  selecticon:Resource=$r('app.media.errorImage')
  title:string=''

  constructor(id:number,icon: Resource, selecticon: Resource, title: string) {
    this.id=id
    this.icon = icon
    this.selecticon = selecticon
    this.title = title
  }



}

export const IndexView:Array<IndexsBarModel>=[
  new IndexsBarModel(0,$r("app.media.tab_home"),$r("app.media.tab_home_current"),'首页'),
  new IndexsBarModel(1,$r("app.media.tab_cate"),$r("app.media.tab_cate_current"),'分类'),
  new IndexsBarModel(2,$r("app.media.tab_cart"),$r("app.media.tab_cart_current"),'购物车'),
  new IndexsBarModel(3,$r("app.media.tab_my"),$r("app.media.tab_my_current"),'我的')
]

export const ScrollerImg:Array<Resource>=[
  $r('app.media.banner1'),
  $r('app.media.banner2'),
  $r('app.media.banner3'),
  $r('app.media.banner4')
]

export class IndexModer{
  advertiseList:Array<BannerModel>=[new BannerModel()]
  brandList:Array<brand>=[]
  homeFlashPromotion:homeFlash=new homeFlash()
  newProductList:Array<newProduct>=[]
  hotProductList:Array<newProduct>=[]
  subjectList:Array<Subject>=[]
}

export class BannerModel{
  id:number=0
  name:string=''
  type:number=0
  pic:string='http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/xiaomi_banner_01.png'
  startTime:string=''
  endTime:string=''
  status:number=0
  clickCount:number=0
  orderCount:number=0
  url:string=''
  sort:number=0
}

export class brand{
  id:number=0
  name:string=''
  firstLetter:string=''
  sort:number=0
  factoryStatus:number=0
  showStatus:number=0
  productCount:number=0
  productCommentCount:number=0
  logo:string=''
  bigPic:string=''
  brandStory:string=''
}

export class homeFlash{
  endTime:string=''
  nextEndTime:string=''
  nextStartTime:string=''
  productList:Array<Product>=[]
  startTime:string=''
}

export class Product{
  albumPics: string = "";
  brandId: number = 0;
  brandName: string = "";
  deleteStatus: number = 0;
  description: string = "";
  detailDesc: string = "";
  detailHtml: string = "";
  detailMobileHtml: string = "";
  detailTitle: string = "";
  feightTemplateId: number = 0;
  flashPromotionCount: number = 0;
  flashPromotionLimit: number = 0;
  flashPromotionPrice: number = 0;
  giftGrowth: number = 0;
  giftPoint: number = 0;
  id: number = 0;
  keywords: string = "";
  lowStock: number = 0;
  name: string = "";
  newStatus: number = 0;
  note: string = "";
  originalPrice: number = 0;
  pic: string = "";
  previewStatus: number = 0;
  price: number = 0;
  productAttributeCategoryId: number = 0;
  productCategoryId: number = 0;
  productCategoryName: string = "";
  productSn: string = "";
  promotionEndTime: string = '';
  promotionPerLimit: number = 0;
  promotionPrice: number = 0;
  promotionStartTime: string = '';
  promotionType: number = 0;
  publishStatus: number = 0;
  recommandStatus: number = 0;
  sale: number = 0;
  serviceIds: string = "";
  sort: number = 0;
  stock: number = 0;
  subTitle: string = "";
  unit: string = "";
  usePointLimit: number = 0;
  verifyStatus: number = 0;
  weight: number = 0;
}

export class newProduct{
  id: number = 0;
  brandId: number = 0;
  productCategoryId: number = 0;
  feightTemplateId: number = 0;
  productAttributeCategoryId: number = 0;
  name: string = ''
  pic: string = ''
  productSn: string = ''
  deleteStatus: number = 0;
  publishStatus: number = 0;
  newStatus: number = 0;
  recommandStatus: number = 0;
  verifyStatus: number = 0;
  sort: number = 0;
  sale: number = 0;
  price: number = 0;
  giftGrowth: number = 0;
  giftPoint: number = 0;
  usePointLimit: number = 0;
  subTitle: string = ''
  originalPrice: number = 2999
  stock: number = 500
  lowStock: number = 0
  unit: string = ''
  weight: number = 0
  previewStatus: number = 0
  serviceIds: string = ''
  keywords: string = ''
  note: string =''
  albumPics: string =''
  detailTitle: string = ''
  promotionPerLimit: number = 0
  promotionType: number = 0
  brandName: string = ''
  productCategoryName: string =''
  description: string = ''
}

export class Subject{
  albumPics: string = "";
  categoryId: number = 0;
  categoryName: string = "";
  collectCount: number = 0;
  commentCount: number = 0;
  content: string = "";
  createTime: string = "";
  description: string = "";
  forwardCount: number = 0;
  id: number = 0;
  pic: string = "";
  productCount: number = 0;
  readCount: number = 0;
  recommendStatus: number = 0;
  showStatus: number = 0;
  title: string = "";
}

export class IndexgridModel{
  icon:Resource=$r('app.media.errorImage')
  title:string=''
  method:()=>void=()=>{}

  constructor(icon: Resource, title: string, method: () => void) {
    this.icon = icon
    this.title = title
    this.method = method
  }

}

export const IndexgridView:Array<IndexgridModel>=[
  new IndexgridModel($r('app.media.c3'),'专题',()=>{}),
  new IndexgridModel($r('app.media.c5'),'话题',()=>{}),
  new IndexgridModel($r('app.media.c6'),'优选',()=>{}),
  new IndexgridModel($r('app.media.c7'),'特惠',()=>{})
]

export class ProductBrand{
  list:Array<Product>=[]
  pageNum:number=0
  pageSize:number=0
  total:number=0
  totalPage:number=0
}

export class ShopItem{
  brand:brand=new brand()
  couponList:Array<Coupon>=[]
  product:Product=new Product()
  productAttributeList:Array<ProductAttribute>=[]
  productAttributeValueList:Array<productAttributeValue>=[]
  productFullReductionList:Array<productFullReduction>=[]
  productLadderList:Array<productLadder>=[]
  skuStockList:Array<skuStock>=[]
}

export class Coupon{
  amount: number = 0;
  code: string = "";
  count: number = 0;
  enableTime: string = "2024-09-23T09:43:38.626Z";
  endTime: string = "2024-09-23T09:43:38.626Z";
  id: number = 0;
  memberLevel: number = 0;
  minPoint: number = 0;
  name: string = "";
  note: string = "";
  perLimit: number = 0;
  platform: number = 0;
  publishCount: number = 0;
  receiveCount: number = 0;
  startTime: string = "2024-09-23T09:43:38.626Z";
  type: number = 0;
  useCount: number = 0;
  useType: number = 0;
}
export class ProductAttribute{
  filterType: number = 0;
  handAddStatus: number = 0;
  id: number = 0;
  inputList: string = "";
  inputType: number = 0;
  name: string = "";
  productAttributeCategoryId: number = 0;
  relatedStatus: number = 0;
  searchType: number = 0;
  selectType: number = 0;
  sort: number = 0;
  type: number = 0;
}
export class productAttributeValue{
  id: number = 0;
  productAttributeId: number = 0;
  productId: number = 0;
  value:string=''
}
export class productFullReduction{
  fullPrice: number = 0;
  id: number = 0;
  productId: number = 0;
  reducePrice: number = 0;
}
export class productLadder{
  count: number = 0;
  discount: number = 0;
  id: number = 0;
  price: number = 0;
  productId: number = 0;
}
export class skuStock{
  id: number = 0;
  lockStock: number = 0;
  lowStock: number = 0;
  pic: string = "";
  price: number = 0;
  productId: number = 0;
  promotionPrice: number = 0;
  sale: number = 0;
  skuCode: string = "";
  spData: string = "";
  stock: number = 0;
}