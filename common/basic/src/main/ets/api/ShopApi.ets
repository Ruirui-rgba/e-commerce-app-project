import { AxiosError, AxiosResponse } from '@ohos/axios'
import { axiosInstance, Message } from '../http/Axois'
import {
  cearteOrder,
  CreateOrderModel,
  MyOrderModel,
  OrderListModel,
  Product, ProductBrand,
  ReadHistory,
  ShopCar, ShopCarDel, ShopClass, ShopTreeModel, ShopYouhui } from '../model'
import { promptAction } from '@kit.ArkUI'

export function GetShopClass(parentId:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,null>('/home/productCateList/'+parentId)
    .then((value)=>{
      return (value.data.data as Array<ShopClass>)
    })
}


export function GetShopClassIn(productCategoryId:number,pageNum:number,pageSize:number,sort:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,null>('/product/search',{
    params:{
      productCategoryId:productCategoryId,
      pageNum:pageNum,
      pageSize:pageSize,
      sort:sort
    }
  })
    .then((value)=>{
      return (value.data.data as ProductBrand)
    })
}

export function GetShopTree(){
  return axiosInstance.get<null,AxiosResponse<Message,null>,null>('/product/categoryTreeList')
    .then((value)=>{
      return (value.data.data as Array<ShopTreeModel>)
    })
}


export function GetShopYouHui(productId:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,null>('/member/coupon/listByProduct/'+productId)
    .then((value)=>{
      if ((value.data.data as Array<ShopYouhui>).length>0) {
        promptAction.showToast({
          message:'领取成功'
        })
      }else {
        promptAction.showToast({
          message:'暂无优惠券'
        })
      }
    })
}


export function AddShopCar(shop:ShopCar){
  return axiosInstance.post<null,AxiosResponse<Message,null>,ShopCar>('/cart/add',shop)
    .then((value)=>{
      if (value.data.code == 200) {
        promptAction.showToast({
          message:'success'
        })
      }
    })
    .catch((error:AxiosError)=>{
      console.info(`=====Error`+error)
    })
}

export function ShopCarList(){
  return axiosInstance.get<null,AxiosResponse<Message,null>,ShopCar>('/cart/list')
    .then((value)=>{
      return (value.data.data as Array<ShopCar>)
    })

}

export function ShopCarUpdate(id:number,quantity:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,ShopCar>('/cart/update/quantity',{
    params:{
      id:id,
      quantity:quantity
    }
  })
}

export function ShopCardelete(ids:ShopCarDel){
  return axiosInstance.post<null,AxiosResponse<Message,null>,ShopCarDel>('/cart/delete?ids='+ids.ids)
    .catch((err:AxiosError)=>{
      console.info(`====err`+err)
    })
}

export function ShopCarClear(){
  return axiosInstance.post<null,AxiosResponse<Message,null>,ShopCar>('/cart/clear')
}

export function CreateUserOrder(ids:number[]){
  return axiosInstance.post<null,AxiosResponse<Message,null>,number[]>('/order/generateConfirmOrder',ids)
    .then((value)=>{
      return (value.data.data as cearteOrder)
    })
}

export function CreateUserOrderEnd(order:CreateOrderModel){
  return axiosInstance.post<null,AxiosResponse<Message,null>,CreateOrderModel>('/order/generateOrder',order)
    .then((value)=>{
      console.info(`=====`+JSON.stringify(value.data))
      if (value.data.code == 500) {
        promptAction.showToast({
          message:value.data.message
        })
      }
      return (value.data.data as MyOrderModel)
    })
}

export function GetShopOrderList(status:number,pageNum:number,pageSize:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,null>('/order/list',{
    params:{
      status:status,
      pageNum:pageNum,
      pageSize:pageSize
    }
  })
    .then((value)=>{
      return (value.data.data as OrderListModel)
    })
}

export function CancelUserOrder(orderid:number){
  return axiosInstance.post<null,AxiosResponse<Message,null>,null>('/order/cancelUserOrder?orderId='+orderid)
}

export function PayOrder(orderId:number,payType:number){
  return axiosInstance.post<null,AxiosResponse<Message,null>,null>('/order/paySuccess?orderId='+orderId+'&payType='+payType)
    .then((value)=>{
      return value.data.message
    })
}

export function CouponList(useStatus:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,null>('/member/coupon/list?useStatus='+useStatus)
    .then((value)=>{
      return (value.data.data as Array<ShopYouhui>)
    })
}

export function CreateHistory(History:ReadHistory){
  return axiosInstance.post<null,AxiosResponse<Message,null>,ReadHistory>('/member/readHistory/create',History)
}

export function ReadProcuctCollection(productid:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,null>('/member/productCollection/detail?productId='+productid)
    .then((value)=>{
      return (value.data.data as ReadHistory)
    })
}

export function AddproductCollection(History:ReadHistory){
  return axiosInstance.post<null,AxiosResponse<Message,null>,ReadHistory>('/member/productCollection/add',History)
    .then((value)=>{
      if (value.data.code==200) {
        return true
      }else {
        return false
      }
    })
}

export function DelproductCollection(productId:number){
  return axiosInstance.post<null,AxiosResponse<Message,null>,null>('/member/productCollection/delete?productId='+productId)
    .then((value)=>{
      if (value.data.code==200) {
        return true
      }else {
        return false
      }
    })
}