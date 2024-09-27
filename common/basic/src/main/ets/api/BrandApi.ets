import { AxiosResponse } from '@ohos/axios'
import { axiosInstance, Message } from '../http/Axois'
import { brand, LoveBrand, MyloveBrandModel, newProduct, Product, ProductBrand, ShopItem } from '../model'
import { promptAction } from '@kit.ArkUI'

export  function GetBrandList(pageNum:number,pageSize:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,string>('/brand/recommendList',{
    params:{
      pageNum:pageNum,
      pageSize:pageSize
    }
  })
    .then((value)=>{
        return (value.data.data as Array<brand>)
    })
}
export function GetBrandDetail(brandId:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,null>('/brand/detail/'+brandId)
    .then((value)=>{
      return (value.data.data as brand)
    })
}

export function GetBrandProduct(brandId:number,pageNum:number,pageSize:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,null>('/brand/productList/',{
    params:{
      brandId:brandId,
      pageNum:pageNum,
      pageSize:pageSize
    }
  })
    .then((value)=>{
      return (value.data.data as ProductBrand)
    })
}


export function GetShopItemInfo(id:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,null>('/product/detail/'+id)
    .then((value)=>{
      return (value.data.data as ShopItem)
    })
}

export  function GetNewBrandIndex(pageNum:number,pageSize:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,string>('/home/newProductList',{
    params:{
      pageNum:pageNum,
      pageSize:pageSize
    }
  })
    .then((value)=>{
      return (value.data.data as Array<newProduct>)
    })
}


export  function GetHotBrandIndex(pageNum:number,pageSize:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,string>('/home/hotProductList',{
    params:{
      pageNum:pageNum,
      pageSize:pageSize
    }
  })
    .then((value)=>{
      return (value.data.data as Array<newProduct>)
    })
}


export  function GetMeybeLoveList(pageNum:number,pageSize:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,string>('/home/recommendProductList',{
    params:{
      pageNum:pageNum,
      pageSize:pageSize
    }
  })
    .then((value)=>{
      return (value.data.data as Array<Product>)
    })
}

export function AddAttentionBrand(brand:LoveBrand){
  return axiosInstance.post<null,AxiosResponse<Message,null>,string>('/member/attention/add')
    .then((value)=>{
      if (value.data.code == 200) {
        promptAction.showToast({
          message:'success add'
        })
      }else {
        promptAction.showToast({
          message:'error add'
        })
      }
      // return (value.data.data as Array<Product>)
    })
}

export function DelBrandLove(id:number){
  return axiosInstance.post<null,AxiosResponse<Message,null>,string>('/member/attention/delete?brandId='+id)
    .then((value)=>{
      return value.data.code
    })
}

export  function GetMyAttentionBrand(id:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,string>('/member/attention/detail?brandId='+id)
    .then((value)=>{
      return (value.data.data as LoveBrand)
    })
}

export function LoveBrandList(pageNum:number,pageSize:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,string>('/member/attention/list',{
    params:{
      pageNum:pageNum,
      pageSize:pageSize
    }
  })
    .then((value)=>{
      return (value.data.data as MyloveBrandModel)
    })
}
