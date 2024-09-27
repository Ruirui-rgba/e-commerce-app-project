import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'


export const baseUrl:string='http://1.94.234.24:8085'
export const axiosInstance = axios.create({
  baseURL: baseUrl
});

export interface  Message{
  code?:number;
  message: string;
  total: number;
  data: object|string
}

// axiosInstance.interceptors.request.use((config:InternalAxiosRequestConfig)=> {
//   // 此处可以将数据进行加密
//   // data为数据body 一般是post方法   params为字段 一般就是get方法有的
//   console.info(`config拦截器:${JSON.stringify(config)}`)
//   return config
// },(error:AxiosError)=>{
//   return error
// })
//
// axiosInstance.interceptors.response.use((response:AxiosResponse)=> {
//   // 此处可以对数据进行解密
//   return response;
// }, (error:AxiosError)=> {
//   // 对响应错误做点什么
//   return Promise.reject(error);
// })