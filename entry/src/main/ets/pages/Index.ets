import { IndexsBarModel,IndexView, LoginDo, UserLogin } from  '@hm/basic'
import { HomePage } from './tabspage/HomePage';
import { promptAction, router } from '@kit.ArkUI';
import { emitter } from '@kit.BasicServicesKit';
import { ShopClassPage } from './tabspage/ShopClassPage';
import { ShopCar } from './tabspage/ShopCarPage';
import { MyPage } from './tabspage/MyPage';
import preferencesUtil from '../utils/PreferencesUtil';


// PersistentStorage.persistProp('login',false)
// PersistentStorage.persistProp('User', {})
@Entry
@Component
struct Index {
  @StorageLink('login') login:boolean=false
  @StorageLink('UserInfo') userinfo:UserLogin=new UserLogin()
  @State message: string = 'Hello World';
  @State currentindex:number=0
  @State index:number=0
  private Tabscontroller:TabsController=new TabsController()
  aboutToAppear(): void {
    router.clear()
    emitter.on({eventId:1}, ()=>{
      this.Tabscontroller.changeIndex(2)
    })
    let prefenence=preferencesUtil.getValue('userinfo', '') as string
    console.info('prefenence'+prefenence)
    if (prefenence != '' && prefenence != undefined && prefenence != undefined) {
      this.userinfo=JSON.parse(prefenence)
      LoginDo(this.userinfo)
        .then((value)=>{
          if (value) {
            this.login=true
            preferencesUtil.putValue('userinfo',JSON.stringify(this.userinfo))
          }else {
            promptAction.showToast({
              message:'错误'
            })
          }
        })
    }

  }
  @Builder
  TabBuilder(tabbar:IndexsBarModel){
    Column(){
      Image(this.currentindex==tabbar.id?tabbar.selecticon:tabbar.icon)
        .width(25)
        .height(25)
      Text(tabbar.title)
    }
  }
  build() {
    Column() {
      Tabs({barPosition:BarPosition.End,controller:this.Tabscontroller}){
        TabContent(){
          HomePage()
        }
        .tabBar(this.TabBuilder(IndexView[0]))
        TabContent(){
          ShopClassPage()
        }
        .tabBar(this.TabBuilder(IndexView[1]))
        TabContent(){
          ShopCar()
        }
        .tabBar(this.TabBuilder(IndexView[2]))
        TabContent(){
          MyPage()
        }
        .tabBar(this.TabBuilder(IndexView[3]))
      }
      .onChange((value)=>{
        this.currentindex=value
      })
    }
    .height('100%')
    .width('100%')
  }
}
