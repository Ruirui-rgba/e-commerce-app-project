import { AxiosError, AxiosResponse } from '@ohos/axios'
import { axiosInstance, Message } from '../http/Axois'
import { MyFootModel, ReadHistory, UserAddress, UserLogin, UserRegister, UserToken } from '../model'

export function LoginDo(user:UserLogin){
  return axiosInstance.post<null,AxiosResponse<Message,null>,UserLogin>('/sso/login',user,{
    headers:{'Content-Type': 'application/x-www-form-urlencoded'}
  })
    .then((value)=>{
      if (value.data.code == 200) {
        let usertoken=(value.data.data as UserToken)
        axiosInstance.defaults.headers.common['authorization'] = usertoken.tokenHead+usertoken.token
        return true
      }else {
        return false
      }
    })
    .catch((error:AxiosError)=>{
      console.info(`=====`+JSON.stringify(error))
    })
}


export function RegisterDo(userregister:UserRegister){
  return axiosInstance.post<null,AxiosResponse<Message,null>,UserRegister>('/sso/register',userregister)
    .then((value)=>{
      if (value.data.code == 200) {
        return true
      }else {
        return false
      }
    })
}


export  function GetYanzheng(telephone:string){
  return axiosInstance.get<null,AxiosResponse<Message,null>,string>('/sso/getAuthCode',{
    params:{
      telephone:telephone
    }
  })
    .then((value)=>{
      return value.data.data as string
    })
}


export function UpdatePassword(userregister:UserRegister){
  return axiosInstance.post<null,AxiosResponse<Message,null>,UserRegister>('/sso/updatePassword',userregister)
    .then((value)=>{
      console.info('======='+value.data.data as string)
      // return (value.data.data )
    })
}

export  function RefreshToken(){
  return axiosInstance.get<null,AxiosResponse<Message,null>,null>('/sso/refreshToken')
    .then((value)=>{
      console.info('======='+value.data.data as string)
      // return (value.data.data )
    })
}

export  function GetInfo(){
  return axiosInstance.get<null,AxiosResponse<Message,null>,null>('/sso/info')
    .then((value)=>{
      console.info('======='+value.data.data as string)
      // return (value.data.data )
    })
}

export  function ShowAddressList(){
  return axiosInstance.get<null,AxiosResponse<Message,null>,null>('/member/address/list')
    .then((value)=>{
      return (value.data.data as Array<UserAddress>)
    })
}

export function AddAddress(address:UserAddress){
  return axiosInstance.post<null,AxiosResponse<Message,null>,UserAddress>('/member/address/add',address)
    .then((value)=>{
      return (value.data.code as number)
    })
}

export function DelAddress(id:number){
  return axiosInstance.post<null,AxiosResponse<Message,null>,UserAddress>('/member/address/delete/'+id)
    .then((value)=>{
      return (value.data.code as number)
    })
}

export  function GetAddressinfo(id:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,null>('/member/address/'+id)
    .then((value)=>{
      console.info('======='+JSON.stringify((value.data.data as UserAddress)))
      // return (value.data.data )
    })
}

export function UpdateAddress(id:number,address:UserAddress){
  return axiosInstance.post<null,AxiosResponse<Message,null>,UserAddress>('/member/address/update/'+id,address)
    .then((value)=>{
      return (value.data.code as number)
    })
}

export function MyfeetDo(pageNum:number,pageSize:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,string>('/member/readHistory/list',{
    params:{
      pageNum:pageNum,
      pageSize:pageSize
    }
  })
    .then((value)=>{
      return (value.data.data as MyFootModel)
    })
}

export function ClearMyFeet(){
  return axiosInstance.post<null,AxiosResponse<Message,null>,UserAddress>('/member/readHistory/clear')
    .then((value)=>{
      return (value.data.code as number)
    })
}

export function ClearMyBrand(){
  return axiosInstance.post<null,AxiosResponse<Message,null>,UserAddress>('/member/attention/clear')
    .then((value)=>{
      return (value.data.code as number)
    })
}

export function MyLoveProductDo(pageNum:number,pageSize:number){
  return axiosInstance.get<null,AxiosResponse<Message,null>,string>('/member/productCollection/list',{
    params:{
      pageNum:pageNum,
      pageSize:pageSize
    }
  })
    .then((value)=>{
      return (value.data.data as MyFootModel)
    })
}

export function ClearMyLoveProduct(){
  return axiosInstance.post<null,AxiosResponse<Message,null>,UserAddress>('/member/productCollection/clear')
    .then((value)=>{
      return (value.data.code as number)
    })
}