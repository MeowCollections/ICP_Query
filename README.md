# ICP_Query 2023/12/9 可用

#### 1.（自动打码）20231209版本，增加了一个自己训练的效果不怎么样的检测模型（为了轻便，采用移动端配置训练的模型，并且只准备了少量数据集进行训练），基本上可以进行自动打码
1. 下载2023-12-9_auto_icp-Api.zip，整包大小12.9MB
2. 解压文件，切换到icp_Api
3. 安装依赖：pip install -r requirements.txt
4. 运行Api：python icpApi.py
5. 实测在该配置 Linux Centos7.2  1(cpu)  1G(RAM) 上至少可以同时运行3个进程(不同端口)

#### 2.（手动打码）20231130修复版本，只提供手动点选验证码，可接入其他打码平台或自行实现，按照small_selice方法返回对应参数即可
1. 下载icpApi.py和ymicp.py
2. 安装requirements.txt中的依赖即可

### 关于本项目
1. ICP备案查询，基于Python3.8，全异步构建的高性能ICP查询模块，支持分页查询
2. 直接从工业和信息化部政务服务平台抓取实时数据，支持Web、APP、小程序、快应用名称查询
3. 支持根据备案号查询，支持根据企业名称查询，支持违法违规域名、APP查询
4. 提供简单易用的高性能接口以及发行版程序
5. 健壮的代码以及内部错误处理机制，确保所有响应都是可解析的
6. 内置解决前端跨域问题

### 安装依赖
``` shell
# 可以使用低版本包，基本都包含需要的模块
pip install -r requirements.txt
```

### 使用查询模块
``` python
import asyncio
from ymicp import beian

async def main(name):
    icp = beian()
    query = await icp.ymApp(name)
    print(query)

asyncio.run(main("微信"))
```

### 使用icpApi查询接口
##### 1. 支持八种类型查询：
- 网站：web
- APP：app
- 小程序：mapp
- 快应用：kapp
- 违法违规网站：bweb
- 违法违规APP：bapp
- 违法违规小程序：bmapp
- 违法违规快应用：bkapp
##### 2. 请求
1. GET
    - URL: http://0.0.0.0:16181/query/{type}?search={name}
    - 示例: 查询域名 baidu.com 备案信息
      
        ```
        curl http://127.0.0.1:16181/query/web?search=baidu.com
        ```
    - 示例: 根据网站的备案号 京ICP证030173号 查询备案信息
      
        ```
        curl http://127.0.0.1:16181/query/web?search=京ICP证030173号
        ```
    - 示例: 根据企业名称查询备案信息
      
        ```
        curl http://127.0.0.1:16181/query/web?search=深圳市腾讯计算机系统有限公司
        ```
    - 示例: 根据企业名称查询备案信息，每页20条数据，查询第3页
      
        ```
        curl http://127.0.0.1:16181/query/web?search=深圳市腾讯计算机系统有限公司&pageNum=3&pageSize=20
        ```
2. POST
   - headers : {"Content-Type": "application/json"}
   - URL: http://0.0.0.0:16181/query/{type}
   - Body: {"search": {name}}
   - 示例: 查询域名 baidu.com 备案信息
     
        ```
        curl -X POST -H "Content-Type: application/json" -d '{"search":"baidu.com"}' http://127.0.0.1:16181/query/web
        ```
    - 示例: 根据网站的备案号 京ICP证030173号 查询备案信息
      
        ```
        curl -X POST -H "Content-Type: application/json" -d '{"search":"京ICP证030173号"}' http://127.0.0.1:16181/query/web
        ```
    - 示例: 根据企业名称查询备案信息
      
        ```
        curl -X POST -H "Content-Type: application/json" -d '{"search":"深圳市腾讯计算机系统有限公司"}' http://127.0.0.1:16181/query/web
        ```
    - 示例: 根据企业名称查询备案信息，每页20条数据，查询第3页
      
        ```
        curl -X POST -H "Content-Type: application/json" -d '{"search":"深圳市腾讯计算机系统有限公司","pageNum":3,"pageSize":20}' http://127.0.0.1:16181/query/web
        ```

##### 3. Linux 运行icpApi
1. 源代码运行
   
    ``` shell
    python3 icpApi.py
    ```
2. 独立程序运行
   
    ``` shell
    ./icpApi.bin
    ```
##### 4. Windows 运行icpApi
1. 源代码运行
   
    ``` cmd
    python3 icpApi.py
    ```
2. 独立程序直接双击运行

##### 5. 直接使用在线API
[API文档](http://api.wer.plus/inteface?id=6)

### 参数说明
|  参数             |  说明                |
|  ----  | ----  |
|  lastPage         |  据查询数量有多少页  |
|  pages            |  同lastPage          |
|  pageSize         |  每页几条数据        |
|  pageNum          |  第几页              |
|  nextPage         |  下一页的页面序号    |
|  total            |  同pages             |
|  domain           |  备案的域名          |
|  domainId         |  域名id              |
|  limitAccess      |  是否限制接入        |
|  mainLicence      |  ICP备案主体许可证号 |
|  natureName       |  主办单位性质        |
|  serviceLicence   |  ICP备案服务许可证号 |
|  unitName         |  主办单位名称        |
|  updateRecordTime |  审核通过日期        |
|  contentTypeName  |  服务前置审批项      |
|  cityId           |  城市ID             |
|  countyId         |  区县ID             |
|  contentTypeName  |  内容类型           |
|  mainUnitAddress  |  主体地址           |
|  serviceName      |  服务名称(APP、小程序或快应用名称)  |
|  version          |  服务版本           |
|  blackListLevel  | 威胁等级,表示是否为违法违规应用，目前获得的等级为2时，表示暂无违法违规信息 |

    
### 请喝茶吗

| 支付宝                                                                                     | 微信                                                                                    | 群                |
| --------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- | ---------------- |
| <img src="https://github.com/HG-ha/qinglong/blob/main/zfb.jpg?raw=true" title="" alt="zfb" width="120px" height="120px"> | <img title="" src="https://github.com/HG-ha/qinglong/blob/main/wx.png?raw=true" alt="wx" width="120px" height="120px"> | 一铭API：1029212047 |
|                                                                                       |                                                                                       | 镜芯科技：376957298   |



### 其他项目

[一铭API](https://api.wer.plus)
