# MULTISTAGED NOPCOMMERCE.
  ```Dockerfile
  #MULTISTAGED
FROM ubuntu:22.04 AS installer
ADD https://github.com/nopSolutions/nopCommerce/releases/download/release-4.60.2/nopCommerce_4.60.2_NoSource_linux_x64.zip /nopCommerce/nopCommerce_4.60.2_NoSource_linux_x64.zip
WORKDIR /nopCommerce
RUN apt update && apt install unzip -y && \
    unzip /nopCommerce/nopCommerce_4.60.2_NoSource_linux_x64.zip && \
    mkdir /nopCommerce/bin && mkdir /nopCommerce/logs


FROM mcr.microsoft.com/dotnet/sdk:7.0
COPY --from=installer /nopCommerce /nopCommerce
WORKDIR /nopCommerce
EXPOSE 5000
CMD [ "dotnet", "Nop.Web.dll","--urls", "http://0.0.0.0:5000" ]
  ```

```
docker build -t nop:1 .
docker container -d -P nop:1
```

![preview](images/nop1.png)
