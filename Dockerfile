#基于的基础镜像
FROM python:3.8.7
ADD ./icp_Api /icp_Api
WORKDIR /icp_Api
RUN echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main non-free contrib' > /etc/apt/sources.list \
    && echo 'deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main' >> /etc/apt/sources.list \
    && echo 'deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main' >> /etc/apt/sources.list \
    && echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main non-free contrib' >> /etc/apt/sources.list \
    && apt-get update \
    #&& apt-get upgrade -y \ 
    && apt-get install libgl1 -y \
    && pip install -r /icp_Api/requirements.txt -i https://mirror.baidu.com/pypi/simple
EXPOSE 16181
CMD ["python3", "/icp_Api/icpApi.py"]
